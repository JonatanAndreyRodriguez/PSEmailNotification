---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Test-Configuration

## SYNOPSIS
Verifica la información de los datos de configuración del módulo.

## SYNTAX

```
Test-Configuration [-SaveFlag] [<CommonParameters>]
```

## DESCRIPTION
Verifica la información de los datos de configuración del módulo de acuerdo a las comprobaciones que haya agregado el desarrollador.

## EXAMPLES

### EXAMPLE 1
```
Test-Configuration
```

Verifica la configuración del módulo (conexiones y demás elementos definidos por el desarrollador).

### EXAMPLE 2
```
Test-Configuration -SaveFlag
```

Verifica la configuración del módulo (conexiones y demás elementos definidos por el desarrollador).
Si alguna verificación falla, establece el valor de *No configurado* en el archivo PSEmailNotification.config

## PARAMETERS

### -SaveFlag
Cuando se establece y las validaciones fallan, actualiza el valor de *No configurado* en el archivo PSEmailNotification.config

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Ninguno
### Esta función no acepta parámetros a través de la canalización,
## OUTPUTS

### System.Void
## NOTES
-- ================================================================================================================
-- Author       : Manuel Vera Benedetti
-- Create date  : 07/12/2018
-- Gemini       : WBS3.1-26072 Automatización de Notificaciones de Cargue de Clientes y Realce de Tarjetas
-- ================================================================================================================

## RELATED LINKS

[[Set-Configuration](Set-Configuration.md)
[Get-Configuration](Get-Configuration.md)]()

