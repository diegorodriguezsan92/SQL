-- Nos permite saber el tamaño de una DB.
SELECT pg_size_pretty (pg_database_size('northwind'));

-- Conocer el tamaño de todas las DB.
SELECT pg_database.datname, pg_size_pretty (pg_database_size(pg_database.datname)) as size FROM pg_database;

-- Ver el tamaño de una tabla.
SELECT pg_size_pretty(pg_relation_size('orders'));


-- Persona de contacto de cada pedido
SELECT o.order_id, cu.contact_name FROM orders o
INNER JOIN customers cu ON cu.customer_id = o.customer_id

-- Persona de contacto y repartidor de cada pedido
SELECT o.order_id, cu.contact_name, s.company_name FROM orders o
INNER JOIN customers cu ON cu.customer_id = o.customer_id
INNER JOIN shippers s ON s.shipper_id = o.ship_via

-- GROUP BY
SELECT country, COUNT(customer_id) AS num_customers FROM customers GROUP BY country ORDER BY num_customers DESC;
SELECT city, COUNT(customer_id) AS num_customers FROM customers GROUP BY city ORDER BY num_customers DESC;

-- Cuántos pedidos ha hecho cada cargo en la compañia
SELECT e.title, COUNT(o.order_id) AS num_orders FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id
GROUP BY e.title
ORDER BY num_orders DESC

SELECT e.first_name, e.last_name, COUNT(o.order_id) AS num_orders FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id
GROUP BY e.first_name, e.last_name
ORDER BY num_orders DESC

-- Vistas. Simplemente estamos añadiendo la primera línea al código anterior.
CREATE VIEW orders_by_employee AS 
SELECT e.first_name, e.last_name, COUNT(o.order_id) AS num_orders FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id
GROUP BY e.first_name, e.last_name
ORDER BY num_orders DESC

-- Para invocar la anterior consulta ahora solamente tenemos que llamar a orders_by_employees
SELECT * FROM orders_by_employee;

-- Vistar materializadas: guardan en caché el resultado de una query y periódicamente actaulizan datos.

/*
CREATE MATERIALIZED VIEW IF NOT EXISTS view_name AS
query
WITH [NO] DATA;
*/

CREATE MATERIALIZED VIEW IF NOT EXISTS mv_orders_by_employee AS
SELECT e.first_name, e.last_name, COUNT(o.order_id) AS num_orders FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id
GROUP BY e.first_name, e.last_name
ORDER BY num_orders DESC
WITH DATA;

SELECT * FROM mv_orders_by_employee

-- INSERT a la vez que muestra los datos
CREATE TABLE example(
	id INT,
	name VARCHAR
);

SELECT * FROM pg_matviews -- mostrar las vistas materializadas

INSERT INTO example(id)
SELECT * FROM generate_series(1,50);

-- Solo generar los datos:
SELECT * FROM generate_series(1,50);
SELECT * FROM generate_series(1,50,2); -- inicio, final y salto 2, de forma que saque los impares

SELECT * FROM generate_series(
	'2022-01-01 00:01':: timestamp,
	'2022-12-31 23:59',
	'6 hours' -- salto 6 horas
);


SELECT * FROM order_details;

-- EXPLAIN ANALIZE: análisis del coste/tiempo de la query
EXPLAIN ANALYZE SELECT * FROM order_details;

-- INDICES
CREATE INDEX idx_orders_pk ON orders(order_id)
EXPLAIN ANALYZE SELECT * FROM orders

-- Particiones: divide una tabla en distintas particiones, y se usa cuando las tablas son muy grandes y costaría mucho escanear tantos datos, por lo que se generan consultas más pequeñas que requieren menos tiempo de consulta.
	-- Rango
	-- Lista
	-- Hash
	
CREATE TABLE users(
	id BIGSERIAL,
	birth_date DATE,
	name VARCHAR(20),
	primary key(id, birth_date)
) PARTITION BY RANGE (birth_date);


-- Crear particiones
CREATE TABLE users_2020 PARTITION OF users
FOR VALUES FROM ('2020-01-01') TO ('2021-01-01'); -- el segundo campo está excluido, por lo que estamos seleccionando todo el año 2020.

CREATE TABLE users_2021 PARTITION OF users
FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

CREATE TABLE users_2022 PARTITION OF users
FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

INSERT INTO users(birth_date, name)
VALUES
('2020-01-15', 'User1'),
('2022-11-01', 'User2'),
('2020-12-17', 'User3'),
('2021-09-16', 'User4'),
('2020-02-21', 'User5'),
('2022-06-09', 'User6'),
('2022-05-15', 'User7'),
('2020-08-02', 'User8');

SELECT * FROM users;
SELECT * FROM users_2020;
SELECT * FROM users_2021;
SELECT * FROM users_2022;

EXPLAIN ANALYZE SELECT * FROM users WHERE birth_date = '2020-12-17'; -- con las particiones ahorramos tiempo en las consultas porque automáticamente busca dentro de la partición específica y no entre todos los registros.

-- EXTRACT
SELECT * FROM users WHERE EXTRACT (DAY FROM birth_date) = 15;

-- Cargar extensiones
CREATE EXTENSION nombre_de_la_extension





