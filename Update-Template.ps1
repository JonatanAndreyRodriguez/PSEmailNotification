function Update-Template {
    <# 
.SYNOPSIS
Actualiza plantillas de correo en formato HTML: nombre descriptivo, ruta de la plantilla en disco y asunto del correo.

.PARAMETER IdTemplate
Identificador de la plantilla de correo electrónico.

.PARAMETER Name
Nombre descriptivo de la plantilla de correo electrónico.

.PARAMETER Path
Ruta compuesta de directorios y nombre del archivo donde se encuentra la plantilla de correo electrónico en formato HTML.

.PARAMETER Subject
Asunto o título con el que será enviado el correo electrónico.

.EXAMPLE
C:\PS> Update-Template -IdTemplate 99 -Name 'NombreClaveDeLaPlantilla' -Path 'c:\ruta\plantilla.html' -Subject 'Titulo del correo'
Se actualiza la plantilla cuyo identificador sea 99 con los valores dados a Name, Path y Subject

.LINK
[Add-Template](Add-Template.md)
[Get-Template](Get-Template.md)
[Remove-Template](Remove-Template.md)
[Update-Template](Update-Template.md)

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
        [String]$IdTemplate,
        
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [String]$Name,
        
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {Test-Path -Path $PSItem -PathType Leaf})]
        [String]$Path,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [String]$Subject
    )
    $Config = Get-Configuration
    
    # Actualiza una plantilla.
    try {
        Invoke-SqliteQuery -Query $Config.SqlUpdateTemplateStatement -DataSource $Script:DBFilePath -SqlParameters @{
            Author     = $env:USERNAME
            Date       = Get-Date -Format $Config.SqlDateFormat
            IdTemplate = $IdTemplate
            Name       = $Name
            Path       = $Path
            Subject    = $Subject
        } -ErrorAction 'Stop'
        Write-Log -Message "Ha sido actualizada la plantilla con identificador: $IdTemplate" -Level Information
    }
    catch {
        Write-Log -ErrorRecord $PSItem
        throw
    }
}