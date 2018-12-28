function Add-Recipient {
    <# 
.SYNOPSIS
Registra un recipiente de correo a un proceso de notificación.

.DESCRIPTION
Registra un correo electrónico a uno o más procesos. El proceso debe haber sido registrado previamente.
El nombre de la persona es opcional.

.PARAMETER IdProcess
Identificador del proceso de notificación. Este valor se puede obtener con Get-Process.

.PARAMETER Name
Nombre del destinatario de correo (opcional).

.PARAMETER Email
Dirección de correo electrónico a la que se enviará la notificación.

.INPUTS
Identificador de un proceso previamente registrado (IdProcess). Se puede recibir en forma de HashTable.

.EXAMPLE
C:\PS> Add-Recipient -IdProcess 99 -Email 'usuario@dominio.com'

.EXAMPLE
C:\PS> Add-Recipient -IdProcess 99 -Name 'Nombre Apellido' -Email 'usuario@dominio.com'

.LINK
[Get-Process](Get-Process.md)
[Get-MailRecipient](Get-MailRecipient.md)
[Add-Recipient](Add-Recipient.md)
[Remove-Recipient](Remove-Recipient.md)

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
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {Test-Process -IdProcess $PSItem})]
        [Int]$IdProcess,
        
        [Parameter()]
        [String]$Name,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String]$Email
    )
    begin {
        $Config = Get-Configuration
    }
    process {
        if (-not (Test-Process -IdProcess $IdProcess)) {
            throw "No existe un proceso con el identificador: $IdProcess"
        }
        # Agrega un recipiente.
        try {
            if (($IdMailRecipient = (Get-MailRecipient -Email $Email).IdMailRecipient) -gt 0) {
                # Ya existe el correo
                $AddSqlStatement = $Config.SqlAddReceiverStatement
                $Arguments = @{
                    Author          = $env:USERNAME
                    Date            = Get-Date -Format $Config.SqlDateFormat
                    IdProcess       = $IdProcess
                    IdMailRecipient = $IdMailRecipient
                }
                $MessageLog = "El recipiente ($Email) ha sido asociado al proceso ($IdProcess)"
            }
            else {
                # No existe el correo
                $AddSqlStatement = $Config.SqlAddRecipientStatement
                $Arguments = @{
                    Author    = $env:USERNAME
                    Date      = Get-Date -Format $Config.SqlDateFormat
                    IdProcess = $IdProcess
                    Name      = $Name
                    Email     = $Email
                }
                $MessageLog = "Se creó el recipiente ($Email) en el proceso ($IdProcess)"
            }
            Invoke-SqliteQuery -Query $AddSqlStatement -DataSource $Script:DBFilePath -SqlParameters $Arguments -ErrorAction 'Stop'
            Write-Log -Message $MessageLog -Level Information
        }
        catch {
            Write-Log -ErrorRecord $PSItem
            throw
        }
    }
    end {}
}