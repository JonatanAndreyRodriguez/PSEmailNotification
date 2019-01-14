---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Remove-Recipient

## SYNOPSIS
Borra al menos un recipiente de acuerdo a su identificador de proceso y/o correo electrónico.

## SYNTAX

```
Remove-Recipient [-IdProcess] <Int32> [[-Email] <String>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1
```
Remove-Recipient -IdProcess 99
```

Remove-Recipient -IdProcess 99 -Email '*'
Borra todos los recipientes para el proceso de notificación cuyo identificador es 99.

### EXAMPLE 2
```
Remove-Recipient -IdProcess 88 -Email 'usuario@dominio.com'
```

Borra el recipiente indicado para el proceso de notificación cuyo identificador es 88.

## PARAMETERS

### -IdProcess
Identificador del proceso de notificación donde se desea eliminar recipientes.

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
Dirección de correo electrónico que se desea eliminar.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
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
-- Create date  : 11/12/2018
-- Gemini       : WBS3.1-26072 Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================

## RELATED LINKS

[[Get-ProcessNotification](Get-ProcessNotification.md)
[Get-Recipient](Get-Recipient.md)
[Add-Recipient](Add-Recipient.md)
[Remove-Recipient](Remove-Recipient.md)]()

