SELECT *
FROM flights;

/*Q1*/

SELECT origin AS origin_airport, dest AS destination_airport, MAX(distance) AS farthest_distance
FROM flights;

SELECT *
FROM planes;

/*Q2*/

SELECT manufacturer, model, engines, MAX(seats) AS max_seats_by_engine
FROM planes
GROUP BY engines
ORDER BY engines desc;

/*Q3*/
SELECT COUNT(*)
FROM flights;

/*Q4*/
SELECT carrier, COUNT(*) AS number_of_flights
FROM flights
GROUP BY carrier;

/*Q5*/
SELECT carrier, COUNT(*) AS total_number_flights
FROM flights
GROUP BY carrier
ORDER BY total_number_flights desc;

/*Q6*/

SELECT carrier, COUNT(*) AS total_number_flights
FROM flights
GROUP BY carrier
ORDER BY total_number_flights desc
LIMIT 5

/*Q7*/

SELECT carrier, distance, COUNT(*) AS total_number_flights
FROM flights
WHERE distance >= 1000
GROUP BY carrier
ORDER BY total_number_flights desc
LIMIT 5;

/*Q8 - Create a question that (a) uses data from the flights database, and (b) requires aggregation to answer it, and
write down both the question, and the query that answers the question.

Which 2 of the 3 airports boast the highest average departure delays? */

SELECT 
CASE origin
WHEN 'LGA' THEN 'LaGuardia'
WHEN 'JFK' THEN 'John F Kennedy'
WHEN 'EWR' THEN 'Newark'
END AS airport,
ROUND(AVG(dep_delay), 2) AS average_departure_delay
FROM flights
WHERE dep_delay > 0
GROUP BY airport
ORDER BY average_departure_delay DESC
LIMIT 2;
