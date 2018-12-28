function Get-Process {
    <# 
.SYNOPSIS
Obtiene al menos un proceso de notificación de acuerdo a su identificador o nombre.

.PARAMETER Name
Nombre del proceso de notificación buscado. Se permite usar el asterisco (*) como caracter comodín.
No se puede utilizar junto con el parámetro IdProcess.

.PARAMETER IdProcess
Identificador del proceso de notificación buscado. No se puede utilizar junto con el parámetro Name.

.PARAMETER AllRecipients
Switch para solicitar el listado de recipientes en el proceso listado. Solo se puede usar con el parámetro IdProcess.

.EXAMPLE
C:\PS> Get-Process '*'
Lista todos los procesos registrados.

.EXAMPLE
C:\PS> Get-Process -Name 'NombreClaveDelProceso'
Lista el proceso cuyo nombre sea igual a 'NombreClaveDelProceso'.

.EXAMPLE
C:\PS> Get-Process -Name '*Cliente*'
Lista todos los procesos cuyo nombre contenga la palabra 'Cliente'.

.EXAMPLE
C:\PS> Get-Process -Process 99
Lista el proceso cuyo identificador sea igual a 99.

.LINK
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
    [CmdletBinding(DefaultParameterSetName = 'NameSet')]
    [OutputType([System.Void])]
    param(
        [Parameter(ParameterSetName = 'NameSet',
            HelpMessage = "Nombre del proceso. Acepta asterisco (*) como comodín.")]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [String]$Name = '*',

        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'IdSet',
            HelpMessage = "Identificador del proceso.")]
        [ValidateNotNullOrEmpty()]
        [Int]$IdProcess,

        [Parameter(
            HelpMessage = "Para mostrar los recipientes de correo por proceso.")]
        [Switch]$AllRecipients
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
                if ($AllRecipients.IsPresent -or $AllRecipients -eq $true) {
                    $RecipientsData = Invoke-SqliteQuery -Query $Config.SqlGetReceiverStatement -DataSource $Script:DBFilePath -SqlParameters @{
                        IdProcess = $PSItem.IdProcess
                    } -ErrorAction 'Stop' | Foreach-Object {
                        [PSCustomObject]@{
                            PSTypeName = 'Processa.Management.Automation.PSEmailNotification.Recipient'
                            Name       = $PSItem.Name
                            Email      = $PSItem.Email
                            Recipient  = Invoke-Ternary -Condition {$PSItem.Name.Length -eq 0} -TrueBlock {$PSItem.Email} -FalseBlock {"""$($PSItem.Name)"" <$($PSItem.Email)>"}
                        }
                    }
                }
                else {$RecipientsData = $null}

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
                    State        = (Invoke-Ternary -Condition { $PSItem.State} -TrueBlock {'Activo'} -FalseBlock {'Inactivo'})
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