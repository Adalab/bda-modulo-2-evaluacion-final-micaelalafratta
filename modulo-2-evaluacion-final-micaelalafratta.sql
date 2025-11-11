USE sakila; 

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
SELECT DISTINCT title 
	FROM film;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT title, rating
	FROM film
		WHERE rating = "PG-13"; 

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su
-- descripción.

SELECT title, description
	FROM film
		WHERE description LIKE '%amazing%';

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT title, length
	FROM film
		WHERE length >120;

-- 5. Recupera los nombres de todos los actores.
SELECT first_name, last_name
	FROM actor; 

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT first_name, last_name
	FROM actor
		WHERE last_name LIKE '%Gibson%'; 

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT first_name, last_name, actor_id
	FROM actor
		WHERE actor_id BETWEEN 10 AND 20; -- Between incluye los dos valores.
    
 -- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su
-- clasificación.
SELECT title, rating
	FROM film
		WHERE rating NOT IN("R", "PG-13");

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la
-- clasificación junto con el recuento.
SELECT * 
	FROM film; 

SELECT film_id, rating 
	FROM film; 

SELECT DISTINCT rating
	FROM film;

-- Query final: 
SELECT rating, COUNT(film_id) AS quantity_films
	FROM film
		GROUP BY rating; 

-- 10.  Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
-- nombre y apellido junto con la cantidad de películas alquiladas.
SELECT * 
	FROM customer;

SELECT *
	FROM rental;

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS quantity_films_rented
	FROM customer AS c
		LEFT JOIN rental AS r   -- LEFT JOIN para incluir a todos los compradores y ver también cuáles tienen 0 películas alquiladas (NULL). 
			ON c.customer_id = r.customer_id
	GROUP BY c.customer_id;

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
-- junto con el recuento de alquileres.

-- Q rented films/category  -- category_name   -- COUNT(rentals)
-- GROUP BY

SELECT * 
	FROM rental; 

SELECT * 
	FROM inventory;

SELECT *
	FROM film_category;

SELECT *
	FROM category;

SELECT  r.rental_id, r.inventory_id, i.inventory_id, i.film_id, fc.film_id, fc.category_id, c.category_id, c.name AS category
	FROM rental AS r
		INNER JOIN inventory AS i
			ON r.inventory_id = i.inventory_id
		INNER JOIN film_category AS fc
			ON i.film_id = fc.film_id
		INNER JOIN category AS c
			ON fc.category_id = c.category_id;


SELECT  COUNT(r.rental_id), fc.film_id, c.category_id, c.name AS category
	FROM rental AS r
		INNER JOIN inventory AS i
			ON r.inventory_id = i.inventory_id
		INNER JOIN film_category AS fc
			ON i.film_id = fc.film_id
		INNER JOIN category AS c
			ON fc.category_id = c.category_id
	GROUP BY c.category_id, fc.film_id, c.category_id;

-- Query final: 
SELECT  c.name AS category, COUNT(r.rental_id) AS rented_films_per_category
	FROM rental AS r
		INNER JOIN inventory AS i
			ON r.inventory_id = i.inventory_id
		INNER JOIN film_category AS fc
			ON i.film_id = fc.film_id
		INNER JOIN category AS c
			ON fc.category_id = c.category_id
	GROUP BY c.category_id;


-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
-- muestra la clasificación junto con el promedio de duración.

-- AVG length films / film_rating 
-- film_ rating | AVG length films

SELECT * 
	FROM film;

SELECT length, rating
	FROM film; 

SELECT rating, AVG(length) AS AVG_length
	FROM film
    GROUP BY rating; 
    
-- Query final:
SELECT rating AS film_rating, ROUND(AVG(length), 0) AS AVG_length  -- Redondeo a 0 para que no salgan los decimales. 
	FROM film
    GROUP BY rating; 
    
-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
SELECT *
	FROM film;
    
SELECT *
	FROM film_actor;
    
SELECT *
	FROM actor; 
    
SELECT f.film_id, f.title, fa.film_id, fa.actor_id, a.actor_id, a.first_name, a.last_name
	FROM film AS f
		INNER JOIN film_actor AS fa
			ON f.film_id  = fa.film_id
        INNER JOIN actor AS a
			ON fa.actor_id = a.actor_id
	WHERE f.title = "Indian Love"; 
    
-- Query final: 

SELECT f.title, a.first_name, a.last_name
	FROM film AS f
		INNER JOIN film_actor AS fa
			ON f.film_id  = fa.film_id
        INNER JOIN actor AS a
			ON fa.actor_id = a.actor_id
	WHERE f.title = "Indian Love"; 

-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
SELECT * 
	FROM film; 

SELECT title, description
	FROM film
		WHERE description LIKE '%cat%' OR description LIKE '%dog%';   -- se debe indicar dos veces description, si no, no es una condición completa.

-- 15.  Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.
SELECT * 
	FROM actor;
    
SELECT *
	FROM film_actor; 
    
SELECT a.actor_id, fa.actor_id, fa.film_id
	FROM actor AS a
		LEFT JOIN film_actor AS fa
			ON a.actor_id = fa.actor_id;
        
-- Query final: 
SELECT a.actor_id, fa.film_id
	FROM actor AS a
		LEFT JOIN film_actor AS fa
			ON a.actor_id = fa.actor_id
	WHERE fa.film_id IS NULL;     -- No devuelve resultados. No hay actores o actrices que no aparezcan en ningúna película en la tabla film_actor. 

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
SELECT *
	FROM film; 
    
-- Opción recomendable (más limpia): 
SELECT title, release_year
	FROM film
		WHERE release_year BETWEEN 2005 AND 2010; 

-- Opción alternativa, menos recomendable: 
SELECT title, release_year
	FROM film
		WHERE release_year >= 2005 AND release_year <= 2010;

-- 17.  Encuentra el título de todas las películas que son de la misma categoría que "Family".

SELECT *
	FROM film;
    
SELECT *
	FROM film_category;
    
SELECT *
	FROM category; 
    
SELECT f.title, f.film_id, fc.film_id, fc.category_id, c.category_id, c.name
	FROM film AS f
		INNER JOIN film_category AS fc
			ON f.film_id = fc.film_id
		INNER JOIN category AS c
			ON fc.category_id = c.category_id
	WHERE c.name = "Family"; 
    
-- Query final: 
SELECT f.title AS film_title, c.name AS category
	FROM film AS f
		INNER JOIN film_category AS fc
			ON f.film_id = fc.film_id
		INNER JOIN category AS c
			ON fc.category_id = c.category_id
	WHERE c.name = "Family"; 
    

-- 18.  Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
SELECT * 
	FROM actor;
    
SELECT *
	FROM film_actor; 
    
SELECT a.first_name, a.last_name, a.actor_id, fa.film_id
	FROM actor AS a
		INNER JOIN film_actor AS fa
			ON a.actor_id = fa.actor_id;
 
 
 -- Query final: 
SELECT a.first_name, a.last_name, COUNT(fa.film_id)  AS total_films
	FROM actor AS a
		INNER JOIN film_actor AS fa
			ON a.actor_id = fa.actor_id
	GROUP BY a.actor_id
    HAVING COUNT(fa.film_id) > 10; 
-- La cláusula HAVING solo debe utilizarse para filtrar resultados de funciones de agregación (como COUNT, AVG, SUM) 
-- después de que se ha aplicado GROUP BY.    

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la
-- tabla film.
SELECT title, rating, length
	FROM film
		WHERE rating = "R" AND length > 120;  -- No se incluyen las películas de 120. 

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
-- muestra el nombre de la categoría junto con el promedio de duración.

-- category_name  | AVG>120 length 

SELECT *
	FROM film;
    
SELECT *
	FROM film_category;
    
SELECT *
	FROM category; 
    
SELECT f.length, f.film_id, fc.film_id, fc.category_id, c.category_id, c.name
	FROM film AS f
		INNER JOIN film_category AS fc
			ON f.film_id = fc.film_id
		INNER JOIN category AS c
			ON fc.category_id = c.category_id;
	
SELECT f.length, f.film_id, fc.film_id, fc.category_id, c.category_id, c.name
	FROM film AS f
		INNER JOIN film_category AS fc
			ON f.film_id = fc.film_id
		INNER JOIN category AS c
			ON fc.category_id = c.category_id
		GROUP BY f.length, f.film_id, fc.film_id, fc.category_id, c.category_id, c.name
        HAVING AVG(length)> 120;
            
          
-- Query final: 

SELECT c.name AS category, f.length AS AVG_length
	FROM film AS f
		INNER JOIN film_category AS fc
			ON f.film_id = fc.film_id
		INNER JOIN category AS c
			ON fc.category_id = c.category_id
	GROUP BY c.category_id, c.name, f.length
	HAVING AVG(length)> 120;
            
            

-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
-- con la cantidad de películas en las que han actuado.

-- actors >= 5 films
-- name | Q films. 

SELECT * 
	FROM actor;
    
SELECT *
	FROM film_actor; 
    
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS quantity_films
	FROM actor AS a
		INNER JOIN film_actor AS fa
			ON a.actor_id = fa.actor_id
	GROUP BY a.actor_id  -- Agrupamos por ID por si hay actores/actrices que se llaman igual.
	HAVING COUNT(fa.film_id) >= 5
    ORDER BY quantity_films ASC;  -- ordenamos por Q películas para comprobar el resultado y facilitar su lectura.
	

-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
-- subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
-- películas correspondientes.

-- film_title rented > 5 days
-- subquery rental_id > 5 days

SELECT *
	FROM film; 

SELECT * 
FROM inventory;

SELECT * 
FROM rental; 


SELECT f.film_id, f.title, i.film_id, i.inventory_id, r.inventory_id, r.rental_id, r.rental_date, r.return_date
	FROM film AS f
		INNER JOIN inventory AS i
			ON f.film_id = i.film_id
		INNER JOIN rental AS r
			ON i.inventory_id = r.inventory_id; 
            
-- Subconsulta: 
SELECT r.rental_id, DATEDIFF(r.return_date, r.rental_date) AS rented_days
	FROM rental AS r
		WHERE DATEDIFF(r.return_date, r.rental_date) >5; 
        
            
SELECT f.title AS film_title, r.rental_id
	FROM film AS f
		INNER JOIN inventory AS i
			ON f.film_id = i.film_id
		INNER JOIN rental AS r
			ON i.inventory_id = r.inventory_id
	WHERE r.rental_id IN (SELECT r.rental_id -- Se quita "DATEDIFF(r.return_date, r.rental_date) AS rented_days" porque la subconsulta solo puede devolver una columna con el mismo tipo de dato, en ese caso INT. 
    -- Se mantiene mismo nombre "r.rental_id" para mejor seguimiento.
							FROM rental AS r
								WHERE DATEDIFF(r.return_date, r.rental_date) >5); 
    

-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
-- "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
-- categoría "Horror" y luego exclúyelos de la lista de actores.

-- actor_name NOT IN horror film

SELECT *
	FROM film;
    
SELECT *
	FROM film_category;
    
SELECT *
	FROM category; 

SELECT *
	FROM film_actor; 
    
SELECT * 
	FROM actor;
    
 -- Subconsulta:           
SELECT f.film_id, fc.category_id, c.name, fa.actor_id, a.first_name, a.last_name
	FROM film AS f
		INNER JOIN film_category AS fc   -- Usamos INNER porque queremos solo actores que SÍ actuaron en una Horror Film.
			ON f.film_id = fc.film_id
		INNER JOIN category AS c
			ON fc.category_id = c.category_id
		INNER JOIN film_actor AS fa
			ON  f.film_id = fa.film_id
		INNER JOIN actor AS a
			ON fa.actor_id = a.actor_id
	WHERE c.name = "Horror" ;

-- Query final: 
SELECT a.first_name, a.last_name  
	FROM actor AS a
		WHERE a.actor_id NOT IN -- NOT IN: actores que no actuaron
								(SELECT fa.actor_id    
									FROM film AS f
										INNER JOIN film_category AS fc
											ON f.film_id = fc.film_id
										INNER JOIN category AS c
											ON fc.category_id = c.category_id
										INNER JOIN film_actor AS fa
											ON  f.film_id = fa.film_id
										INNER JOIN actor AS a
											ON fa.actor_id = a.actor_id
									WHERE c.name = "Horror" )
		ORDER BY a.last_name;
        
-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en
-- la tabla film.
-- title | comedy | length > 180

SELECT *
	FROM film;
    
SELECT *
	FROM film_category;
    
SELECT *
	FROM category; 
    
  
SELECT f.film_id, f.title, f.length, fc.film_id, fc.category_id, c.category_id, c.name
	FROM film AS f
		INNER JOIN film_category AS fc  
			ON f.film_id = fc.film_id
		INNER JOIN category AS c
			ON fc.category_id = c.category_id;
            

SELECT f.film_id, f.title, f.length,fc.category_id, c.name AS category_name
	FROM film AS f
		INNER JOIN film_category AS fc  
			ON f.film_id = fc.film_id
		INNER JOIN category AS c
			ON fc.category_id = c.category_id
	WHERE category_name = "Comedy" AND f.length > 180;
    
-- Query final: 
SELECT f.title, f.length, c.name AS category_name
	FROM film AS f
		INNER JOIN film_category AS fc  
			ON f.film_id = fc.film_id
		INNER JOIN category AS c
			ON fc.category_id = c.category_id
	WHERE c.name = "Comedy" AND f.length > 180;   -- No es necesario agrupar. Uso de WHERE para filtrar por filas individuales.


-- BONUS: 25.Encuentra todos los actores que han actuado juntos en al menos una película. 
-- La consulta debe mostrar el nombre y apellido de los actores 
-- y el número de películas en las que han actuado juntos.
