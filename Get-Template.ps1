function Get-Template {
    <# 
.SYNOPSIS
Obtiene al menos una plantilla de correo de acuerdo a su identificador o nombre

.PARAMETER Name
Nombre de la plantilla de correo electrónico buscada. Se permite usar el asterisco (*) como caracter comodín.
No se puede utilizar junto con el parámetro IdTemplate.

.PARAMETER IdTemplate
Identificador de la plantilla de correo electrónico buscada. No se puede utilizar junto con el parámetro Name.

.EXAMPLE
C:\PS> Get-Template -Name '*'
C:\PS> Get-Template -Name '%'
C:\PS> Get-Template 
Lista todas las plantillas registradas.

.EXAMPLE
C:\PS> Get-Template -Name 'NombreClaveDeLaPlantilla'
Lista la plantilla cuyo nombre sea igual a 'NombreClaveDeLaPlantilla'.

.EXAMPLE
C:\PS> Get-Template -Name '*Cliente*'
Lista todas las plantillas cuyo nombre contenga la palabra 'Cliente'.

.EXAMPLE
C:\PS> Get-Template -IdTemplate 99
Lista la plantilla cuyo identificador sea igual a 99.

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
    [CmdletBinding(DefaultParameterSetName='NameSet')]
    [OutputType([System.Void])]
    param(
        [Parameter(ParameterSetName = 'NameSet',
            HelpMessage = "Nombre de la plantilla. Acepta asterisco (*) como comodín.")]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [String]$Name = '*',

        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'IdSet',
            HelpMessage = "Identificador de la plantilla.")]
        [ValidateNotNullOrEmpty()]
        [Int]$IdTemplate
    )
    begin {
        $Config = Get-Configuration
    }

    process {    
        # Busca plantillas.
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

            Invoke-SqliteQuery -Query $Config.SqlGetTemplateStatement -DataSource $Script:DBFilePath -SqlParameters $Arguments -ErrorAction 'Stop'
        }
        catch {
            Write-Log -ErrorRecord $PSItem
            throw
        }
    }

    end {}
}