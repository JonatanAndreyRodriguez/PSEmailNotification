function Add-Template {
    <# 
.SYNOPSIS
Registra plantillas de correo en formato HTML: nombre descriptivo, ruta de la plantilla en disco y asunto del correo.

.DESCRIPTION
Se agregan plantillas de correo electr�nico al m�dulo. El nombre debe ser �nico, de lo contrario, se genera un error.

.PARAMETER Name
Nombre descriptivo de la plantilla de correo electr�nico.

.PARAMETER Path
Ruta compuesta de directorios y nombre del archivo donde se encuentra la plantilla de correo electr�nico en formato HTML.

.PARAMETER Subject
Asunto o t�tulo con el que ser� enviado el correo electr�nico.

.EXAMPLE
Add-Template -Name 'NombreClaveDeLaPlantilla' -Path 'c:\ruta\plantilla.html' -Subject 'Titulo del correo'

.LINK
[Add-Template](Add-Template.md)
[Get-Template](Get-Template.md)
[Remove-Template](Remove-Template.md)
[Update-Template](Update-Template.md)

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
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Name,
        
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {Test-Path -Path $PSItem -PathType Leaf})]
        [String]
        $Path,
        
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Subject
    )
    $Config = Get-Configuration
    
    try {
        $NewTemplateFile = Add-File -PathFile $Path
        Invoke-SqliteQuery -Query $Config.SqlAddTemplateStatement -DataSource $Script:DBFilePath -SqlParameters @{
            Author     = $env:USERNAME
            Date       = Get-Date -Format $Config.SqlDateFormat
            Name       = $Name
            File       = $NewTemplateFile
            Subject    = $Subject
            IdTemplate = $Null
        } -ErrorAction 'Stop'
        Write-Log -Message "Se cre� la plantilla: $Name" -Level Information
    }
    catch {
        Write-Log -ErrorRecord $PSItem
        throw
    }
}