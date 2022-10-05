-- Explorar tablas

SELECT * FROM actor;
SELECT * FROM actor WHERE first_name = 'NICK';

SELECT * FROM address;

SELECT * FROM film;

SELECT * FROM address WHERE district = 'California';

SELECT * FROM address WHERE district = 'California' AND postal_code = '8862' OR postal_code = '75090';

SELECT * FROM category WHERE name = 'Action';

SELECT * FROM city WHERE city = 'A Corua (La Corua)';

SELECT * FROM city WHERE city LIKE 'A%'; 	-- Filtra las ciudades que empiezan por A

SELECT * FROM customer WHERE activebool = TRUE;

SELECT * FROM film_actor LIMIT 200;	-- LIMIT hace que no nos muestre mayor cantidad para que no colapse.

SELECT * FROM film_actor WHERE actor_id = 1;

SELECT * FROM film WHERE film_id = 23;
SELECT * FROM film WHERE film_id = 23 OR film_id = 23 OR film_id = 106 OR film_id = 140 OR film_id = 166;

SELECT * FROM film WHERE description LIKE 'A Epic Drama of %'

SELECT * FROM film WHERE description LIKE '% drama %';

SELECT * FROM actor;
INSERT INTO actor (first_name, last_name) VALUES ('Alan', 'Parsons');

INSERT INTO address (address, district, city_id, postal_code, phone) VALUES ('Calle Estrecha', 'Montilla', '405', '47603', '01234567890123456');

INSERT INTO customer (store_id, first_name, last_name, email, address_id, activebool, create_date)
VALUES ('1', 'NombreCliente 1', 'ApellidoCliente 1', 'cliente1@pagila.com', '606', TRUE, '2022-08-08');
SELECT * FROM customer;


