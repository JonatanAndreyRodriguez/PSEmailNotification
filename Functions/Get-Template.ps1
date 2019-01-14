function Get-Template {
    <# 
.SYNOPSIS
Obtiene las plantillas HTML configuradas previamente para el envio de correos.

.PARAMETER IdTemplate
Identificador de la plantilla de correo electrónico buscada. No se puede utilizar junto con el parámetro Name.

.PARAMETER Name
Nombre de la plantilla de correo electrónico buscada. Se permite usar el asterisco (*) como caracter comodín.
No se puede utilizar junto con el parámetro IdTemplate.

.EXAMPLE
Get-Template -Name '*'
Get-Template -Name '%'
Get-Template 
Lista todas las plantillas registradas.

.EXAMPLE
Get-Template -Name 'NombreClaveDeLaPlantilla'
Lista la plantilla cuyo nombre sea igual a 'NombreClaveDeLaPlantilla'.

.EXAMPLE
Get-Template -Name '*Cliente*'
Lista todas las plantillas cuyo nombre contenga la palabra 'Cliente'.

.EXAMPLE
Get-Template -IdTemplate 99
Lista la plantilla cuyo identificador sea igual a 99.

.EXAMPLE
(1,2) | Get-Template

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
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'IdSet',
            HelpMessage = "Identificador de la plantilla.")]
        [ValidateNotNullOrEmpty()]
        [Int]
        $IdTemplate,

        [Parameter(ParameterSetName = 'NameSet',
            HelpMessage = "Nombre de la plantilla. Acepta asterisco (*) como comodín.")]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [String]
        $Name = '*'
    )
    begin {
        $Config = Get-Configuration
    }

    process {
        try {
            if ($PSCmdlet.ParameterSetName -eq 'NameSet') {
                $Arguments = @{
                    IdTemplate = $null
                    Name       = ($Name -replace '[*]', '%') -replace '[?]', '_'
                }
            }            
            if ($PSCmdlet.ParameterSetName -eq 'IdSet') {
                $Arguments = @{
                    IdTemplate = $IdTemplate
                    Name       = $null
                }
            }

            Invoke-SqliteQuery -Query $Config.SqlGetTemplateStatement -DataSource $Script:DBFilePath -SqlParameters $Arguments -ErrorAction 'Stop' |
                ForEach-Object {
                [PSCustomObject]@{
                    PSTypeName   = 'Processa.Management.Automation.PSEmailNotification.Template'
                    IdTemplate   = $PSItem.IdTemplate
                    Name         = $PSItem.Name
                    Subject      = $PSItem.Subject
                    Template     = $PSItem.File
                    ExistsFile   = (Test-Path -Path (Join-Path -Path $Script:TemplatesPath -ChildPath $PSItem.File) -PathType Leaf)
                    CreateDate   = $PSItem.CreateDate
                    CreateAuthor = $PSItem.CreateAuthor
                    UpdateDate   = $PSItem.UpdateDate
                    UpdateAuthor = $PSItem.UpdateAuthor                    
                } | Write-Output
            }            
        }
        catch {
            Write-Log -ErrorRecord $PSItem
            throw
        }
    }
    end {}
}