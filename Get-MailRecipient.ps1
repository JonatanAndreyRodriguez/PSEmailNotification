function Get-MailRecipient {
    <# 
.SYNOPSIS
Obtiene al menos un correo electrónico de acuerdo a su identificador o correo.

.PARAMETER Email
Correo electrónico buscado. Se permite usar el asterisco (*) como caracter comodín.
No se puede utilizar junto con el parámetro IdMailRecipient.

.PARAMETER IdMailRecipient
Identificador del correo electrónico buscado. No se puede utilizar junto con el parmetro Email.

.EXAMPLE
C:\PS> Get-MailRecipient -IdMailRecipient 99
Lista el correo electrónico cuyo identificador sea igual a 99.

.EXAMPLE
C:\PS> Get-MailRecipient -Email *
Lista todos los correos electrónicos registrados.

.EXAMPLE
C:\PS> Get-MailRecipient -Email '*@dominio.com'
Lista todos los correos electrónicos que contengan el texto '@dominio.com'.

.EXAMPLE
C:\PS> Get-MailRecipient -Email 'nombre@dominio.com'
Lista el correo electrónico que sea igual al valor indicado.

.LINK
[Get-MailRecipient](Get-MailRecipient.md)
[Add-Recipient](Add-Recipient.md)
[Remove-Recipient](Remove-Recipient.md)

.NOTES
    -- ================================================================================================================
    -- Author       : Manuel Vera Benedetti
    -- Create date  : 07/12/2018
    -- Gemini       : WBS3.1-26072  Subtarea BD - Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
    -- ================================================================================================================
#>
    [CmdletBinding(DefaultParameterSetName = 'EmailSet')]
    [OutputType([System.Void])]
    param(
        [Parameter(ParameterSetName = 'EmailSet',
            HelpMessage = "Correo electrónico a buscar. Acepta asterisco (*) como comodín.")]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [String]$Email = '*',

        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'IdSet',
            HelpMessage = "Identificador del correo electrónico.")]
        [ValidateNotNullOrEmpty()]
        [Int]$IdMailRecipient
    )

    begin {
        $Config = Get-Configuration
    }

    process {
        # Busca correo electrónico.
        try {
            if ($PSCmdlet.ParameterSetName -eq 'EmailSet') {
                $Arguments = @{
                    IdMailRecipient = $null
                    Email           = (($Email -replace '[*]', '%') -replace '[?]', '_')
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'IdSet') {
                $Arguments = @{
                    IdMailRecipient = $IdMailRecipient
                    Email           = $null
                }
            }
            Invoke-SqliteQuery -Query $Config.SqlGetMailRecipientStatement -DataSource $Script:DBFilePath -SqlParameters $Arguments -ErrorAction 'Stop'
        }
        catch {
            Write-Log -ErrorRecord $PSItem
            throw
        }
    }

    end {}
}