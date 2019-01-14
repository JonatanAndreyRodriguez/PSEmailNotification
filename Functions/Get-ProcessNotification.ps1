function Get-ProcessNotification {
    <# 
.SYNOPSIS
Obtiene al menos un proceso de notificaci�n de acuerdo a su identificador o nombre.

.PARAMETER Name
Nombre del proceso de notificaci�n buscado. Se permite usar el asterisco (*) como caracter comod�n.
No se puede utilizar junto con el par�metro IdProcess.

.PARAMETER IdProcess
Identificador del proceso de notificaci�n buscado. No se puede utilizar junto con el par�metro Name.

.EXAMPLE
Get-ProcessNotification '*'
Lista todos los procesos registrados.

.EXAMPLE
Get-ProcessNotification -Name 'NombreClaveDelProceso'
Lista el proceso cuyo nombre sea igual a 'NombreClaveDelProceso'.

.EXAMPLE
Get-ProcessNotification -Name '*Cliente*'
Lista todos los procesos cuyo nombre contenga la palabra 'Cliente'.

.EXAMPLE
Get-ProcessNotification -IdProcess 99
Lista el proceso cuyo identificador sea igual a 99.

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
    [CmdletBinding(DefaultParameterSetName = 'NameSet')]
    [OutputType([System.Void])]
    param(
        [Parameter(ParameterSetName = 'NameSet',
            HelpMessage = "Nombre del proceso. Acepta asterisco (*) como comod�n.")]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [String]
        $Name = '*',

        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'IdSet',
            HelpMessage = "Identificador del proceso.")]
        [ValidateNotNullOrEmpty()]
        [Int]
        $IdProcess
    )
    begin {
        $Config = Get-Configuration
    }

    process {
        # Busca procesos.
        try {
            if ($PSCmdlet.ParameterSetName -eq 'NameSet') {
                $Arguments = @{
                    IdProcess = $null
                    Name      = (($Name -replace '[*]', '%') -replace '[?]', '_')
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'IdSet') {
                $Arguments = @{
                    IdProcess = $IdProcess
                    Name      = $null
                }
            }

            Invoke-SqliteQuery -Query $Config.SqlGetProcessStatement -DataSource $Script:DBFilePath -SqlParameters $Arguments -ErrorAction 'Stop' | 
                ForEach-Object {
                $RecipientsData = Invoke-SqliteQuery -Query $Config.SqlGetRecipientStatement -DataSource $Script:DBFilePath -SqlParameters @{
                    IdProcess = $PSItem.IdProcess
                    Email     = $null
                } -ErrorAction 'Stop' | Foreach-Object {
                    [PSCustomObject]@{
                        PSTypeName = 'Processa.Management.Automation.PSEmailNotification.Recipient'
                        Email      = $PSItem.Email                        
                    }
                }

                [PSCustomObject]@{
                    PSTypeName   = 'Processa.Management.Automation.PSEmailNotification.Process'
                    IdProcess    = $PSItem.IdProcess
                    Name         = $PSItem.Name
                    IdTemplate   = $PSItem.IdTemplate
                    Template     = (Get-Template -IdTemplate $PSItem.IdTemplate).Name
                    SmtpKeyName  = $PSItem.SmtpKeyName
                    CreateDate   = $PSItem.CreateDate
                    CreateAuthor = $PSItem.CreateAuthor
                    UpdateDate   = $PSItem.UpdateDate
                    UpdateAuthor = $PSItem.UpdateAuthor                    
                    Recipients   = $RecipientsData
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