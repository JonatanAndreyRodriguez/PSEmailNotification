---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Get-Configuration

## SYNOPSIS
Obtiene la información de los datos de configuración del módulo.

## SYNTAX

```
Get-Configuration [<CommonParameters>]
```

## DESCRIPTION
Obtiene la información de los datos de configuración del módulo a partir de los datos en el archivo PSEmailNotification.config

## EXAMPLES

### EXAMPLE 1
```
Get-Configuration
```

Obtiene la información de configuración del módulo.

### EXAMPLE 2
```
Get-Configuration | Get-Member -MemberType Properties
```

Obtiene los nombres de las propiedades incluidas en el objeto de retorno.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Ninguno
### Esta función no acepta parámetros a través de la canalización,
## OUTPUTS

### System.Management.Automation.PSObject
## NOTES
-- ================================================================================================================
-- Author       : Manuel Vera Benedetti
-- Create date  : 07/12/2018
-- Gemini       : WBS3.1-26072 Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================

## RELATED LINKS

[[Set-Configuration](Set-Configuration.md)
[Test-Configuration](Test-Configuration.md)]()

