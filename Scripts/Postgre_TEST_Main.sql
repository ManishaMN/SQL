-- 8 airport with most dept flights
-- answer: ATL with 282 departing flights

select origin_airport, count(*) as flight_dep_count
from "Delays".flights
group by origin_airport
order by 2 desc;

-- 9  route with  most cancelled flights
-- answer: DCA-EWR with 2 flights cancelled and LGA-MIA with 2 flights cancelled

select origin_airport, destination_airport , sum(cancelled) as FlightsCancelled
from "Delays".flights
group by origin_airport, destination_airport
order by 3 desc;

-- 10 airline due to carrier
-- answer: Spirit Air lines(NK) 4
select f.airline as airline_code, sum(cancelled) as FlightsCancelled_AirlineCarrierReason, a.airline as airline_name
from "Delays".flights f, "Delays".main_airlines as a
where cancellation_reason = 'A' and f.airline = a.code
group by f.airline, a.airline
order by 2 desc;

--11. DEp delay of airline
-- answer:
select airline as AIRLINE_Code, sum(cast(departure_delay as INTEGER)) as DELAY
from "Delays".flights
where departure_delay <> ''
group by airline
order by 1 asc;
