---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Update-Template

## SYNOPSIS
Actualiza plantillas de correo en formato HTML: nombre descriptivo y asunto del correo.

## SYNTAX

```
Update-Template [-IdTemplate] <String> [[-Name] <String>] [[-Subject] <String>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1
```
Update-Template -IdTemplate 99 -Name 'PruebaPlantilla'
```

### EXAMPLE 2
```
Update-Template -IdTemplate 99 -Subject 'Modificando Asunto'
```

### EXAMPLE 3
```
Update-Template -IdTemplate 99 -Name 'PruebaPlantillaLista' -Subject 'Asunto Cambiado'
```

## PARAMETERS

### -IdTemplate
Identificador de la plantilla de correo electrónico.

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

### -Name
Nombre descriptivo de la plantilla de correo electrónico.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subject
Asunto o título con el que será enviado el correo electrónico.

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

## OUTPUTS

### System.Void
## NOTES
-- ================================================================================================================
-- Author       : Manuel Vera Benedetti
-- Create date  : 07/12/2018
-- Gemini       : WBS3.1-26072 Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================

## RELATED LINKS

[[Add-Template](Add-Template.md)
[Get-Template](Get-Template.md)
[Remove-Template](Remove-Template.md)
[Update-Template](Update-Template.md)]()

