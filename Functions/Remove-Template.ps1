function Remove-Template {
    <# 
.SYNOPSIS
Borra una plantilla de correo de acuerdo a su identificador o nombre. Si la plantilla tiene al menos un proceso relacionado ocurrirá un error en la operación.

.PARAMETER IdTemplate
Identificador de la plantilla de correo electrónico a eliminar. No se puede utilizar junto con el parámetro Name.

.PARAMETER Name
Nombre de la plantilla de correo electrónico a eliminar. No se puede utilizar junto con el parámetro IdTemplate.

.EXAMPLE
Remove-Template -IdTemplate 99
Borra la plantilla cuyo identificador sea igual a 99.

.EXAMPLE
Remove-Template -Name 'NombreClaveDeLaPlantillaBorrar'
Borra la plantilla cuyo nombre sea igual a 'NombreClaveDeLaPlantilla'.

.LINK
[Add-Template](Add-Template.md)
[Get-Template](Get-Template.md)
[Remove-Template](Remove-Template.md)
[Update-Template](Update-Template.md)

.NOTES
-- ================================================================================================================
-- Author       : Manuel Vera Benedetti
-- Create date  : 07/12/2018
-- Gemini       : WBS3.1-26072 Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================
#>
    [CmdletBinding(DefaultParameterSetName = 'NameSet')]
    [OutputType([System.Void])]
    param(
        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'IdSet',
            HelpMessage = "Identificador de la plantilla.")]
        [Int]
        $IdTemplate,
        
        [Parameter(ParameterSetName = 'NameSet',
            HelpMessage = "Nombre de la plantilla.")]
        [String]
        $Name
    )
    begin {
        $Config = Get-Configuration
    }
    process {
        try {
            if ($PSCmdlet.ParameterSetName -eq 'NameSet') {
                $Arguments = @{
                    IdTemplate = $null
                    Name       = $Name
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
            $CountProcess = Invoke-SqliteQuery -Query $Config.SqlCountProcessStatement -DataSource $Script:DBFilePath -SqlParameters $Arguments -ErrorAction 'Stop'
            if ($CountProcess.Cantidad -eq 0) {
                $Exist = Invoke-SqliteQuery -Query $Config.SqlGetTemplateStatement -DataSource $Script:DBFilePath -SqlParameters $Arguments -ErrorAction 'Stop'
                if ($Exist) {
                    Invoke-SqliteQuery -Query $Config.SqlRemoveTemplateStatement -DataSource $Script:DBFilePath -SqlParameters $Arguments -ErrorAction 'Stop'
                    Write-Log -Message $MessageLog -Level Information
                }
            }
            else {
                throw "No se puede eliminar la plantilla. Tiene $($CountProcess.Cantidad) proceso(s) asociado(s)."
            }
        }
        catch {
            Write-Log -ErrorRecord $PSItem
            throw
        }
    }
    end {}
}