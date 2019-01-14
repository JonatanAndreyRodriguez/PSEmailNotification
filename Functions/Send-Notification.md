---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Send-Notification

## SYNOPSIS
Envía una notificación de correo electrónico al proceso indicado.

## SYNTAX

```
Send-Notification [-ProcessName] <String> [-Tokens] <Object> [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1
```
$TokenList = @{Clave1 = 'Valor1'; Clave2 = 'Valor2'; Clave3 = 'Valor3'}
```

Send-Notification -ProcessName 'NombreDelProceso' -Tokens $TokenList

### EXAMPLE 2
```
Invocar el CmdLet desde una consola o terminal de comandos (CMD):
```

PowerShell.exe -WindowStyle Normal -ExecutionPolicy Unrestricted -Command "& {Import-Module PSEmailNotification -Force;
    Send-Notification -ProcessName 'Cafam.CustomersLoadStructure' -Tokens @{ ArchivoProcesado = 'ArchivoProcesado';
    ArchivoLog = 'ArchivoLog'; RutaArchivoLog = 'RutaArchivoLog' }; exit $LASTEXITCODE; }"

Se tiene un proceso creado con el nombre 'Cafam.CustomersLoadStructure' y la plantilla recibe 3 tokens.

### EXAMPLE 3
```
Invocar el CmdLet desde un paquete de Integration Services (SSIS):
```

PowerShell.exe -WindowStyle Hidden -ExecutionPolicy Unrestricted -Command "& { 
    try{ $ErrorActionPreference = 'Stop'; Import-Module PSEmailNotification -Force;
    Send-Notification -ProcessName 'Cafam.CustomersLoadStructure' -Tokens @{ 
    ArchivoProcesado = 'ArchivoProcesado'; ArchivoLog = 'ArchivoLog';
    RutaArchivoLog = 'RutaArchivoLog' }; exit $LASTEXITCODE; } catch { 
    Write-Host $Error\[0\].ToString(); Exit 3; } }"

## PARAMETERS

### -ProcessName
Nombre clave dado al proceso de notificación.
Este valor se debe buscar con Get-ProcessNotification.
No acepta comodín.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tokens
Objeto del tipo HashTable con el listado clave|valor de los tokens a ser reemplazados dentro de la plantilla.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Void
## NOTES
-- ================================================================================================================
-- Author       : Manuel Vera Benedetti
-- Create date  : 13/12/2018
-- Gemini       : WBS3.1-26072 Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================

## RELATED LINKS

[[Get-ProcessNotification](Get-ProcessNotification.md)
[Get-SmtpConnection](Get-SmtpConnection.md)]()

