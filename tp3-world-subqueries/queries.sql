# Listar el nombre de la ciudad y el nombre del país de todas las ciudades
# que pertenezcan a países con una población menor a 10000 habitantes.

SELECT city.Name, country.Name FROM city INNER JOIN country ON CountryCode = Code
                                                                   WHERE country.Population < 10000;

SELECT city.Name, c.Name
FROM city
JOIN (
    SELECT Code, Name
    FROM country
    WHERE Population < 10000
) AS c
ON city.CountryCode = c.Code;

# Preguntar si hace falta el . o es solo buena practica
# Preguntar como es la mejor forma de acomodarlo

# Listar todas aquellas ciudades cuya población sea mayor que la población promedio entre todas las ciudades.

SELECT city.Name FROM city WHERE Population > ALL (SELECT avg(city.Population) FROM city);

# Listar todas aquellas ciudades no asiáticas cuya población sea igual o mayor a la población total de algún país de Asia.
WITH asia_countries AS
    (SELECT country.Code, country.Population FROM country WHERE Continent = 'Asia')
SELECT city.Name FROM city WHERE CountryCode NOT IN (SELECT Code FROM asia_countries)
                             AND Population >= SOME (SELECT Code FROM asia_countries);

# Porque nos conviene usar subqueries en vez de INNER JOIN