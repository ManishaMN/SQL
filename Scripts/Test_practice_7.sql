-- 1.gmail addresses?

select count(*)
from Customer
where Email like '%@gmail%';

-- 8 customers have gmail addresses

-- 2
select AlbumId, Title
from Album
where Title like 'K%'
order by AlbumId desc;

-- 3

select GenreId, avg(UnitPrice) as Avg_Unit_Price
from Track
group by GenreId
order by GenreId desc;

-- 4

select distinct City
from Customer
UNION
select distinct City
from Employee3;

-- 5
select count(*)
from (select distinct City
      from Customer
      UNION
      select distinct City
      from Employee3);

-- 55 cities

-- 6

select BillingCity, avg(Total) as Avg_Billing
from Invoice
group by BillingCity
having avg(Total) > 6;

-- 7

select BillingCity, avg(Total) as Avg_Billing
from Invoice
group by BillingCity
having avg(Total) > (select avg(Total) from Invoice);

----------------------------
--1
select count(*)
from Customer
where Email like '%gmail%'

/*2-List the Album IDs and Titles of albums
  whose titles start with the letter 'K', ordered by Album ID in descending order
 */

select  AlbumId, Title
from Album
where Title like 'K%'
order by AlbumId desc

/*3_For each genre, calculate the average unit price of tracks within that genre.
  List the Genre ID and the average unit price, ordered by Genre ID in descending order.
 */

select GenreId, AVG(UnitPrice)
from Track t
group by GenreId
order by GenreId desc;

/*4_Retrieve a list of distinct cities from both the
  Customer and Employee3 tables, combining them without duplicates.
 */

select distinct  City
from Customer
Union
select distinct City
from Employee3

/*5_How many distinct cities are there among customers and employees when combining both tables?*/
select count(*)
from (select distinct  City
from Customer
Union
select distinct City
from Employee3)

/*6_For each billing city, calculate the average total amount of invoices.
  Display the billing city and average total amount,
  but only include cities where the average total amount exceeds 6.
 */

select BillingCity, AVG(Total) as avg_tot_invoice
from Invoice
group by BillingCity
having AVG(Total) >6

/*7_For each billing city, calculate the average total amount of invoices.
  Display the billing city and average total amount but only include cities
  where the average total amount is greater than the overall average total amount of invoices in the database.
 */
select BillingCity, AVG(Total) as avg_tot_invoice
from Invoice
group by BillingCity
having AVG(Total) > ( select AVG(Total) from Invoice )