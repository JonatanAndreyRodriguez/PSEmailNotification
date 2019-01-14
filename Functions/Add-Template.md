---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Add-Template

## SYNOPSIS
Registra plantillas de correo en formato HTML: nombre descriptivo, ruta de la plantilla en disco y asunto del correo.

## SYNTAX

```
Add-Template [-Name] <String> [-Path] <String> [-Subject] <String> [<CommonParameters>]
```

## DESCRIPTION
Se agregan plantillas de correo electrónico al módulo.
El nombre debe ser único, de lo contrario, se genera un error.

## EXAMPLES

### EXAMPLE 1
```
Add-Template -Name 'NombreClaveDeLaPlantilla' -Path 'c:\ruta\plantilla.html' -Subject 'Titulo del correo'
```

## PARAMETERS

### -Name
Nombre descriptivo de la plantilla de correo electrónico.

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

### -Path
Ruta compuesta de directorios y nombre del archivo donde se encuentra la plantilla de correo electrónico en formato HTML.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Subject
Asunto o título con el que será enviado el correo electrónico.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
-- Create date  : 07/12/2018
-- Gemini       : WBS3.1-26072 Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================

## RELATED LINKS

[[Add-Template](Add-Template.md)
[Get-Template](Get-Template.md)
[Remove-Template](Remove-Template.md)
[Update-Template](Update-Template.md)]()

