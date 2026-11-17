
#!/bin/bash

set -Eeuo pipefail

# Rutas del proyecto
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Cargar variables de entorno
if [[ ! -f "$SCRIPT_DIR/.env" ]]; then
    echo "Error: no existe scripts/.env"
    exit 1
fi

set -a
source "$SCRIPT_DIR/.env"
set +a

# Comprobar variables obligatorias
: "${DB_HOST:?Falta DB_HOST en .env}"
: "${DB_PORT:?Falta DB_PORT en .env}"
: "${DB_DATABASE:?Falta DB_DATABASE en .env}"
: "${DB_USERNAME:?Falta DB_USERNAME en .env}"
: "${DB_PASSWORD:?Falta DB_PASSWORD en .env}"

WEB_DIR="/var/www/html"
SQL_FILE="$PROJECT_DIR/db/database.sql"

echo "Iniciando despliegue de ${APP_NAME:-MiWeb}..."

# Comprobar archivos necesarios
for file in "$SQL_FILE" "$PROJECT_DIR/src/config.php" "$PROJECT_DIR/src/index.php"; do
    if [[ ! -f "$file" ]]; then
        echo "Error: falta el archivo $file"
        exit 1
    fi
done

# Comprobar servicios y herramientas
for cmd in mysql php apache2ctl; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: no está instalado $cmd."
        echo "Ejecuta primero install_lamp.sh."
        exit 1
    fi
done

# Crear base de datos y usuario
echo "Configurando la base de datos..."

sudo mysql <<SQL
CREATE DATABASE IF NOT EXISTS \`$DB_DATABASE\`;
CREATE USER IF NOT EXISTS '$DB_USERNAME'@'localhost'
IDENTIFIED BY '$DB_PASSWORD';
ALTER USER '$DB_USERNAME'@'localhost'
IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON \`$DB_DATABASE\`.* TO '$DB_USERNAME'@'localhost';
FLUSH PRIVILEGES;
SQL

# Importar la base de datos
echo "Importando el esquema SQL..."
sudo mysql "$DB_DATABASE" < "$SQL_FILE"

# Copiar la aplicación
echo "Copiando archivos a Apache..."
sudo mkdir -p "$WEB_DIR"
sudo cp -a "$PROJECT_DIR/src/." "$WEB_DIR/"

# Ajustar permisos básicos
sudo chown -R www-data:www-data "$WEB_DIR"
sudo find "$WEB_DIR" -type d -exec chmod 755 {} \;
sudo find "$WEB_DIR" -type f -exec chmod 644 {} \;

# Validar y reiniciar Apache
sudo apache2ctl configtest
sudo systemctl enable apache2
sudo systemctl restart apache2

echo "Despliegue finalizado."
echo "Comprueba la aplicación en http://TU_IP_PUBLICA/"
