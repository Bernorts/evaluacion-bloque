Crear Bases de Datos

Desarrollo

CREATE DATABASE bloque_development_db;
CREATE ROLE bloque_development_admin WITH LOGIN PASSWORD 'bloque_admin_password';
GRANT ALL PRIVILEGES ON DATABASE bloque_development_db TO bloque_development_admin;
ALTER USER bloque_development_admin CREATEDB;

Tests

CREATE DATABASE bloque_test_db;
CREATE ROLE bloque_test_admin WITH LOGIN PASSWORD 'bloque_test_password';
GRANT ALL PRIVILEGES ON DATABASE bloque_test_db TO bloque_test_admin;
ALTER USER bloque_test_admin CREATEDB;