---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Get-Recipient

## SYNOPSIS
Obtiene los correos electrónicos registrados de acuerdo a su filtro por identificador de proceso o correo.

## SYNTAX

### EmailSet (Default)
```
Get-Recipient [-Email <String>] [<CommonParameters>]
```

### IdSet
```
Get-Recipient [-IdProcess <Int32>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1
```
Get-Recipient -IdProcess 99
```

Lista los correos electrónicos relacionados al proceso cuyo identificador sea igual a 99.

### EXAMPLE 2
```
Get-Recipient -Email *
```

Lista todos los correos electrónicos registrados.

### EXAMPLE 3
```
Get-Recipient -Email '*@dominio.com'
```

Lista todos los correos electrónicos que contengan el texto '@dominio.com'.

### EXAMPLE 4
```
Get-Recipient -Email 'nombre@dominio.com'
```

Lista el correo electrónico que sea igual al valor indicado.

## PARAMETERS

### -IdProcess
Identificador del proceso del que se desea conocer los correos electrónicos relacionados.

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

### -Email
Correo electrónico buscado.
Se permite usar el asterisco (*) como caracter comodín.
No se puede utilizar junto con el parámetro IdProcess.

```yaml
Type: String
Parameter Sets: EmailSet
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

[[Get-Recipient](Get-Recipient.md)
[Add-Recipient](Add-Recipient.md)
[Remove-Recipient](Remove-Recipient.md)]()

