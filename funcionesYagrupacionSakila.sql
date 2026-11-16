USE sakila;
SELECT * FROM film;

#Conteo para obtener todos los valores en filas.
SELECT COUNT(*) AS total_peliculas FROM film;

#Contamos de todo el listado aquellas peliculas que el costo de reemplazo sea mayor a 20.
SELECT COUNT(*) as peliculas_caras FROM film WHERE replacement_cost > 20;

#Nos quedamos sólo con un único valor de cada uno de los que hay sin duplicar
SELECT COUNT(DISTINCT rating) AS tipo_rating FROM film;

#Hacemos sumatoria de la columna de "replacement_cost"
SELECT SUM(replacement_cost) AS costo_reemplazo_total FROM film; 
#Hacemos sumatoria de la columna de "rental_duration" donde el "rating" sea igual a PG.
SELECT SUM(rental_duration) AS duracion_renta FROM film WHERE rating = "PG";

#Hacemos un promedio de la longitud(duración) de las películas que tengan un rating de NC-17
SELECT AVG(length) AS duracion_promedio_NC17 FROM film WHERE rating = "NC-17";

# Agrupamos cada valor de la columna "rating" y hacemos un promedio de "rental_rate" mostrando la columna rating tmb en la salida.
SELECT rating, AVG(rental_rate) AS tarifa_promedio FROM film GROUP BY rating;

#Buscamos la pelicula que más y menos dure.
SELECT MIN(length) AS pelicula_menor_duracion, MAX(length) AS pelicula_maxima_duracion FROM film;

#Buscamos la pelicula con más y menos costo de reposición después de agrupar por códigos unicos en "rating"
SELECT rating, MIN(replacement_cost) AS menor_valor_sust, MAX(replacement_cost) AS mayor_valor_sust FROM film GROUP BY rating;

#Contamos el total de peliculas agrupadas por cada año.
SELECT release_year, COUNT(*) AS total FROM film GROUP BY release_year;

#Agrupamos por caracteristicas especiales en función del promedio de duración.
SELECT special_features, AVG(length) AS duracion_promedio from film GROUP BY special_features;

#Agrupamos segun el "rating" en toda la lista de film, y obtenemos sólo aquellos que tenga un valor superior a 150.
SELECT rating, COUNT(*) AS total FROM film GROUP BY rating HAVING COUNT(*) > 150;

#Agrupamos por "special_features" de la lista film, buscamos el promedio de la duracion, y mostramos sólo aquellas que duren más de 100 min.
SELECT special_features, AVG(length) AS duracion_promedio FROM film GROUP BY special_features HAVING AVG(length) > 120;

