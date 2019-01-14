---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Invoke-Notification

## SYNOPSIS
Se encarga de pasar la información apropiada a la función Send-Notification.

## SYNTAX

```
Invoke-Notification [-Filter] <String> [-ConnectionStringName] <String> [<CommonParameters>]
```

## DESCRIPTION
Se encarga de pasar la información apropiada a la función Send-Notification.

## EXAMPLES

### EXAMPLE 1
```
Invoke-Notification -Filter 'Cafam.LoadAccountBlocks' -ConnectionStringName 'Cafam'
```

Trae la data apropiada.

## PARAMETERS

### -Filter
Filtro para conocer a que cliente se refiere el proceso.

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

### -ConnectionStringName
Nombre de la cadena de conexión en el archivo PSProcessa.config

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

## OUTPUTS

### System.Void
## NOTES
-- ================================================================================================================
-- Author       : Carlos Franco
-- Create date  : 07/12/2018
-- Gemini       : WBS3.1-26072 Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================

## RELATED LINKS
