CREATE DATABASE employees_2;
DROP DATABASE employees_2;

-- Creación de tablas
CREATE TABLE IF NOT EXISTS employees(
	id INT,
	name VARCHAR,
	
);

-- ver datos de una tabla
SELECT * FROM employees; -- * means ALL


-- Tipos de datos: boolean
CREATE TABLE IF NOT EXISTS employees(
	id INT,	
	married BOOL
	name VARCHAR(250),
);

-- Insertar datos a una tabla
INSERT INTO  employees (id, married) VALUES (1, FALSE);	-- solo ponemos las columnas en las que queremos insertar valores.
INSERT INTO  employees (id, married) VALUES (2, TRUE);
INSERT INTO employees (id, "name", married) VALUES (3, 'fernando', TRUE);

-- Tipos de datos: CHAR, VARCHAR, TEXT
CREATE TABLE IF NOT EXISTS employees(
	id INT,	
	married BOOL,
	name VARCHAR(250),
	genre CHAR(1)
);

INSERT INTO  employees (id, married, "name", genre) VALUES (1, FALSE, 'Fernando', 'M');

-- Tipo de datos NUMERIC
CREATE TABLE IF NOT EXISTS employees(
	id INT,	
	married BOOL,
	name VARCHAR(250),
	genre CHAR(1),
	salary NUMERIC(9,2)
	
);

INSERT INTO  employees (id, married, "name", genre, salary) VALUES (1, FALSE, 'Fernando', 'M', 29567.23);

-- Tipo de datos DATE
CREATE TABLE IF NOT EXISTS employees(
	id INT,	
	married BOOL,
	name VARCHAR(250),
	genre CHAR(1),
	salary NUMERIC(9,2),
	birth_date DATE	
);

INSERT INTO  employees (id, married, "name", genre, salary, birth_date) VALUES (1, FALSE, 'Fernando', 'M', 29567.23,'1990-12-25');

-- Tipo de datos TIME
CREATE TABLE IF NOT EXISTS employees(
	id INT,	
	married BOOL,
	name VARCHAR(250),
	genre CHAR(1),
	salary NUMERIC(9,2),
	birth_date DATE,
	start_at TIME
);

INSERT INTO  employees (id, married, "name", genre, salary, birth_date, start_at)
VALUES (1, FALSE, 'Fernando', 'M', 29567.23,'1990-12-25', '08:00:00');

-- Identificador
CREATE TABLE IF NOT EXISTS employees(
	id SERIAL,	
	married BOOL,
	name VARCHAR(250),
	genre CHAR(1),
	salary NUMERIC(9,2),
	birth_date DATE,
	start_at TIME
);

INSERT INTO  employees (married, "name", genre, salary, birth_date, start_at)
VALUES (FALSE, 'Fernando', 'M', 29567.23,'1990-12-25', '08:30:00');

-- Verificar que todavía/ya no permite insertar un id duplicado
INSERT INTO  employees (id, married, "name", genre, salary, birth_date, start_at)
VALUES (1, FALSE, 'Fernando', 'M', 29567.23,'1990-12-25', '08:30:00');

--  Hacer que un campo sea obligatorio NOT NULL
CREATE TABLE IF NOT EXISTS employees(
	id SERIAL PRIMARY KEY,	
	married BOOL,
	name VARCHAR(250) NOT NULL,
	genre CHAR(1),
	salary NUMERIC(9,2),
	birth_date DATE,
	start_at TIME
);

-- Comprobar que no deja insertar el empleado sin ponerle un name
INSERT INTO  employees (married, "name", genre, salary, birth_date, start_at)
VALUES (FALSE, 'Fernando', 'M', 29567.23,'1990-12-25', '08:30:00');

-- Hacer que un campo sea único con UNIQUE
CREATE TABLE IF NOT EXISTS employees(
	id SERIAL PRIMARY KEY,	
	married BOOL,
	name VARCHAR(250) NOT NULL,
	email VARCHAR(100) UNIQUE,
	genre CHAR(1),
	salary NUMERIC(9,2),
	birth_date DATE,
	start_at TIME
	-- UNIQUE (email, name)
);

-- Verificar que nos saca el error de que el email está repetido
INSERT INTO  employees (married, "name", email, genre, salary, birth_date, start_at)
VALUES (FALSE, 'Fernando', 'fernando@employee.com', 'M', 29567.23,'1990-12-25', '08:30:00');
INSERT INTO  employees (married, "name", email, genre, salary, birth_date, start_at)
VALUES (FALSE, 'Paco', 'fernando@employee.com', 'M', 29567.23,'1990-12-25', '08:30:00');

SELECT * FROM employees;

-- Restricciones en rangos de datos
CREATE TABLE IF NOT EXISTS employees(
	id SERIAL PRIMARY KEY,	
	married BOOL,
	name VARCHAR(250) NOT NULL,
	email VARCHAR(100) UNIQUE,
	genre CHAR(1),
	salary NUMERIC(9,2) CHECK (salary > 0),
	birth_date DATE CHECK (date > '1975-01-01',
	start_at TIME
	-- UNIQUE (email, name)
);

INSERT INTO  employees (married, "name", email, genre, salary, birth_date, start_at)
VALUES (FALSE, 'Fernando', 'fernand@employee.com', 'M', -10,'1990-12-25', '08:30:00');


-- Primary Key
CREATE TABLE IF NOT EXISTS employees(
	id SERIAL PRIMARY KEY,	
	married BOOL,
	name VARCHAR(250),
	genre CHAR(1),
	salary NUMERIC(9,2),
	birth_date DATE,
	start_at TIME
);

INSERT INTO  employees (married, "name", genre, salary, birth_date, start_at)
VALUES (FALSE, 'Fernando', 'M', 29567.23,'1990-12-25', '08:30:00');

-- Renombrar tabla
ALTER TABLE IF EXISTS employees RENAME TO employees_2022;

-- Agregar columnas a las tablas
ALTER TABLE employees ADD COLUMN email VARCHAR(100);

-- Borrar columnas de una tabla
ALTER TABLE employees DROP COLUMN IF EXISTS email;

-- Borrar tablas
DROP TABLE IF EXISTS employees;
