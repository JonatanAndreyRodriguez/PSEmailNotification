function Send-Notification {
    <# 
.SYNOPSIS
Envía una notificación de correo electrónico al proceso indicado.

.PARAMETER ProcessName
Nombre clave dado al proceso de notificación. Este valor se debe buscar con Get-Process. No acepta comodín.

.PARAMETER TokenList
Objeto del tipo HashTable con el listado clave|valor de los tokens a ser reemplazados dentro de la plantilla.

.EXAMPLE
C:\PS> $TokenList = @{Clave1 = 'Valor1'; Clave2 = 'Valor2'; Clave3 = 'Valor3'}
C:\PS> Send-Notification -ProcessName 'NombreDelProceso' -TokenList $TokenList

.LINK
[Get-Process](Get-Process.md)
[Get-SmtpConnection](Get-SmtpConnection.md)

.NOTES
    -- ================================================================================================================
    -- Author       : Manuel Vera Benedetti
    -- Create date  : 13/12/2018
    -- Gemini       : WBS3.1-26072  Subtarea BD - Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
    -- ================================================================================================================
#>

    [CmdletBinding()]
    [OutputType([System.Void])]
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( {Get-Process -Name $PSItem | Test-Process})]
        [String]$ProcessName,
        
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [Object]$Tokens
    )
    # Envía una notificación de correo electrónico.
    $Config = Get-Configuration
    try {
        # Buscar datos de plantilla y proceso
        $TemplateData = ($ProcessData = Get-Process -Name $ProcessName -AllRecipients) | Get-Template
        if ($null -eq $ProcessData -or $null -eq $TemplateData -or $null -eq $ProcessData.Recipients) {
            throw "Para el proceso '$ProcessName' faltan datos como: la plantilla, destinatarios, etc."
        }

        # Validar SMTP
        if ($null -eq $ProcessData.SmtpKeyName -or '' -eq $ProcessData.SmtpKeyName) {
            # Tomar el valor de la configuracion de modulo
            $SmtpData = Get-SmtpConnection -Name $Config.NameKeySmtp | Convert-ToHashtable -TokenSeparator ';' -KeyValueSeparator '='
            if ($null -eq $SmtpData) {
                throw "No se encontró la clave de Smtp '$($Config.NameKeySmtp)' configurada en el modulo."
            }
        }
        else {
            # Tomar el valor configurado en el proceso
            $SmtpData = Get-SmtpConnection -Name $ProcessData.SmtpKeyName | Convert-ToHashtable -TokenSeparator ';' -KeyValueSeparator '='
            if ($null -eq $SmtpData) {
                throw "No se encontró la clave de Smtp '$($ProcessData.SmtpKeyName)' configurada en el proceso '$ProcessName'."
            }
        }
        
        $Subject = $TemplateData.Subject
        $Message = $TemplateData.Path | Get-TemplateContent | Format-TemplateToken -Tokens $Tokens
        $RecipientsTo = @()
        $ProcessData.Recipients | ForEach-Object {$RecipientsTo += $_.Recipient}
        $SecurePwd = ConvertTo-SecureString -String $SmtpData.password -AsPlainText -Force
        $CredentialUser = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SmtpData.username , $SecurePwd
        Send-MailMessage -From $SmtpData.username -to $RecipientsTo -Subject $Subject -Encoding BigEndianUnicode -BodyAsHtml $Message -SmtpServer $SmtpData.smtpserver -Port $SmtpData.Port -UseSsl -Credential $CredentialUser
        Write-Log -Message "Se envió la notificación para el proceso '$ProcessName'" -Level Information
    }
    catch {
        Write-Log -ErrorRecord $PSItem
        throw
    }
}