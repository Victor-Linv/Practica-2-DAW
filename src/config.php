<?php

define('DB_HOST', 'localhost');
define('DB_NAME', 'lamp_db');
define('DB_USER', 'lamp_user');
define('DB_PASSWORD', '1234');

$mysqli = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

if (!$mysqli) {
    error_log('Error de conexión MySQL: ' . mysqli_connect_error());
    http_response_code(500);
    exit('Error al conectar con la base de datos.');
}

mysqli_set_charset($mysqli, 'utf8mb4');