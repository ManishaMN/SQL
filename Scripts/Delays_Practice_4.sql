-- Q.8

select origin_airport, count(*) as Flight_count
from "Delays".flights
group by origin_airport
order by 2 desc;

-- ATL airport has the most departing flights of 282

-- Q.9

select origin_airport, destination_airport, count(*) as Number_Of_Cancelled_Flights
from "Delays".flights
where cancelled = 1
group by origin_airport, destination_airport
order by 3 desc;

-- LGA-MIA has the most cancelled flights ( actually 2 routes)

-- Q.10

select ma.code as AIRLINE_CODE, ma.airline as AIRLINE_NAME, count(*) as Number_Of_Cancelled_Flights
from "Delays".main_airlines ma,
     "Delays".flights f
where ma.code = f.airline
  and f.cancellation_reason = 'A'
group by ma.code, ma.airline
order by 3 desc;

-- Spirit Air Lines with 4 cancellations due to Airline/Carrier

-- Q.11

select airline as AIRLINE, sum(cast(departure_delay as INTEGER)) as DELAY
from "Delays".flights
where departure_delay <> ''
group by airline
order by 1 asc;

-- AA has a delay total of 7328

-------------------------------------------
*Which airport has the highest number of departing flights,
  and how many flights depart from that airport?*/

select origin_airport, count(*) as flight_dep_count
from "Delays".flights
group by origin_airport
order by 2 desc
limit 1



/*What is the route (origin to destination) with the highest number of cancelled flights,
  and how many flights were cancelled on that route?
 */
select origin_airport, destination_airport , sum(cancelled) as FlightsCancelled
from "Delays".flights
group by origin_airport, destination_airport
order by sum(cancelled) desc

/*Among the main airlines, which one had the most flight cancellations
  due to Airline/Carrier reasons, and how many flights were cancelled for that airline?
 */

select f.airline as code, sum(cancelled) as FlightsCancelled, a.airline
from "Delays".flights f, "Delays".main_airlines as a
where cancellation_reason = 'A' and f.airline = a.code
group by f.airline, a.airline
order by 2 desc


/*Which airline experienced the highest total departure delay, and
  what is the total departure delay for that airline?
 */

select f.airline as airlineCode, SUM(CAST(NULLIF(departure_delay, '') AS INTEGER)), a.airline
from "Delays".flights f, "Delays".main_airlines a
where f.airline = a.code
group by f.airline, a.airline
order by 2 desc

select airline as AIRLINE, sum(cast(departure_delay as INTEGER)) as DELAY
from "Delays".flights
where departure_delay <> ''
group by airline
order by 1 asc;