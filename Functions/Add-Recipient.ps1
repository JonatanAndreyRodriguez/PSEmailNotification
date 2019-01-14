function Add-Recipient {
    <# 
.SYNOPSIS
Registra un recipiente de correo a un proceso de notificaci�n.

.DESCRIPTION
Registra un correo electr�nico a uno o m�s procesos. El proceso debe haber sido registrado previamente.
El nombre de la persona es opcional.

.PARAMETER IdProcess
Identificador del proceso de notificaci�n. Este valor se puede obtener con Get-ProcessNotification.

.PARAMETER Email
Direcci�n de correo electr�nico a la que se enviar� la notificaci�n.

.INPUTS
Identificador de un proceso previamente registrado (IdProcess). Se puede recibir en forma de HashTable.

.EXAMPLE
Add-Recipient -IdProcess 99 -Email 'usuario@dominio.com'

.LINK
[Get-ProcessNotification](Get-ProcessNotification.md)
[Get-Recipient](Get-Recipient.md)
[Add-Recipient](Add-Recipient.md)
[Remove-Recipient](Remove-Recipient.md)

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
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [Int]
        $IdProcess,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Email
    )
    $Config = Get-Configuration
    if (-not (Test-ProcessNotification -IdProcess $IdProcess)) {
        throw "No existe un proceso con el identificador: $IdProcess"
    }
    try {
        Invoke-SqliteQuery -Query $Config.SqlAddRecipientStatement -DataSource $Script:DBFilePath -SqlParameters @{
            IdProcess = $IdProcess
            Email     = $Email
            Author    = $env:USERNAME
            Date      = Get-Date -Format $Config.SqlDateFormat
        } -ErrorAction 'Stop'
        Write-Log -Message "Se agrego el correo $Email al Processo: $IdProcess" -Level Information
    }
    catch {
        Write-Log -ErrorRecord $PSItem
        throw
    }

}