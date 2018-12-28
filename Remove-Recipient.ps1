function Remove-Recipient {
    <# 
.SYNOPSIS
Borra al menos un recipiente de acuerdo a su identificador de proceso y/o correo electr�nico.

.PARAMETER IdProcess
Identificador del proceso de notificaci�n donde se desea eliminar recipientes.

.PARAMETER Email
Direcci�n de correo electr�nico que se desea eliminar.

.EXAMPLE
C:\PS> Remove-Recipient -IdProcess 99
C:\PS> Remove-Recipient -IdProcess 99 -Email '*'
Borra todos los recipientes para el proceso de notificaci�n cuyo identificador es 99.

.EXAMPLE
C:\PS> Remove-Recipient -IdProcess 88 -Email 'usuario@dominio.com'
Borra el recipiente indicado para el proceso de notificaci�n cuyo identificador es 88.

.LINK
[Get-Process](Get-Process.md)
[Get-MailRecipient](Get-MailRecipient.md)
[Add-Recipient](Add-Recipient.md)
[Remove-Recipient](Remove-Recipient.md)

.NOTES
    -- ================================================================================================================
    -- Author       : Manuel Vera Benedetti
    -- Create date  : 11/12/2018
    -- Gemini       : WBS3.1-26072  Subtarea BD - Automatizaci�n de Notificaciones de Cargue de Clientes y Realce de Tarjetas
    -- ================================================================================================================
#>
    [CmdletBinding()]
    [OutputType([System.Void])]
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName
            , HelpMessage = 'Identificador del proceso de notificaci�n')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {Test-Process -IdProcess $PSItem})]
        [Int]$IdProcess,
        
        [Parameter(Mandatory, ValueFromPipelineByPropertyName
            , HelpMessage = 'Correo electr�nico. Acepta asterisco (*) como caracter comod�n.')]
        [ValidateNotNullOrEmpty()]
        [String]$Email
    )
    begin {
        $Config = Get-Configuration
    }
    process {
        # Elimina recipientes.
        try {
            Invoke-SqliteQuery -Query $Config.SqlRemoveRecipientStatement -DataSource $Script:DBFilePath -SqlParameters @{
                IdProcess = $IdProcess
                Email     = ($Email -replace '[*]', '%') -replace '[?]', '_'
            } -ErrorAction 'Stop'
            Write-Log -Message "Se eliminaron los recipientes ($Email) en el proceso con el identificador: $IdProcess" -Level Information
        }
        catch {
            Write-Log -ErrorRecord $PSItem
            throw
        }
    }
    end {}
}