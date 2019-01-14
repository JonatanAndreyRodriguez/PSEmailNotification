---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Add-ProcessNotification

## SYNOPSIS
Registra procesos de notificación.

## SYNTAX

```
Add-ProcessNotification [-Name] <String> [-IdTemplate] <Int32> [[-SmtpKeyName] <String>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1
```
Add-ProcessNotification -Name 'NombreDelProceso' -IdTemplate 99 -SmtpKeyName 'NombreClaveSmtp'
```

### EXAMPLE 2
```
Get-Template -Name 'NombrePlantilla' | Add-ProcessNotification -Name 'NombreDelProceso' -SmtpKeyName 'NombreClaveSmtp'
```

## PARAMETERS

### -Name
Nombre descriptivo del proceso de notificación.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IdTemplate
Identificador de la plantilla asociada al proceso.
Este valor se debe buscar con Get-Template.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SmtpKeyName
Nombre clave de la configuración de buzón de correo saliente presente en el equipo.
Se obtiene con Get-SmtpConnection.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Identificador numérico de una plantilla previamente registrada (IdTemplate). Lo puede recibir en forma de HashTable.
## OUTPUTS

### System.Void
## NOTES
-- ================================================================================================================
-- Author       : Manuel Vera Benedetti
-- Create date  : 07/12/2018
-- Gemini       : WBS3.1-26072 Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================

## RELATED LINKS

[[Get-Template](Get-Template.md)
[Get-SmtpConnection](Get-SmtpConnection.md)
[Add-ProcessNotification](Add-ProcessNotification.md)
[Get-ProcessNotification](Get-ProcessNotification.md)
[Remove-ProcessNotification](Remove-ProcessNotification.md)
[Update-ProcessNotification](Update-ProcessNotification.md)]()

