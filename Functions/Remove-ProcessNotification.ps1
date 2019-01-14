function Remove-ProcessNotification {
    <# 
.SYNOPSIS
Borra al menos un proceso de notificaci�n de acuerdo a su identificador o nombre.

.PARAMETER Name
Nombre del proceso de notificaci�n a eliminar. Se permite usar el asterisco (*) como caracter comod�n.
No se puede utilizar junto con el par�metro IdProcess.

.PARAMETER IdProcess
Identificador del proceso de notificaci�n a eliminar. No se puede utilizar junto con el par�metro Name.

.EXAMPLE
Remove-ProcessNotification '*'
Borra todos los procesos registrados.

.EXAMPLE
Remove-ProcessNotification -Name 'NombreClaveDelProceso'
Borra el proceso de notificaci�n cuyo nombre sea igual a 'NombreClaveDelProceso'.

.EXAMPLE
Remove-ProcessNotification -Name '*Cliente*'
Borra todos los procesos cuyo nombre contenga la palabra 'Cliente'.

.EXAMPLE
Remove-ProcessNotification -IdProcess 99
Borra el proceso de notificaci�n cuyo identificador sea igual a 99.

.LINK
[Add-ProcessNotification](Add-ProcessNotification.md)
[Get-ProcessNotification](Get-ProcessNotification.md)
[Remove-ProcessNotification](Remove-ProcessNotification.md)
[Update-ProcessNotification](Update-ProcessNotification.md)

.NOTES
-- ================================================================================================================
-- Author       : Manuel Vera Benedetti
-- Create date  : 07/12/2018
-- Gemini       : WBS3.1-26072 Automatizaci�n de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================
#>
    [CmdletBinding()]
    [OutputType([System.Void])]
    param(
        [Parameter(Position = 0, ValueFromPipelineByPropertyName, ParameterSetName = 'NameSet',
            HelpMessage = "Nombre del proceso de notificaci�n. Acepta asterisco (*) como comod�n.")]
        [SupportsWildcards()]
        [String]$Name,

        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'IdSet',
            HelpMessage = "Identificador del proceso de notificaci�n.")]
        [Int]$IdProcess
    )
    $Config = Get-Configuration
    
    # Elimina procesos.
    try {
        if ($PSCmdlet.ParameterSetName -eq 'NameSet') {
            $Arguments = @{
                IdProcess = $null
                Name      = ($Name -replace '[*]', '%') -replace '[?]', '_'
            }
            $Mensaje = "Se eliminaron los procesos con el nombre: $Name"
        }
        if ($PSCmdlet.ParameterSetName -eq 'IdSet') {
            $Arguments = @{
                IdProcess = $IdProcess
                Name      = $null
            }
            $Mensaje = "Se elimin� el proceso con el identificador: $IdProcess"
        }
        [PSCustomObject]$Arguments | Remove-Recipient -Email '*'
        Invoke-SqliteQuery -Query $Config.SqlRemoveProcessStatement -DataSource $Script:DBFilePath -SqlParameters $Arguments -ErrorAction 'Stop'
        Write-Log -Message $Mensaje -Level Information
    }
    catch {
        Write-Log -ErrorRecord $PSItem
        throw
    }
}