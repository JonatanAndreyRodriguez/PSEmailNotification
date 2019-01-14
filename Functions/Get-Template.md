---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Get-Template

## SYNOPSIS
Obtiene las plantillas HTML configuradas previamente para el envio de correos.

## SYNTAX

### NameSet (Default)
```
Get-Template [-Name <String>] [<CommonParameters>]
```

### IdSet
```
Get-Template [-IdTemplate <Int32>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1
```
Get-Template -Name '*'
```

Get-Template -Name '%'
Get-Template 
Lista todas las plantillas registradas.

### EXAMPLE 2
```
Get-Template -Name 'NombreClaveDeLaPlantilla'
```

Lista la plantilla cuyo nombre sea igual a 'NombreClaveDeLaPlantilla'.

### EXAMPLE 3
```
Get-Template -Name '*Cliente*'
```

Lista todas las plantillas cuyo nombre contenga la palabra 'Cliente'.

### EXAMPLE 4
```
Get-Template -IdTemplate 99
```

Lista la plantilla cuyo identificador sea igual a 99.

### EXAMPLE 5
```
(1,2) | Get-Template
```

## PARAMETERS

### -IdTemplate
Identificador de la plantilla de correo electrónico buscada.
No se puede utilizar junto con el parámetro Name.

```yaml
Type: Int32
Parameter Sets: IdSet
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name
Nombre de la plantilla de correo electrónico buscada.
Se permite usar el asterisco (*) como caracter comodín.
No se puede utilizar junto con el parámetro IdTemplate.

```yaml
Type: String
Parameter Sets: NameSet
Aliases:

Required: False
Position: Named
Default value: *
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
-- Create date  : 07/12/2018
-- Gemini       : WBS3.1-26072 Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================

## RELATED LINKS

[[Add-Template](Add-Template.md)
[Get-Template](Get-Template.md)
[Remove-Template](Remove-Template.md)
[Update-Template](Update-Template.md)]()

