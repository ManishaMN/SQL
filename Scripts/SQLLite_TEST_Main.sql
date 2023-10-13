--1 customers with gmail address
-- answer:8
select count(*)
from Customer
where Email like '%gmail%';

--2 title with letter M,
select  AlbumId, Title
from Album
where Title like 'M%'
order by AlbumId;

--3 track table, avg unit price
select GenreId, AVG(UnitPrice) as Avg_unitprice
from Track
group by GenreId
order by GenreId desc;

--4 billing city
select BillingCity, AVG(Total) as avg_tot_invoice
from Invoice
group by BillingCity
having AVG(Total) >6;

--5. higher than total invoice
select BillingCity, AVG(Total) as avg_tot_invoice
from Invoice
group by BillingCity
having AVG(Total) > ( select AVG(Total) from Invoice );

--6 cities customer / employee
select distinct  City
from Customer
Union
select distinct City
from Employee3;

--7 count of cities customer
--  answer: 55
select count (*) as Count_cities
from (select distinct  City
from Customer
Union
select distinct City
from Employee3)
