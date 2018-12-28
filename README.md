# PSEmailNotification
![Curent release](https://img.shields.io/badge/Version-1.0.6927.29731-orange.svg)

PSEmailNotification es un módulo de PowerShell que permite registrar las plantillas para los correos de notificación remitidos a los clientes al finalizar cada proceso.

**Configuracion Inicial**

Cuando se realiza la instalación e importación del módulo por primera vez se debe ejecutar la funcion **Set-Configuration** permitiendo desplegar una ventana para realizar el ingreso de los valores de los parametros de entrada.


**Parametros de entrada**
```powershell
Set-Configuration
```
<h2 align="center"><img src="Setup/Configuration.png" /></h2>

**1. Registrar Plantilla**

Ejemplo:
```powershell
Add-Template -Name 'NotificationLoadFiles' -Path 'X:\Path' -Subject 'Notification Load Files'
```

Use el comando **Get-Template** para ver las propiedades de todas las plantilla creadas.

```powershell
Get-Template
```
<h2 align="center"><img src="Setup/Get Account.png" /></h2>

**2. Creación de Proceso**

La plantila debe estar asociada a uno o varios procesos creados con anterioridad, en donde se establece el nombre de la llave de la conexion SMTP configurada en el momento en que se ejecuto **Set-Configuration** y el IdTemplate de la plantilla.

Ejemplo:

```powershell
 Add-Process -Name 'Pro_NotificationLoadFiles' -SmtpKeyName 'Corporativo' -IdTemplate 1
```
Use el comando **Get-Process** para ver las propiedades de los procesos creados.

```powershell
Get-Process
```
<h2 align="center"><img src="Setup/Get Account.png" /></h2>

**3. Creación de Recipiente**

Para registrar el recipiente o destinatario se establece el IdProceso y el correo electrónico.

Ejemplo:

```powershell
  Add-Recipient -Name 'Rec_NotificationLoadFiles' -IdProcess 1 -Email 'cliente@server.com'
```
Use el comando **Get-MailRecipient** para ver las propiedades de los recipientes creados.

```powershell
Get-MailRecipient
```
<h2 align="center"><img src="Setup/Get Account.png" /></h2>

**4. Envio de Notificación**

Utilice el comando **Send-Notification**. Para ejecutar el envio de notificaciones se debe establecer los siguientes parametros.

Sintaxis:

```powershell
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

## Estructura de la documentación
Las carpetas corresponden a los siguientes recursos de información:

| Carpeta  | Descripción  |
|:---|---|
| [Funciones](Functions)  | Contiene las ayudas de las funciones públicas del módulo|
