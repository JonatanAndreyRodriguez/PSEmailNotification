function Get-Recipient {
    <# 
.SYNOPSIS
Obtiene los correos electr�nicos registrados de acuerdo a su filtro por identificador de proceso o correo.

.PARAMETER IdProcess
Identificador del proceso del que se desea conocer los correos electr�nicos relacionados.

.PARAMETER Email
Correo electr�nico buscado. Se permite usar el asterisco (*) como caracter comod�n.
No se puede utilizar junto con el par�metro IdProcess.

.EXAMPLE
Get-Recipient -IdProcess 99
Lista los correos electr�nicos relacionados al proceso cuyo identificador sea igual a 99.

.EXAMPLE
Get-Recipient -Email *
Lista todos los correos electr�nicos registrados.

.EXAMPLE
Get-Recipient -Email '*@dominio.com'
Lista todos los correos electr�nicos que contengan el texto '@dominio.com'.

.EXAMPLE
Get-Recipient -Email 'nombre@dominio.com'
Lista el correo electr�nico que sea igual al valor indicado.

.LINK
[Get-Recipient](Get-Recipient.md)
[Add-Recipient](Add-Recipient.md)
[Remove-Recipient](Remove-Recipient.md)

.NOTES
-- ================================================================================================================
-- Author       : Manuel Vera Benedetti
-- Create date  : 07/12/2018
-- Gemini       : WBS3.1-26072 Automatizaci�n de Notificaciones de Cargue de Clientes y Realce de Tarjetas
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
            HelpMessage = "Correo electr�nico a buscar. Acepta asterisco (*) como comod�n.")]
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