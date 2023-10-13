/*Write an SQL query to retrieve the names of all airlines from the MAIN_AIRLINES
  table that have the word "Inc" in their name, and provide an alias 'AirlineName' for the result.
 */

select airline as Airlinename
from "Delays".main_airlines
where airline like '%Inc%'

/* List the names of airports from the MAIN_AIRPORTS table in ascending order of their city names. */
select airport, city
from "Delays".main_airports
order by city

/*Calculate the total distance traveled by all flights in the FLIGHTS table.*/
select sum(distance) as Total_distance
from "Delays".flights

/*Find the airlines that had an average departure delay of more than 5 minutes for flights in the
  month of July (month = 7)
  Use the GROUP BY and HAVING clauses.
 */

select a.airline, AVG(CAST(NULLIF(departure_delay, '') AS INTEGER)) as Avgdepatdelay
from "Delays".flights as f, "Delays".main_airlines as a
where month =7
group by a.airline
having AVG(CAST(NULLIF(departure_delay, '') AS INTEGER)) > 5


/*Retrieve a list of unique airline codes from the FLIGHTS table.*/
select distinct airline
from "Delays".flights

/* Joins (Inner, Outer, Cartesian):
Write an SQL query to join the FLIGHTS table with the MAIN_AIRLINES
   table using the 'airline' column as the common key. Include all flights,
   even if there is no corresponding airline data (use a LEFT JOIN).*/

select *
from "Delays".flights f
    left join "Delays".main_airlines d
        on f.airline =d.airline

/*Create an alias 'F' for the FLIGHTS table and retrieve the
  flight numbers and departure times for flights departing from 'JFK' airport.
 */

select flight_number, departure_time
from "Delays".flights as F
where origin_airport ='JFK'

/*Use the COUNT() function to find the total number of flights that were canceled in May.*/
select count(*)
from "Delays".flights
where cancelled = 1 and month = 5

/*Calculate the average arrival delay for all flights
  in the FLIGHTS table and provide an alias 'AvgArrivalDelay' for the result.
 */

select AVG(CAST(NULLIF(arrival_delay, '') AS INTEGER)) as AvgArrivalDelay
from "Delays".flights

/*find the airline code and airline
  name for the airline with the most delayed flights (use the FLIGHTS table).
 */
select f.airline , SUM(CAST(NULLIF(departure_delay, '') AS INTEGER)) as totaldep , a.airline
from "Delays".flights f , "Delays".main_airlines as a
where f.airline = a.code
group by f.airline, a.airline
order by 2 desc
limit 1
--- another response for above with subquery
SELECT airline_code, airline, total_dep_delay
FROM
    (SELECT f.airline AS airline_code,SUM(CAST(NULLIF(departure_delay, '') AS INTEGER)) AS total_dep_delay
        FROM "Delays".flights AS f
        GROUP BY f.airline
        ORDER BY total_dep_delay DESC
        LIMIT 1
    ) AS subquery, "Delays".main_airlines AS airlines
where subquery.airline_code = airlines.code;


/*find the number of flights departing from
  each airport in June. Include the airport code and the count of flights.
 */

select origin_airport, count(*) as flightcount , airport
from "Delays".flights f , "Delays".main_airports a
where month = 07 and f.origin_airport = a.acode
group by origin_airport, a.airport

/*Combine the results of two queries to retrieve a list of airport names
  from the MAIN_AIRPORTS table that start with 'A' and a list of airport names that start with 'B',
  and display them as a single result set.
 */
select airport
from "Delays".main_airports
where airport like 'A%'
union
select airport
from "Delays".main_airports
where airport like 'B%'

/* Write an SQL query to retrieve the flight numbers from the FLIGHTS table along with the constant text
   'Flight Number:' preceding each flight number.
 */

select 'Flight NUmber:' ,flight_number
from "Delays".flights
limit 10