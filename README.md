# Practica-2-DAW

## 1. Organización del proyecto

Vamos a clonar el repositorio proporcionado por el profesor y crearemos los archivos necesarios para realizar el despliegue.

La estructura del proyecto es la siguiente:

```text
iaw-practica-lamp/
├── README.md
├── conf/
│   └── 000-default.conf
├── db/
│   └── database.sql
├── scripts/
│   ├── .env
│   ├── install_lamp.sh
│   └── deploy.sh
└── src/
    ├── add.html
    ├── add.php
    ├── config.php
    ├── delete.php
    ├── edit.php
    └── index.php
```

El directorio "conf" contiene la configuración de Apache, "db" contiene el archivo SQL de la base de datos, "scripts" contiene los archivos utilizados para automatizar la instalación y el despliegue, y "src" contiene el código fuente de la aplicación web.

## 2. Configurar las variables de entorno

He creado el archivo `scripts/.env` para centralizar las variables de configuración de la aplicación.

En este archivo he definido el nombre de la aplicación, el entorno de ejecución, la URL y los datos necesarios para conectar con la base de datos MySQL.

Las variables principales son:

- `APP_NAME`: nombre de la aplicación.
- `APP_ENV`: entorno de ejecución.
- `APP_DEBUG`: indica si está activado el modo de depuración.
- `APP_URL`: dirección desde la que se accede a la aplicación.
- `DB_HOST`: servidor de la base de datos.
- `DB_PORT`: puerto de MySQL.
- `DB_DATABASE`: nombre de la base de datos.
- `DB_USERNAME`: usuario de MySQL.
- `DB_PASSWORD`: contraseña del usuario de la base de datos.
- `APP_KEY`: variable reservada para la clave de la aplicación, si es necesaria.

Vamos a utilizar "localhost" como servidor de base de datos porque MySQL se ejecuta en la misma instancia EC2 que Apache y PHP.

## 3. Instalación de la pila LAMP

Ahora vamos a hacer la instalación de la pila_lamp

Para ello utilizaremos el script de install_lamp.sh

Vamos a ejecutar el script desde la terminal de Ubuntu con permisos de administrador:

"bash"
"sudo bash scripts/install_lamp.sh"

Una vez realizada la instalación, comprobaremos el estado de los servicios para verificar que el servidor dispone de los componentes necesarios para ejecutar la aplicación.


## 4. Configuración de Apache

La configuración principal es la siguiente:

```apache
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    DirectoryIndex index.php index.html

    <Directory "/var/www/html">
        AllowOverride All
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

De esta forma, Apache puede servir los archivos PHP de la aplicación desde su directorio web.

## 5. Configuración de la base de datos

La aplicación utiliza una base de datos MySQL llamada "lamp_db" y un usuario específico llamado "lamp_user".

El archivo "db/database.sql" contiene las instrucciones SQL necesarias para crear la tabla "users".

Esta tabla almacena los siguientes campos:

## 6. Configuración de la aplicación PHP

Vmaos a configurar los valores necesarios para que la aplicación utilice la base de datos "lamp_db" y el usuario "lamp_user".

La conexión se realiza mediante la extensión "mysql" de PHP.

De esta manera, los distintos archivos PHP de la aplicación pueden acceder a la base de datos para consultar, añadir, modificar y eliminar registros.

## 7. Automatización del despliegue

Para automatizar el despliegue vamos a crear el script "scripts/deploy.sh".

Este script utiliza las variables definidas en ".env" y realiza las operaciones necesarias para preparar la aplicación en el servidor web.


Para ejecutar el despliegue utilizaremos el siguiente comando desde el directorio raíz del proyecto:

bash
bash scripts/deploy.sh
