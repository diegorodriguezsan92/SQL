-- Sentencias DML
-- CRUD

-- 1. Consultas o recuperación de datos

SELECT * FROM employees;

SELECT id FROM employees;

SELECT id, name, genre FROM employees;

INSERT INTO  employees (married, "name", genre, salary, start_at)
VALUES (FALSE, 'Fernando', 'M', 29567.23, '08:30:00');

INSERT INTO employees (married, "name", genre, salary, start_at)
VALUES (TRUE, 'Juan', 'F', 12000, '08:25:00');
INSERT INTO employees (married, "name", genre, salary, start_at)
VALUES (FALSE, 'Manuel', 'M', 15000, '07:45:59');

-- Filtrar filas
SELECT * FROM employees WHERE id = 3;
SELECT * FROM employees WHERE married = 'FALSE';
SELECT * FROM employees WHERE start_at > '08:00:00';
SELECT * FROM employees WHERE start_at > '08:00:00' AND married = 'FALSE';
SELECT * FROM employees WHERE start_at > '08:00:00' OR married = 'FALSE';

-- Filtrado de columnas
SELECT name FROM employees;
SELECT name FROM employees WHERE married = 'FALSE';


-- 2. Inserción de datos

INSERT INTO employees (name, married, salary, genre) VALUES ('Isabel', TRUE, '18500', 'M');

INSERT INTO employees (name, married, email, salary, genre, start_at)
VALUES ('Fátima', TRUE, 'fatima@employees.com', '19000', 'M', '10:05:00');

INSERT INTO employees
VALUES (8, 'TRUE', 'Fekir', 'fekir@employees.com', 'F', 23000, '09:25:00'),
(9, 'FALSE', 'Canales', 'Canales@employees.com', 'M', 21000, '09:00:00');


-- 3. Actualizar o editar datos

UPDATE employees SET married = 'M' -- con este comando actualizaríamos todas las filas a género M

UPDATE employees SET email = 'Juan@employees.com' WHERE id = 1;
UPDATE employees SET email = 'Manuel@employees.com' WHERE name = 'Manuel';

UPDATE employees SET email = 'fernando@employees.com' WHERE name = 'Fernando';
UPDATE employees SET email = 'isabel@employees.com' WHERE name = 'Isabel';
SELECT * FROM employees;

UPDATE employees SET start_at = '10:30:50' WHERE id = '4';

UPDATE employees SET salary = 20000 WHERE name = 'Manuel';
SELECT * FROM employees;

UPDATE employees SET genre = 'M', start_at = '09:30:00', email = 'elbarbas@employees.com' WHERE name = 'Fekir';
SELECT * FROM employees;

UPDATE employees SET name = 'Nabil', email = 'nabilfekir@employees.com' WHERE name = 'Fekir' RETURNING *; -- RETURNING * nos devuelve todos los registros afectados por la actualización.


-- 4. Borrar

DELETE FROM employees; -- Elimina todos los datos de la tabla

DELETE FROM employees WHERE name = 'Fernando';
SELECT * FROM employees;

DELETE FROM employees WHERE start_at > '07:00:00' AND start_at < '08:00:00';
SELECT * FROM employees;