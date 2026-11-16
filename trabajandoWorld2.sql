USE world;

ALTER TABLE world.country MODIFY Continent VARCHAR(50);
SET SQL_SAFE_UPDATES = 0;
UPDATE world.country SET Continent = "America" WHERE Continent = "North America";
UPDATE world.country SET Continent = "America" WHERE Continent = "South America";
SET SQL_SAFE_UPDATES = 1;

SELECT Name AS Pais, (SurfaceArea/43000000) AS "% del territorio Americano" FROM country WHERE Continent = "America";