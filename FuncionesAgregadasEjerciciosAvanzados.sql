USE sakila;
SELECT rating, special_features, #Selecciona columna rating y special_features
COUNT(*) AS total_peliculas, #Cuenta cuantas peliculas hay de cada grupo
AVG(length) AS duracion_promedio, #Calcula el promedio de duración por cada grupo
SUM(replacement_cost) AS costo_total #Suma costos de reemplazo de cada grupo
FROM film
GROUP BY rating, special_features #Agrupa por columnas simultaneamente
ORDER BY rating, total_peliculas DESC; # Ordena por rating y el total_peliculas en orden descendente.

#EJERCICIO 2
SELECT
    CASE #Inicia la expresion condicional
        WHEN replacement_cost < 15 THEN "Bajo"
        WHEN replacement_cost BETWEEN 16 AND 20 THEN "Medio"
        ELSE "Alto"
    END AS segmento_costo, #Crea una nueva columna con categorias de costo

    COUNT(*) AS cantidad, #Cuenta cuantas peliculas hay por cada segmento de costo
    AVG(rental_rate) AS tarifa_promedio, #nos da el promedio de tarifas de costo
    AVG(length) AS duracion_promedio #nos da la duracion promedio
FROM film
GROUP BY segmento_costo #nos agrupa por segmento de costo
ORDER BY cantidad DESC; #lo ordena por la cantidad de manera descendente (mas arriba y menos abajo)

#EJERCICIO 3 -> Identifica peliculas que superan la duracion promedio del catalogo de peliculas

SELECT title, length
FROM film
WHERE length >(
    SELECT AVG(length) FROM film
)
ORDER BY length DESC;

#EJERCICIO 4 -> Compara el precio promedio de alquiler de cada categoria contra el promedio general

SELECT
    rating,
    AVG(rental_rate) AS tarifa_promedio,
    (SELECT AVG(rental_rate) FROM film) AS tarifa_global, #Primera subconsulta obtiene el promedio general para comparacion
    AVG (rental_rate) -(SELECT AVG(rental_rate) FROM film) AS diferencia # Segunda subconsulta obtiene cuanto se desvía cada rating del promedio

FROM film
GROUP BY rating
ORDER BY diferencia DESC;

#EJERCICIO 5 -> Listado de títulos por rating
    #GROUP_CONCAT une todos los titulos mediante "|"
    #SUBSTRING_INDEX corta la cadena al número 5 en este caso. Selecciona los 5 primeros títulos que encuentra.
SELECT
    rating,
    SUBSTRING_INDEX(GROUP_CONCAT(
      title SEPARATOR " | "
    ), '|', 5)AS muestra_titulos,
    COUNT(*) total_peliculas
FROM film
GROUP BY rating
ORDER BY total_peliculas DESC;

#EJERCICIO 6 -> DISTINCT, crear un listado compacto que muestra los rating disponibles para cada tipo de special_features

SELECT
    special_features,
    GROUP_CONCAT(
        DISTINCT rating
        SEPARATOR " / "
    ) AS rating_disonibles,
    AVG(replacement_cost) AS costo_promedio
FROM film
GROUP BY special_features
ORDER BY COUNT(*) DESC;

#EJERCICIO 7 -> WITH ROLLUP - subtotales
#Subtotal por rating y año

SELECT
    IFNULL(rating, "TOTAL") AS rating, # reemplaza los nulos por total
    IFNULL(release_year, "SUBTOTAL") AS año, # si es nulo reemplaza por subtotal
    COUNT(*) AS Total, 
    AVG(length) AS duracion_promedio
FROM film
GROUP BY rating, release_year WITH ROLLUP;


