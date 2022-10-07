**CONCESIONARIO**

SELECT * FROM manufacturer;

CREATE TABLE 

-- MODEL
CREATE TABLE model(
	id SERIAL,
	name VARCHAR(50) NOT NULL,
	id_manufacturer INT,
	CONSTRAINT pk_model PRIMARY KEY(id),
	CONSTRAINT fk_model_manufacturer FOREIGN KEY(id_manufacturer) REFERENCES manufacturer(id)
);
SELECT * FROM model;

INSERT INTO model (name, id_manufacturer) VALUES ('Mondeo', 1);
INSERT INTO model (name, id_manufacturer) VALUES ('Kuga', 1);
INSERT INTO model (name, id_manufacturer) VALUES ('Golf', 2);
INSERT INTO model (name, id_manufacturer) VALUES ('Polo', 2);
INSERT INTO model (name, id_manufacturer) VALUES ('305', 3);
SELECT * FROM model;

INSERT INTO model (name, id_manufacturer) VALUES ('203', 4);
INSERT INTO model (name, id_manufacturer) VALUES ('204', 4);
INSERT INTO model (name, id_manufacturer) VALUES ('205', 4);
INSERT INTO model (name, id_manufacturer) VALUES ('Laguna', 5);
INSERT INTO model (name, id_manufacturer) VALUES ('Cordoba', 6);
INSERT INTO model (name, id_manufacturer) VALUES ('Toledo', 6);
INSERT INTO model (name, id_manufacturer) VALUES ('Ibiza', 6);
INSERT INTO model (name, id_manufacturer) VALUES ('Leon', 6);
SELECT * FROM model;

-- VERSION
CREATE TABLE version(
	id SERIAL,
	name VARCHAR(50),
	engine VARCHAR(50),
	price NUMERIC,
	cc NUMERIC(2,1),
	id_model INT,
	CONSTRAINT pk_version PRIMARY KEY (id),
	CONSTRAINT fk_version_model FOREIGN KEY(id_model) REFERENCES model(id) ON UPDATE set null ON DELETE set null
);

SELECT * FROM version;

INSERT INTO version (name, engine, price, cc, id_model) VALUES ('Basic', 'Diesel 4C', 30000, 1.9, 1);
INSERT INTO version (name, engine, price, cc, id_model) VALUES ('Medium', 'Diesel 5C', 50000, 2.2, 1);
INSERT INTO version (name, engine, price, cc, id_model) VALUES ('Advanced', 'Diesel 6C V', 80000, 3.2, 1);
SELECT * FROM version;

INSERT INTO version (name, engine, price, cc, id_model) VALUES ('Basic', 'Diesel 4C', 30000, 1.9, 2);
INSERT INTO version (name, engine, price, cc, id_model) VALUES ('Sport', 'Diesel 5C', 60000, 3.0, 2);

INSERT INTO version (name, engine, price, cc, id_model) VALUES ('Basic', 'Diesel 4C', 30000, 1.9, 3);
INSERT INTO version (name, engine, price, cc, id_model) VALUES ('Supra', 'Diesel 5C', 45000, 2.2, 3);

INSERT INTO version (name, engine, price, cc, id_model) VALUES ('Basic', 'Diesel 4C', 30000, 1.9, 4);
INSERT INTO version (name, engine, price, cc, id_model) VALUES ('Medium', 'Diesel 5C', 47000, 2.2, 4);
INSERT INTO version (name, engine, price, cc, id_model) VALUES ('Advanced', 'Diesel 6C V', 79500, 3.2, 4);
SELECT * FROM version;

-- EXTRA
CREATE TABLE extra(
	id SERIAL,
	name VARCHAR(50) NOT NULL,
	description VARCHAR(300),
	CONSTRAINT pk_extra PRIMARY KEY(id)
);

CREATE TABLE extra_version(
	id_version INT,
	id_extra INT,
	price NUMERIC NOT NULL CHECK (price >= 0),
	CONSTRAINT pk_extra_version PRIMARY KEY(id_version, id_extra),
	CONSTRAINT fk_version_extra FOREIGN KEY(id_version) REFERENCES version(id) ON UPDATE cascade ON DELETE cascade,
	CONSTRAINT fk_extra_version FOREIGN KEY(id_extra) REFERENCES extra(id) ON UPDATE cascade ON DELETE cascade
);

INSERT INTO extra (name, description) VALUES ('Techo solar', 'Techo solar relindo.');
INSERT INTO extra (name, description) VALUES ('Climatizador', 'Climatizador de alta potencia.');
INSERT INTO extra (name, description) VALUES ('Navegador', 'Navegador GPS.');
INSERT INTO extra (name, description) VALUES ('Frigorifico', 'Refrigerador 10 litros instalado en el maletero.');
SELECT * FROM extra;

SELECT * FROM extra_version;

SELECT * FROM manufacturer;
SELECT * FROM model;
SELECT * FROM version;
SELECT * FROM extra;

-- Ford Mondeo Basic con Techo Solar
INSERT INTO extra_version VALUES (1, 1, 3000);
-- Ford Mondeo Basic con Climatizador
INSERT INTO extra_version VALUES (1, 2, 1000);
-- Ford Mondeo Basic con Navegador
INSERT INTO extra_version VALUES (1, 3, 300);
-- Ford Mondeo Basic con Frigorífico
INSERT INTO extra_version VALUES (1, 4, 400);

-- Ford Mondeo Medium con Techo Solar
INSERT INTO extra_version VALUES (2, 1, 3000);
-- Ford Mondeo Basic con Climatizador
INSERT INTO extra_version VALUES (2, 2, 1000);
-- Ford Mondeo Basic con Navegador
INSERT INTO extra_version VALUES (2, 3, 300);
-- Ford Mondeo Basic con Frigorífico
INSERT INTO extra_version VALUES (2, 4, 400);

CREATE TABLE employee(
	id SERIAL,
	name VARCHAR(30),
	nif VARCHAR(9) NOT NULL UNIQUE,
	phone VARCHAR(9),
	CONSTRAINT pk_employee PRIMARY KEY(id)
);

CREATE TABLE customer(
	id SERIAL,
	name VARCHAR(30),
	nif VARCHAR(9),
	email VARCHAR(30) NOT NULL UNIQUE,
	CONSTRAINT pk_customer PRIMARY KEY(id)
);

CREATE TABLE vehicle(
	id SERIAL,
	license_num VARCHAR (7),
	creation_date DATE,
	price_gross NUMERIC,
	price_net NUMERIC,
	type VARCHAR(30),
	--
	id_manufacturer INT,
	id_model INT,
	id_version INT,
	id_extra INT,
	--
	CONSTRAINT pk_vehicle PRIMARY KEY(id),
	CONSTRAINT fk_vehicle_manufacturer FOREIGN KEY (id_manufacturer) REFERENCES manufacturer(id),
	CONSTRAINT fk_vehicle_model FOREIGN KEY (id_model) REFERENCES model(id),
	CONSTRAINT fk_vehicle_extra_version FOREIGN KEY (id_version, id_extra) REFERENCES extra_version(id_version, id_extra)
);

CREATE TABLE sale(
	id SERIAL,
	sale_date DATE,
	channel VARCHAR(300),
	--
	id_vehicle INT,
	id_employee INT,
	id_customer INT,
	--
	CONSTRAINT pk_sale PRIMARY KEY(id),
	CONSTRAINT fk_sale_vehicle FOREIGN KEY (id_vehicle) REFERENCES vehicle(id),
	CONSTRAINT fk_sale_employee FOREIGN KEY (id_employee) REFERENCES employee(id),
	CONSTRAINT fk_sale_customer FOREIGN KEY (id_customer) REFERENCES customer(id)
);

INSERT INTO employee(name, nif, phone) VALUES('Tom Bombadil', '123456789', '123456789');
INSERT INTO employee(name, nif, phone) VALUES('Bilbo Bolsón', '234567890', '123456789');
SELECT * FROM employee;

INSERT INTO customer(name, email) VALUES('Jerry Lee Lewis', 'jerry@employee.com');
INSERT INTO customer(name, email) VALUES('Aretha Franklin', 'aretha@employee.com');
SELECT * FROM customer;

SELECT * FROM vehicle;

INSERT INTO vehicle(license_num, price_gross, id_manufacturer, id_model, id_version, id_extra)
VALUES ('1234DRS', 40000, 1, 2, 1, 2);
INSERT INTO vehicle(license_num, price_gross, id_manufacturer, id_model, id_version, id_extra)
VALUES ('4321ARS', 50000, 2, 1, 2, 1);
INSERT INTO vehicle(license_num, price_gross, id_manufacturer, id_model, id_version, id_extra)
VALUES ('2143SJL', 60000, 2, 2, 3, 2);
SELECT * FROM vehicle;

INSERT INTO sale(sale_date, channel, id_vehicle, id_employee, id_customer)
VALUES('2022-01-05','Phone', '2', 1, 1);
SELECT * FROM sale;

-- 604 resultados
SELECT * FROM address;

-- 604 resultados
SELECT district FROM address;
SELECT first_name FROM customer; -- 600 resultados

-- Obtener resultados distintos:
SELECT DISTINCT district FROM address;
SELECT DISTINCT first_name FROM customer; -- 592 resultados 

-- Obtener resultados repetidos:
SELECT first_name FROM customer
GROUP BY 1 HAVING COUNT (*) > 1; -- 8 resultados

-- AND, OR, NOT
SELECT * FROM address WHERE district = 'California';
SELECT * FROM address WHERE district != 'California';
SELECT * FROM address WHERE NOT district = 'California';
SELECT * FROM address WHERE NOT district = 'California' ORDER BY district; -- ordenado por district

SELECT * FROM address WHERE district = 'Abu Dhabi' or district = 'California';

SELECT * FROM address WHERE district IS NOT null ORDER BY district;
SELECT * FROM address WHERE district IS NOT null AND NOT district = '' ORDER BY district;
SELECT * FROM address WHERE NOT district = '' ORDER BY district; -- Igual que el anterior

-- Contar el número de registros por cada distrito
SELECT district, COUNT(district) FROM address GROUP BY district ORDER BY district;
SELECT district, COUNT(district) AS num FROM address GROUP BY district ORDER BY district;

-- JOINS
SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;

-- Consulta a 2 tablas: customer y address
SELECT first_name, last_name, customer.address_id FROM customer
INNER JOIN address ON customer.address_id = address.address_id;

-- Misma consulta con abreviaciones
SELECT first_name, last_name, c.address_id FROM customer c
INNER JOIN address a ON c.address_id = a.address_id;

SELECT first_name, last_name, c.address_id, address FROM customer c
INNER JOIN address a ON c.address_id = a.address_id;

-- Consulta
SELECT c.email, a.address FROM customer c
INNER JOIN address a ON c.address_id = a.address_id;

-- Consulta a 3 tablas: customer, address, city
SELECT cu.email, cu.first_name, a.address, ci.city FROM customer cu
INNER JOIN address a ON cu.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id

-- Consulta a 4 tablas: customer, address, city, country
SELECT cu.email, cu.first_name, a.address, ci.city, co.country FROM customer cu
INNER JOIN address a ON cu.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id


SELECT * FROM actor;

-- Concatenar varias columnas en una sola:
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM actor;

-- Like:
SELECT * FROM film;
SELECT * FROM film WHERE description LIKE '% Drama %';
SELECT * FROM film WHERE description LIKE '% Monastery';

SELECT * FROM actor WHERE last_name LIKE '%LI%' ORDER BY last_name; -- si no indicamos nada el orden es ascendente.
SELECT * FROM actor WHERE last_name LIKE '%LI%' ORDER BY last_name DESC; -- orden descendente.


SELECT * FROM country;
SELECT * FROM country WHERE country = 'Spain' OR country = 'Germany' OR country = 'France';
-- Optimización:
SELECT * FROM country WHERE country IN ('Spain', 'Germany', 'France');

SELECT * FROM customer WHERE customer_id IN(15, 16, 17, 18);

SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name HAVING COUNT(last_name) > 1;

-- Obtener en cuántas películas ha aparecido cada actor:
SELECT * FROM film_actor;

SELECT f.title, COUNT(fa.actor_id) FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY f.title

--
SELECT cu.email, cu.first_name, a.address, ci.city FROM customer cu
INNER JOIN address a ON cu.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id

-- Stock de una película
SELECT * FROM inventory;

SELECT f.title, COUNT(i.inventory_id) as unidades FROM film f
INNER JOIN inventory i ON i.film_id = f.film_id
WHERE title = 'ACADEMY DINOSAUR'
GROUP BY title;

SELECT f.title, count(i.inventory_id) as unidades FROM film f
INNER JOIN inventory i ON i.film_id = f.film_id
WHERE title = 'FICTION CHRISTMAS'
GROUP BY title;

SELECT f.title, count(i.inventory_id) as unidades FROM film f
INNER JOIN inventory i ON i.film_id = f.film_id
GROUP BY title ORDER BY unidades DESC;

-- BUSQUEDA AVANZADA
SELECT a.first_name, COUNT(fa.film_id) as unidades FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY first_name;
-- COMPROBACIÓN
SELECT * FROM film_actor;
SELECT * FROM film_actor WHERE actor_id = '105';

---
---

-- SUMA
SELECT * FROM customer;

SELECT * FROM payment p
INNER JOIN customer c on p.customer_id = c.customer_id;

SELECT c.email, COUNT(p.payment_id) AS num_pagos FROM payment p
INNER JOIN customer c ON p.customer_id = c.customer_id
GROUP BY c.email

SELECT c.email, SUM(p.amount) as num_pagos FROM payment p
INNER JOIN customer c ON p.customer_id = c.customer_id
GROUP BY c.email

-- Facturación por empleado
SELECT s.first_name, COUNT (p.payment_id) AS num_pagos FROM payment p
INNER JOIN staff s ON p.staff_id = s.staff_id
GROUP BY s.staff_id

SELECT s.first_name, COUNT (p.payment_id) AS num_ventas, SUM(p.amount) as cantidad_ventas FROM payment p
INNER JOIN staff s ON p.staff_id = s.staff_id
GROUP BY s.first_name

-- Sub queries
-- Cambiar el idioma de las películas
UPDATE film SET language_id = 2 WHERE film_id >= 100 AND film_id < 200;
UPDATE film SET language_id = 3 WHERE film_id >= 200 AND film_id < 300;
UPDATE film SET language_id = 4 WHERE film_id >= 300 AND film_id < 400;
UPDATE film SET language_id = 5 WHERE film_id >= 400 AND film_id < 500;
UPDATE film SET language_id = 6 WHERE film_id >= 500 AND film_id < 600;

SELECT l.name, COUNT(f.film_id) FROM film f
INNER JOIN language l ON f.language_id = l.language_id
GROUP BY l.name

SELECT title FROM film
WHERE language_id IN (SELECT language_id FROM language WHERE name = 'English' OR name = 'Italian')

-- Peliculas más alquiladas
SELECT * FROM rental
SELECT * FROM inventory
SELECT * FROM film

-- agrupar por título las peliculas más alquiladas

SELECT f.title, COUNT(f.film_id) as veces_alquilada FROM film f
INNER JOIN (SELECT * FROM inventory i
INNER JOIN rental r ON r.inventory_id = i.inventory_id) res ON res.film_id = f.film_id
GROUP BY f.title
	-- ORDER BY veces_alquilada DESC


## CONCESIONARIO

-- Ventas por empleado
SELECT e.name, COUNT(s.id) FROM sale s
INNER JOIN employee e ON e.id = s.id_employee
GROUP BY e.name

-- Contar las compras por cliente
SELECT cu.name, COUNT(s.id) FROM sale s
INNER JOIN customer cu ON cu.id = s.id_customer
GROUP BY cu.name

-- Frabricante más vendido
SELECT m.name, COUNT(s.id) FROM sale s
INNER JOIN vehicle v ON v.id = s.id_vehicle
INNER JOIN manufacturer m ON m.id = v.id_manufacturer
GROUP BY m.name

-- Modelo más vendido
SELECT mo.name, COUNT(s.id) FROM sale s
INNER JOIN vehicle v ON v.id = s.id_vehicle
INNER JOIN manufacturer m ON m.id = v.id_manufacturer
INNER JOIN model mo ON mo.id_manufacturer = m.id
GROUP BY mo.name

-- Extra más vendido
SELECT e.name, COUNT(s.id)AS ventas FROM sale s
INNER JOIN vehicle v ON v.id = s.id_vehicle
INNER JOIN extra_version ev ON ev.id_extra = v.id_extra
INNER JOIN extra e ON e.id = ev.id_extra
GROUP BY e.name

-- Versión más vendida
SELECT ver.name, COUNT(s.id)AS ventas FROM sale s
INNER JOIN vehicle v ON v.id = s.id_vehicle
INNER JOIN extra_version ev ON ev.id_extra = v.id_extra
INNER JOIN version ver ON ver.id = ev.id_extra
GROUP BY ver.name