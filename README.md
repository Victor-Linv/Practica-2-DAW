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