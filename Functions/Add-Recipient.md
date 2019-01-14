---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Add-Recipient

## SYNOPSIS
Registra un recipiente de correo a un proceso de notificación.

## SYNTAX

```
Add-Recipient [-IdProcess] <Int32> [-Email] <String> [<CommonParameters>]
```

## DESCRIPTION
Registra un correo electrónico a uno o más procesos.
El proceso debe haber sido registrado previamente.
El nombre de la persona es opcional.

## EXAMPLES

### EXAMPLE 1
```
Add-Recipient -IdProcess 99 -Email 'usuario@dominio.com'
```

## PARAMETERS

### -IdProcess
Identificador del proceso de notificación.
Este valor se puede obtener con Get-ProcessNotification.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Email
Dirección de correo electrónico a la que se enviará la notificación.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Identificador de un proceso previamente registrado (IdProcess). Se puede recibir en forma de HashTable.
## OUTPUTS

### System.Void
## NOTES
-- ================================================================================================================
-- Author       : Manuel Vera Benedetti
-- Create date  : 07/12/2018
-- Gemini       : WBS3.1-26072 Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================

## RELATED LINKS

[[Get-ProcessNotification](Get-ProcessNotification.md)
[Get-Recipient](Get-Recipient.md)
[Add-Recipient](Add-Recipient.md)
[Remove-Recipient](Remove-Recipient.md)]()

