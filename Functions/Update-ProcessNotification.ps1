function Update-ProcessNotification {
    <# 
.SYNOPSIS
Actualiza procesos de notificación.

.PARAMETER IdProcess
Identificador del proceso de notificación.

.PARAMETER Name
Nombre descriptivo del proceso de notificación.

.PARAMETER IdTemplate
Identificador de la plantilla asociada al proceso. Este valor se debe buscar con Get-Template.

.PARAMETER SmtpKeyName
Nombre clave de la configuración de buzón de correo saliente presente en el equipo. Se obtiene con Get-SmtpConnection.

.EXAMPLE
Update-ProcessNotification -IdProcess 2 -Name 'ProcesoDosModificado'

.EXAMPLE
Update-ProcessNotification -IdProcess 3 -IdTemplate 1

.EXAMPLE
Update-ProcessNotification -IdProcess 3 -IdTemplate 3 -SmtpKeyName 'SmtpDesarrollo'

.EXAMPLE
Update-ProcessNotification -IdProcess 3 -IdTemplate 3 -SmtpKeyName ''

.EXAMPLE
Update-ProcessNotification -IdProcess 3 -Name 'ProcesoDosListo1'

.LINK
Get-Template
Get-SmtpConnection
[Add-ProcessNotification](Add-ProcessNotification.md)
[Get-ProcessNotification](Get-ProcessNotification.md)
[Remove-ProcessNotification](Remove-ProcessNotification.md)
[Update-ProcessNotification](Update-ProcessNotification.md)

.NOTES
-- ================================================================================================================
-- Author       : Manuel Vera Benedetti
-- Create date  : 07/12/2018
-- Gemini       : WBS3.1-26072 Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================
#>
    [CmdletBinding()]
    [OutputType([System.Void])]
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [String]
        $IdProcess,
        
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [String]
        $Name = '',
        
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {Test-Template -IdTemplate $PSItem})]
        [Int]
        $IdTemplate = 0,
        
        [Parameter(HelpMessage = 'Debe especificar un valor válido obtenido de Get-SmtpConnection')]
        [String]
        $SmtpKeyName = '*'
    )
    $Config = Get-Configuration
    
    try {
        Invoke-SqliteQuery -Query $Config.SqlUpdateProcessStatement -DataSource $Script:DBFilePath -SqlParameters @{           
            IdProcess   = $IdProcess
            Name        = Invoke-Ternary {$Name -eq ''} {[System.DBNull]::Value} {$Name};
            IdTemplate  = Invoke-Ternary {$IdTemplate -eq 0} {[System.DBNull]::Value} {$IdTemplate};
            SmtpKeyName = Invoke-Ternary {$SmtpKeyName -eq '*'} {[System.DBNull]::Value} {$SmtpKeyName};
            Author      = $env:USERNAME
            Date        = Get-Date -Format $Config.SqlDateFormat
        } -ErrorAction 'Stop'
        Write-Log -Message "Ha sido actualizado el proceso con identificador: $IdProcess" -Level Information
    }
    catch {
        Write-Log -ErrorRecord $PSItem
        throw
    }
}