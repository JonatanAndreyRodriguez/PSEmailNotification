---
external help file: PSEmailNotification-help.xml
Module Name: PSEmailNotification
online version:
schema: 2.0.0
---

# Remove-ProcessNotification

## SYNOPSIS
Borra al menos un proceso de notificación de acuerdo a su identificador o nombre.

## SYNTAX

### NameSet
```
Remove-ProcessNotification [[-Name] <String>] [<CommonParameters>]
```

### IdSet
```
Remove-ProcessNotification [-IdProcess <Int32>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1
```
Remove-ProcessNotification '*'
```

Borra todos los procesos registrados.

### EXAMPLE 2
```
Remove-ProcessNotification -Name 'NombreClaveDelProceso'
```

Borra el proceso de notificación cuyo nombre sea igual a 'NombreClaveDelProceso'.

### EXAMPLE 3
```
Remove-ProcessNotification -Name '*Cliente*'
```

Borra todos los procesos cuyo nombre contenga la palabra 'Cliente'.

### EXAMPLE 4
```
Remove-ProcessNotification -IdProcess 99
```

Borra el proceso de notificación cuyo identificador sea igual a 99.

## PARAMETERS

### -Name
Nombre del proceso de notificación a eliminar.
Se permite usar el asterisco (*) como caracter comodín.
No se puede utilizar junto con el parámetro IdProcess.

```yaml
Type: String
Parameter Sets: NameSet
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -IdProcess
Identificador del proceso de notificación a eliminar.
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

