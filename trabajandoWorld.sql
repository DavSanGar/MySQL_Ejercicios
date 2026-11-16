USE world;
SELECT Name, Continent FROM country;
SELECT Name, Population FROM country where Continent = "Europe";
SELECT Name FROM city ORDER BY Name;

SELECT Name FROM country LIMIT 5;
SELECT Name FROM country LIMIT 15;

SELECT Name, Population FROM country WHERE Continent = 'Asia' AND Population > 100000;

SELECT Name, Population FROM city ORDER BY CountryCode ASC, Population DESC;

SELECT Name, IndepYear FROM country WHERE IndepYear BETWEEN 1900 and 2000;

SELECT Name AS "Nombre del pais", (Population/1000000) AS "Poblacion por millon" FROM country;

SELECT Name, (GNP/Population) AS "GNP PER CAPITA" FROM Country WHERE Population > 0;

SELECT Name FROM city WHERE Name LIKE "New%";

SELECT Name FROM country WHERE IndepYear IS NULL;

SELECT Name FROM city WHERE CountryCode IN (SELECT Code FROM country WHERE Continent = "Europe");