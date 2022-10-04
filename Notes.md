Instalamos MySQL workbench
Instalamos PostgreSQL Admin

**PostgreSQL**
Puerto por defecto ``5432``

**MySQL**
Puerto por defecto ``3306``
Username: root

**Herramientas GUI**
* pgAdmin
* MySQL Workbench
* DBeaver
* DataGrip

**Conexión a BD**
PostgreSQL: abrir pg Admin y crear un nuevo servidor para conectarse con usuario postgres.
	- usuario: ``postgres``
	- passwowrd: ``****``
	
MySQL Workbench: 
	- usuario: ``root``
	- passwowrd: ``****``

## Cargar bases de datos de prueba

Para Postgre:
https://github.com/devrimgunduz/pagila

### Cargar base de datos pagila (PostgreSQL)

1. ``CREATE DATABASE pagila``
2.  En la cmd ejecutar el sql para crear el esquema: ``psql -h localhost -p 5432 -U postgres -d pagila < pagila-schema.sql``
3.  En la cmd ejecutar para poblar el esquema: ``psql -h localhost -p 5432 -U postgres -d pagila < pagila-data.sql``


--