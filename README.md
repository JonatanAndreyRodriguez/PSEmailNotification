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

Use el comando **Get-Template** para ver las propiedades de la plantilla creada.

```powershell
Get-Template '
```
<h2 align="center"><img src="Setup/Get Account.png" /></h2>

**2. Creación de Proceso**

La plantila debe estar asociada a uno o varios procesos creados con anterioridad, en donde se establece el nombre de la llave de la conexion SMTP configurada en el momento en que se ejecuto **Set-Configuration**.
Ejemplo:

```powershell
Add-Process -Name 'Pro_NotificationLoadFiles' -KeySmtp -Path
```


**2. Creación de Proceso**

La plantila debe estar asociada a uno o varios procesos creados con anterioridad, en donde se establece el nombre de la llave de la conexion SMTP configurada en el momento en que se ejecuto **Set-Configuration**.

Ejemplo 1:
```powershell
$RuleInformation = @{
  Name             = $RuleName 
  AuthorizedSender = 'MyMail@MyDomain.com'
  Subject          = 'Subject To Process',' Subject 2' 
  AttachmentsName  = '*.txt','AttachmentToProcess.txt' 
  PluginName       = $Plugin
  ResponseTemplatePath = 'C:\PathFileCustomTemplate.html'
}
Register-Rule @RuleInformation
```
- **Nota:**
Para la propiedad **AuthorizedSenderPath**, se debe establece la ruta del archivo plano, cada correo electronico o email debe estar separado por un salto de linea.

Ejemplo:
```powershell
correo@server.com
correo2@server.com
correo3@server.com
```
  
Use el comando **Get-Rule** para ver las propiedades de la regla de bandeja de entrada.

```powershell
Get-Rule -Name 'MyRuleName'
```
Ejemplo:
<h2 align="center"><img src="Setup/Get RuleName.png" /> </h2>

Cada regla tiene asignado un número identificador el cual se denomina **Id de Regla**, para el ejemplo anterior el número identificador tiene el valor de 14, el cual se utilizará para relacionar la cuenta de correo con la regla.

**3. Asociar una cuenta de correo con una regla**

Para asociar se debe establecer como parámetros la cuenta de correo y el número identificador de la regla, para el siguiente ejemplo, el número identificador de la regla tiene el valor de 14

Ejemplo:
```powershell
Get-EmailAccount -EmailAddress 'MyMail@MyDomain.com' | Add-RuleToEmailAccount -IdRule 14
```

Use el comando **Get-EmailAccount** para ver las reglas asociadas una cuenta:
```powershell
Get-EmailAccount -EmailAddress 'MyMail@MyDomain.com' | Get-Rule
```
Use el comando **Remove-RuleFromEmailAccount** para remover la regla asociadas a una cuenta, se debe tener presente la cuenta de correo y el número identificador de la regla, para el siguiente ejemplo, el número identificador de la regla tiene el valor de 1:
```powershell
Get-EmailAccount -EmailAddress 'MyMail@MyDomain.com' | Remove-RuleFromEmailAccount -IdRule 1
```

- **Nota:**
Los comandos y parámetros anteriormente señalados del módulo corresponden a la configuración básica para iniciar el proceso de [Monitoreo de correos](Setup/Monitor-Emails.md). Para ver mas opciones de configuración, ingresar a los link de Setup y Funciones expuestos en la estructura de la documentación.

## Estructura de la documentación
Las carpetas corresponden a los siguientes recursos de información:

| Carpeta  | Descripción  |
|:---|---|
| [Setup](Setup)  | Describe el proceso de instalación|
| [Funciones](Functions)  | Contiene las ayudas de las funciones públicas del módulo|
| [Logs](Logs.md)  | Establece las pautas de seguimiento de las trazas de ejecución de cada proceso|
