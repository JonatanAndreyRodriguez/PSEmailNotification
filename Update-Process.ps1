function Update-Process {
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
C:\PS> Update-Process -IdProcess 99 -Name 'NombreDelProceso' -IdTemplate 99 -SmtpKeyName 'NombreClaveSmtp'

Se actualiza el proceso cuyo identificador sea 99 con los valores dados a Name, IdTemplate y SmtpKeyName

.LINK
Get-Template
Get-SmtpConnection
[Add-Process](Add-Process.md)
[Get-Process](Get-Process.md)
[Remove-Process](Remove-Process.md)
[Update-Process](Update-Process.md)

.NOTES
    -- ================================================================================================================
    -- Author       : Manuel Vera Benedetti
    -- Create date  : 07/12/2018
    -- Gemini       : WBS3.1-26072  Subtarea BD - Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
    -- ================================================================================================================
#>

    [CmdletBinding()]
    [OutputType([System.Void])]
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [String]$IdProcess,
        
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [String]$Name,
        
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {Test-Template -IdTemplate $PSItem})]
        [Int]$IdTemplate,
        
        [Parameter(Mandatory, ValueFromPipelineByPropertyName
            , HelpMessage = 'Debe especificar un valor válido obtenido de Get-SmtpConnection')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {$null -ne (Get-SmtpConnection -Name $PSItem)})]
        [String]$SmtpKeyName
    )
    $Config = Get-Configuration
    
    # Actualiza un proceso.
    try {
        Invoke-SqliteQuery -Query $Config.SqlUpdateProcessStatement -DataSource $Script:DBFilePath -SqlParameters @{
            Author      = $env:USERNAME
            Date        = Get-Date -Format $Config.SqlDateFormat
            IdProcess   = $IdProcess
            Name        = $Name
            IdTemplate  = $IdTemplate
            SmtpKeyName = $SmtpKeyName
        } -ErrorAction 'Stop'
        Write-Log -Message "Ha sido actualizado el proceso con identificador: $IdProcess" -Level Information
    }
    catch {
        Write-Log -ErrorRecord $PSItem
        throw
    }
}