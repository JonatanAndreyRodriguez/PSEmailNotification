# Add-ProcessNotification

## SYNOPSIS
Registra procesos de notificación.

## SYNTAX

```
Add-ProcessNotification [-Name] <String> [-IdTemplate] <Int> [-SmtpKeyName] <String>
```

## DESCRIPTION
Establece la relacion entre el proceso, la plantilla y el servidor de correo.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Add-ProcessNotification -Name 'NombreDelProceso' -IdTemplate 99 -SmtpKeyName 'NombreClaveSmtp'
```

### -------------------------- EXAMPLE 2 --------------------------
```
Get-Template -Name 'NombrePlantilla' | Add-ProcessNotification -Name 'NombreDelProceso' -SmtpKeyName 'NombreClaveSmtp'
```

## PARAMETERS

### -Attachment
nombre del adjuntos que se desea obtener.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: *
Accept pipeline input: False
Accept wildcard characters: True
```

### -IdRule
Identificador de la regla de la cual se desea obtener los adjuntos.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: *
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

## INPUTS

## OUTPUTS
Identificador numérico de una plantilla previamente registrada (IdTemplate). Lo puede recibir en forma de HashTable.
## NOTES
---------------------------------------------------------
Autor: \<MVera\>
Última Modificación: 14/Ene/19

---------------------------------------------------------

## RELATED LINKS
[Get-Template](Get-Template.md)

[Get-SmtpConnection](Get-SmtpConnection.md)

[Add-ProcessNotification](Add-ProcessNotification.md)

[Get-ProcessNotification](Get-ProcessNotification.md)

[Remove-ProcessNotification](Remove-ProcessNotification.md)

[Update-ProcessNotification](Update-ProcessNotification.md)]
