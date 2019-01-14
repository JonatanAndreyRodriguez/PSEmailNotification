function Get-Recipient {
    <# 
.SYNOPSIS
Obtiene los correos electrónicos registrados de acuerdo a su filtro por identificador de proceso o correo.

.PARAMETER IdProcess
Identificador del proceso del que se desea conocer los correos electrónicos relacionados.

.PARAMETER Email
Correo electrónico buscado. Se permite usar el asterisco (*) como caracter comodín.
No se puede utilizar junto con el parámetro IdProcess.

.EXAMPLE
Get-Recipient -IdProcess 99
Lista los correos electrónicos relacionados al proceso cuyo identificador sea igual a 99.

.EXAMPLE
Get-Recipient -Email *
Lista todos los correos electrónicos registrados.

.EXAMPLE
Get-Recipient -Email '*@dominio.com'
Lista todos los correos electrónicos que contengan el texto '@dominio.com'.

.EXAMPLE
Get-Recipient -Email 'nombre@dominio.com'
Lista el correo electrónico que sea igual al valor indicado.

.LINK
[Get-Recipient](Get-Recipient.md)
[Add-Recipient](Add-Recipient.md)
[Remove-Recipient](Remove-Recipient.md)

.NOTES
-- ================================================================================================================
-- Author       : Manuel Vera Benedetti
-- Create date  : 07/12/2018
-- Gemini       : WBS3.1-26072 Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================
#>
    [CmdletBinding(DefaultParameterSetName = 'EmailSet')]
    [OutputType([System.Void])]
    param(
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'IdSet')]
        [ValidateNotNullOrEmpty()]
        [Int]
        $IdProcess,

        [Parameter(ParameterSetName = 'EmailSet',
            HelpMessage = "Correo electrónico a buscar. Acepta asterisco (*) como comodín.")]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [String]
        $Email = '*'
        
    )
    $Config = Get-Configuration
  
    try {        
        if ($PSCmdlet.ParameterSetName -eq 'EmailSet') {
            $Arguments = @{
                IdProcess = $null
                Email     = (($Email -replace '[*]', '%') -replace '[?]', '_')                
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'IdSet') {
            $Arguments = @{
                IdProcess = $IdProcess
                Email     = $null
            }
        }
        Invoke-SqliteQuery -Query $Config.SqlGetRecipientStatement -DataSource $Script:DBFilePath -SqlParameters $Arguments -ErrorAction 'Stop'
    }
    catch {
        Write-Log -ErrorRecord $PSItem
        throw
    }

}