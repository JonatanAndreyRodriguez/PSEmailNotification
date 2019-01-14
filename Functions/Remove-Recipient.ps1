function Remove-Recipient {
    <# 
.SYNOPSIS
Borra al menos un recipiente de acuerdo a su identificador de proceso y/o correo electr�nico.

.PARAMETER IdProcess
Identificador del proceso de notificaci�n donde se desea eliminar recipientes.

.PARAMETER Email
Direcci�n de correo electr�nico que se desea eliminar.

.EXAMPLE
Remove-Recipient -IdProcess 99
Remove-Recipient -IdProcess 99 -Email '*'
Borra todos los recipientes para el proceso de notificaci�n cuyo identificador es 99.

.EXAMPLE
Remove-Recipient -IdProcess 88 -Email 'usuario@dominio.com'
Borra el recipiente indicado para el proceso de notificaci�n cuyo identificador es 88.

.LINK
[Get-ProcessNotification](Get-ProcessNotification.md)
[Get-Recipient](Get-Recipient.md)
[Add-Recipient](Add-Recipient.md)
[Remove-Recipient](Remove-Recipient.md)

.NOTES
-- ================================================================================================================
-- Author       : Manuel Vera Benedetti
-- Create date  : 11/12/2018
-- Gemini       : WBS3.1-26072 Automatizaci�n de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================
#>
    [CmdletBinding()]
    [OutputType([System.Void])]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [Int]
        $IdProcess,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [String]
        $Email = ''
        
    )
    $Config = Get-Configuration
  
    try { 
               
        if ($Email -eq '') {
            $Mensaje = "Se eliminaron todos los correos destinatarios del proceso: $IdProcess"
        }
        else{
            $Mensaje = "Se elimino el correo destinatario: ($Email) del proceso: $IdProcess"
        }
        $Arguments = @{
            IdProcess = $IdProcess
            Email     = $null           
        }
       
        $Exist = Invoke-SqliteQuery -Query $Config.SqlGetRecipientStatement -DataSource $Script:DBFilePath -SqlParameters $Arguments -ErrorAction 'Stop'
        if ($Exist) {
            Invoke-SqliteQuery -Query $Config.SqlRemoveRecipientStatement -DataSource $Script:DBFilePath -SqlParameters @{
                IdProcess = $IdProcess
                Email     =  Invoke-Ternary {$Email -eq ''} {[System.DBNull]::Value} {$Email};
            } -ErrorAction 'Stop'          
            Write-Log -Message  $Mensaje -Level Information
        }
    }
    catch {
        Write-Log -ErrorRecord $PSItem
        throw
    }
}