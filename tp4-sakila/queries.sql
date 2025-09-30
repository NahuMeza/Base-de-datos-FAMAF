USE sakila;

-- Punto 1
DROP TABLE IF EXISTS directors;

CREATE TABLE directors(
    director_id int NOT NULL AUTO_INCREMENT,
    first_name char(20) NOT NULL DEFAULT '',
    last_name char(20) NOT NULL DEFAULT '',
    movies_amount int NOT NULL DEFAULT 0,
    PRIMARY KEY (director_id)
);

-- Punto 2

INSERT INTO directors(first_name, last_name, movies_amount)
SELECT actor.first_name, actor.last_name, count(film_actor.actor_id) as movies_amount
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY film_actor.actor_id
ORDER BY movies_amount DESC
LIMIT 5;

-- ESTA ES LA TECA (Menos eficiente)

INSERT INTO directors (first_name, last_name, movies_amount)
SELECT a.first_name,
       a.last_name,
       (SELECT COUNT(*) FROM film_actor fa WHERE fa.actor_id = a.actor_id) AS movies_amount
FROM actor a
ORDER BY movies_amount DESC
LIMIT 5;

-- Punto 3

ALTER TABLE customer
ADD COLUMN premium_customer enum('T', 'F') NOT NULL DEFAULT 'F';

-- Punto 4

WITH best_customers(customer_id, money_spent) AS (
    SELECT payment.customer_id, sum(payment.amount) AS money_spent
    FROM payment
    GROUP BY payment.customer_id
    ORDER BY money_spent DESC
    LIMIT 10
)
UPDATE customer
SET premium_customer = 'T'
WHERE customer.customer_id IN (SELECT customer_id FROM best_customers);

