---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Remove-Template

## SYNOPSIS
Borra una plantilla de correo de acuerdo a su identificador o nombre.
Si la plantilla tiene al menos un proceso relacionado ocurrirá un error en la operación.

## SYNTAX

### NameSet (Default)
```
Remove-Template [-Name <String>] [<CommonParameters>]
```

### IdSet
```
Remove-Template [-IdTemplate <Int32>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1
```
Remove-Template -IdTemplate 99
```

Borra la plantilla cuyo identificador sea igual a 99.

### EXAMPLE 2
```
Remove-Template -Name 'NombreClaveDeLaPlantillaBorrar'
```

Borra la plantilla cuyo nombre sea igual a 'NombreClaveDeLaPlantilla'.

## PARAMETERS

### -IdTemplate
Identificador de la plantilla de correo electrónico a eliminar.
No se puede utilizar junto con el parámetro Name.

```yaml
Type: Int32
Parameter Sets: IdSet
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Nombre de la plantilla de correo electrónico a eliminar.
No se puede utilizar junto con el parámetro IdTemplate.

```yaml
Type: String
Parameter Sets: NameSet
Aliases:

Required: False
Position: Named
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

