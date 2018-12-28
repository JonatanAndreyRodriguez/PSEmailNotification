function Add-Process {
    <# 
.SYNOPSIS
Registra procesos de notificación.

.PARAMETER Name
Nombre descriptivo del proceso de notificación.

.PARAMETER IdTemplate
Identificador de la plantilla asociada al proceso. Este valor se debe buscar con Get-Template.

.PARAMETER SmtpKeyName
Nombre clave de la configuración de buzón de correo saliente presente en el equipo. Se obtiene con Get-SmtpConnection.

.INPUTS
Identificador numérico de una plantilla previamente registrada (IdTemplate). Lo puede recibir en forma de HashTable.

.EXAMPLE
C:\PS> Add-Process -Name 'NombreDelProceso' -IdTemplate 99 -SmtpKeyName 'NombreClaveSmtp'

.EXAMPLE
C:\PS> Get-Template -Name 'NombrePlantilla' | Add-Process -Name 'NombreDelProceso' -SmtpKeyName 'NombreClaveSmtp'

.LINK
[Get-Template](Get-Template.md)
[Get-SmtpConnection](Get-SmtpConnection.md)
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
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String]$Name,

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {Test-Template -IdTemplate $PSItem})]
        [Int]$IdTemplate,
        
        [Parameter(HelpMessage = 'Valor de llave de Smtp obtenido de Get-SmtpConnection')]
        [String]$SmtpKeyName
    )
    $Config = Get-Configuration
    
    # Agrega un proceso.
    try {
        if (-not (Test-Template -IdTemplate $IdTemplate)) {
            throw "No existe una plantilla con el identificador: $IdTemplate"
        }
        # Validar que existe el SmtpKeyName enviado
        if ($null -ne $SmtpKeyName -and '' -ne $SmtpKeyName) {
            if ($null -eq (Get-SmtpConnection -Name $SmtpKeyName)) {
                throw "No existe la llave de Smtp: '$SmtpKeyName'"
            }
        }        
        Invoke-SqliteQuery -Query $Config.SqlAddProcessStatement -DataSource $Script:DBFilePath -SqlParameters @{
            Author      = $env:USERNAME
            Date        = Get-Date -Format $Config.SqlDateFormat
            Name        = $Name
            IdTemplate  = $IdTemplate
            SmtpKeyName = $SmtpKeyName
        } -ErrorAction 'Stop'
        Write-Log -Message "Se creó el proceso: $Name" -Level Information
    }
    catch {
        Write-Log -ErrorRecord $PSItem
        throw
    }
}