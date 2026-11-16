#EJERCICIO 1
#Agrupación múltiple y métricas combinadas.   
#Agrupa las películas por clasificación (rating) y duración de alquiler en días (rental_duration). 
#Muestra cuántas películas hay en cada combinación (total_peliculas), 
#la tarifa de alquiler promedio (tarifa_promedio) y el costo de reemplazo máximo (costo_maximo). 
#Ordena por rating ascendente y por total_peliculas descendente.

USE sakila;
SELECT * FROM film;
SELECT rating, rental_duration,
COUNT(*) AS total_peliculas,
AVG(rental_rate) AS alquiler_promedio, 
SUM(replacement_cost) AS coste_reemplazo_maximo FROM film
GROUP BY rating, rental_duration
ORDER BY rating ASC, total_peliculas DESC;

#EJERCICIO 2
#Segmentación condicional con CASE
#Crea una columna calculada llamada tipo_duracion que clasifique cada película 
#según su duración (length): "Corta" si dura menos de 90 minutos, 
#"Estándar" si dura entre 90 y 130 minutos (ambos inclusive) 
#y "Larga" si supera los 130 minutos. 
#Agrupa por tipo_duracion y obtén la cantidad de películas, 
#el costo de reemplazo promedio (replacement_cost) y la suma total de tarifas de alquiler (rental_rate).
# Ordena de mayor a menor cantidad.

SELECT
    CASE
        WHEN length < 90 THEN "Corta"
        WHEN length >= 90 AND length <= 130 THEN "Estandar"
        ELSE "Larga"
    END AS tipo_duracion,

    COUNT(*) AS Cantidad,
    AVG(replacement_cost) AS reemplazo_promedio,
    SUM(rental_rate) AS suma_total_tarifas
FROM film
GROUP BY tipo_duracion
ORDER BY Cantidad DESC;


#EJERCICIO 3

#Filtro dinámico con subconsulta en WHERE
#Muestra el título (title), la clasificación (rating) y el costo de reemplazo (replacement_cost)
#de todas las películas cuyo costo de reemplazo esté por debajo del costo de reemplazo promedio 
#de todo el catálogo. Ordénalas de menor a mayor costo de reemplazo.

SELECT title, rating, replacement_cost
FROM film
WHERE replacement_cost<(
    SELECT AVG(replacement_cost) FROM film
)
ORDER BY replacement_cost ASC;



#EJERCICIO 4

#Comparación contra un promedio global en SELECT  
#Compara la duración promedio (length) de cada clasificación (rating) 
#contra la duración promedio general de toda la tabla film. 
#Muestra el rating, su duracion_promedio, la duracion_global y 
#la diferencia (duracion_promedio - duracion_global). Ordena de mayor a menor diferencia.
SELECT 
    rating,
    AVG(length) AS duracion_promedio,
    (SELECT AVG(length) FROM film) AS duracion_promedio_global,
    AVG(length) -(SELECT AVG(length) FROM film) AS diferencia_duracion

FROM film
GROUP BY rating
ORDER BY diferencia_duracion DESC;

#EJERCICIO 5

#Muestra limitada de textos con GROUP_CONCAT y SUBSTRING_INDEX  
#Para cada duración de alquiler (rental_duration), cuenta cuántas películas hay (total_peliculas) 
#y muestra en una sola columna (muestra_titulos) únicamente los 4 primeros títulos ordenados alfabéticamente, 
#separados por " | ". Ordena por rental_duration de menor a mayor.

SELECT
    rating,
    SUBSTRING_INDEX(GROUP_CONCAT(
        title SEPARATOR " / "
    ),"/", 7) AS show_titles,
    COUNT(*) AS total_peliculas
FROM film
GROUP BY rating
ORDER BY total_peliculas DESC;

#EJERCICIO 6

#Valores únicos concatenados con DISTINCT
#Agrupa las películas por tarifa de alquiler (rental_rate) y 
#muestra en una columna (ratings_disponibles) las clasificaciones (rating) 
#únicas disponibles para esa tarifa ordenadas alfabéticamente y separadas por " - ", 
#junto con la duración mínima (duracion_minima) y máxima (duracion_maxima) de cada grupo. 
#Ordena el resultado según la cantidad total de películas de cada tarifa de mayor a menor.

SELECT
    rental_rate, 
    GROUP_CONCAT(
        DISTINCT rating
        SEPARATOR " - "
    ) AS all_rating,
    MIN(length) AS duracion_minima,
    MAX(length) AS duracion_maxima
FROM film
GROUP BY rental_rate
ORDER BY COUNT(*) DESC;

#EJERCICIO 7

#Subtotales jerárquicos con WITH ROLLUP e IFNULL 
#Genera un resumen con subtotales agrupando por rating y rental_rate usando WITH ROLLUP. 
#Reemplaza los valores NULL de rating por "TOTAL GENERAL" y los de rental_rate por "Subtotal rating". 
#Muestra el total de películas y el costo de reemplazo promedio redondeado a 2 decimales.

SELECT 
    IFNULL(rating, "TOTAL NATURAL") AS rating,
    IFNULL(rental_rate, "Subtotal rating") AS rental_rate,
    COUNT(*) AS Total,
    ROUND(AVG(replacement_cost), 2) AS costo_promedio
FROM film
GROUP BY rating, rental_rate WITH ROLLUP;


#EJERCICIO 8

#Reto extra: filtrar grupos con HAVING
#Agrupa las películas por extras incluidos (special_features) y 
#calcula el total de películas (total_peliculas) y la tarifa de alquiler promedio (tarifa_promedio). 
#Filtra el resultado para mostrar solo los grupos que tengan más de 60 películas y una tarifa promedio 
#superior a 2.90. Ordena por tarifa_promedio descendente.

SELECT
    special_features,
    COUNT(*) AS total_peliculas,
    ROUND(AVG(rental_rate), 2) AS alquiler_promedio
from film
GROUP BY special_features
HAVING COUNT(*) > 60 AND AVG(rental_rate) > 2.9
ORDER BY alquiler_promedio DESC;
