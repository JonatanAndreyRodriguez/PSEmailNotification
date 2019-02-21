# PSEmailNotification
![Curent release](https://img.shields.io/badge/Version-1.0.6948.49970-orange.svg)

PSEmailNotification es un módulo de PowerShell que permite enviar correos electrónicos a partir de plantillas creadas en HTML las cuales utilizan una serie de tokens parametrizables según el procedimiento de notificación al finalizar cada uno de ellos.

**Configuracion Inicial**

Cuando se realiza la instalación e importación del módulo por primera vez se debe ejecutar la funcion **Set-Configuration** permitiendo desplegar una ventana para realizar el ingreso de los valores de los parametros de entrada.


**Parametros de entrada**
```powershell
Set-Configuration
```
<h2 align="center"><img src="Setup/Configuration.png" /></h2>

**1. Registrar Plantilla**

Registra plantillas de correo en formato HTML: nombre descriptivo, ruta de la plantilla en disco y asunto del correo.

Ejemplo:
```powershell
Add-Template -Name 'NotificationLoadFiles' -Path 'X:\Path' -Subject 'Notification Load Files'
```
Comandos relacionados:

| Comando  | Descripción  |
|:---|---|
| Get-Template  | Permite visualizar las propiedades de la plantilla|
| Remove-Template  | Permite la eliminación de la plantilla|
| Update-Template  | Permite la actualización de la plantilla|

<h2 align="center"><img src="Setup/Get Account.png" /></h2>

**2. Creación de Proceso**

La plantila debe estar asociada a uno o varios procesos, para ello se debe establecer el nombre de la llave de la conexion SMTP configurada en el momento en que se ejecuto **Set-Configuration** y el IdTemplate asignado a la plantilla creada, con la funcion Get-Template se puede visualizar su valor.

Ejemplo:

```powershell
 Add-ProcessNotification -Name 'Pro_NotificationLoadFiles' -SmtpKeyName 'Corporativo' -IdTemplate 1
```

Comandos relacionados:

| Comando  | Descripción  |
|:---|---|
| Get-ProcessNotification  | Permite visualizar las propiedades de la plantilla|
| Remove-ProcessNotification  | Permite la eliminación de la plantilla|
| Update-ProcessNotification  | Permite la actualización de la plantilla|
| Get-SmtpConnection  | Permite visualizar los parametros de conexión|


<h2 align="center"><img src="Setup/Get Account.png" /></h2>

**3. Creación de Recipiente**

Para registrar el recipiente o destinatario se debe relacionar el IdProceso creado anteriormente, el cual se puede establecer su valor ejecutando el comando **Get-ProcessNotification** y el correo electrónico.

Ejemplo:

```powershell
  Add-Recipient -IdProcess 1 -Email 'cliente@server.com'
```
Comandos relacionados:

| Comando  | Descripción  |
|:---|---|
| Get-Recipient  | Obtiene los correos electrónicos registrados. |
| Remove-Recipient  | Borra recipiente según su identificador de proceso.|

<h2 align="center"><img src="Setup/Get Account.png" /></h2>

**4. Envio de Notificación**

Utilice el comando **Send-Notification**. Para ejecutar el envío de notificaciones se debe establecer los siguientes parámetros.

Sintaxis:

```powershell
  $Tokens = @{Clave1 = 'Valor1'; Clave2 = 'Valor2'; Clave3 = 'Valor3'}
  Send-Notification -ProcessName 'NombreDelProceso' -TokenList $Tokens
```

Ejemplo:
```powershell
 Send-Notification -ProcessName 'Pro_NotificationLoadFiles' -Tokens @{
 ArchivoProcesado='Archivo'; 
 CantidadRegistros='1'; 
 RegistrosProcesados='2'; 
 RegistrosInvalidos='3'; 
 ArchivoLog='log'; 
 RutaArchivoLog='ruta'
 }
```

## Nota
-El Token tiene una estructura de llave=valor y la llave se determina según como se haya establecidos en la plantilla

-Para realizar modificación a los tokens ya registrados es necesario evaluar su estructura con el área de soporte a aplicaciones.

## Estructura de la documentación
Las carpetas corresponden a los siguientes recursos de información:

| Carpeta  | Descripción  |
|:---|---|
| [Funciones](Functions.md)  | Contiene las ayudas de las funciones públicas del módulo|
