# Sistema de Evaluación - Semestre i

Este sistema fue desarrollado durante los semestres Enero-Mayo y Agosto-Diciembre de 2018 como servicio becario para la carrera de ISC del Tecnológico de Monterrey Campus Querétaro por Bernardo Ortega Septién, Martin Molinero Morales y Moisés Montaño Copca. 

This work is licensed under a Creative Commons Attribution 4.0 International License: http://creativecommons.org/licenses/by/4.0/

## Crear Bases de Datos

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

Production

CREATE DATABASE bloque_production_db; 
CREATE ROLE bloque_production_admin WITH LOGIN PASSWORD 'bloque_production_password'; 
GRANT ALL PRIVILEGES ON DATABASE bloque_production_db TO bloque_production_admin; 
ALTER USER bloque_production_admin CREATEDB;
