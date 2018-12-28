function Remove-Template {
    <# 
.SYNOPSIS
Borra al menos una plantilla de correo de acuerdo a su identificador o nombre.

.PARAMETER IdTemplate
Identificador de la plantilla de correo electrónico a eliminar. No se puede utilizar junto con el parámetro Name.

.PARAMETER Name
Nombre de la plantilla de correo electrónico a eliminar. Se permite usar el asterisco (*) como caracter comodín.
No se puede utilizar junto con el parámetro IdTemplate.

.EXAMPLE
C:\PS> Remove-Template '*'
Borra todas las plantillas registradas.

.EXAMPLE
C:\PS> Remove-Template -Name 'NombreClaveDeLaPlantilla'
Borra la plantilla cuyo nombre sea igual a 'NombreClaveDeLaPlantilla'.

.EXAMPLE
C:\PS> Remove-Template -Name '*Cliente*'
Borra todas las plantillas cuyo nombre contenga la palabra 'Cliente'.

.EXAMPLE
C:\PS> Remove-Template -IdTemplate 99
Borra la plantilla cuyo identificador sea igual a 99.

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
        [Parameter(Position = 0, ValueFromPipelineByPropertyName, ParameterSetName = 'NameSet',
            HelpMessage = "Nombre de la plantilla. Acepta asterisco (*) como comodín.")]
        [SupportsWildcards()]
        [String]$Name,

        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'IdSet',
            HelpMessage = "Identificador de la plantilla.")]
        [Int]$IdTemplate
    )
    $Config = Get-Configuration
    
    # Elimina plantillas.
    try {
        if ($PSCmdlet.ParameterSetName -eq 'NameSet') {
            $Arguments = @{
                IdTemplate = $null
                Name       = ($Name -replace '[*]', '%') -replace '[?]', '_'
            }
            $MessageLog = "Se eliminó la plantilla con nombre: $Name"
        }
        if ($PSCmdlet.ParameterSetName -eq 'IdSet') {
            $Arguments = @{
                IdTemplate = $IdTemplate
                Name       = $null
            }
            $MessageLog = "Se eliminó la plantilla con identificador: $IdTemplate"
        }
        Invoke-SqliteQuery -Query $Config.SqlRemoveTemplateStatement -DataSource $Script:DBFilePath -SqlParameters $Arguments -ErrorAction 'Stop'
        Write-Log -Message $MessageLog -Level Information
    }
    catch {
        Write-Log -ErrorRecord $PSItem
        throw
    }
}