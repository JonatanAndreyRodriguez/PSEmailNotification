---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Get-ProcessNotification

## SYNOPSIS
Obtiene al menos un proceso de notificación de acuerdo a su identificador o nombre.

## SYNTAX

### NameSet (Default)
```
Get-ProcessNotification [-Name <String>] [<CommonParameters>]
```

### IdSet
```
Get-ProcessNotification [-IdProcess <Int32>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1
```
Get-ProcessNotification '*'
```

Lista todos los procesos registrados.

### EXAMPLE 2
```
Get-ProcessNotification -Name 'NombreClaveDelProceso'
```

Lista el proceso cuyo nombre sea igual a 'NombreClaveDelProceso'.

### EXAMPLE 3
```
Get-ProcessNotification -Name '*Cliente*'
```

Lista todos los procesos cuyo nombre contenga la palabra 'Cliente'.

### EXAMPLE 4
```
Get-ProcessNotification -IdProcess 99
```

Lista el proceso cuyo identificador sea igual a 99.

## PARAMETERS

### -Name
Nombre del proceso de notificación buscado.
Se permite usar el asterisco (*) como caracter comodín.
No se puede utilizar junto con el parámetro IdProcess.

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

### -IdProcess
Identificador del proceso de notificación buscado.
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

[[Add-ProcessNotification](Add-ProcessNotification.md)
[Get-ProcessNotification](Get-ProcessNotification.md)
[Remove-ProcessNotification](Remove-ProcessNotification.md)
[Update-ProcessNotification](Update-ProcessNotification.md)]()

