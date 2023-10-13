--- select
select *
from "Jupiter".customer

select "Gender", "Country"
from "Jupiter".customer

select "Gender" as G
from "Jupiter".customer

---- column calculation
select "Employee_ID", "Salary"*0.1 as Bonus
from "Jupiter".employee_payroll
---- create table
Create table "Jupiter".man as
select "Employee_ID" as EmpM
from "Jupiter".employee_payroll

Create table "Jupiter".mansala as
select "Employee_ID", "Salary"*0.1 as Bonus, "Salary"
from "Jupiter".employee_payroll

---* where for calculated column
select "Employee_ID", "Salary"*0.1 as Bonus
from "Jupiter".employee_payroll
where "Salary"*0.1 < 3000

--------Lab1 (sydney)
----Eliminating Duplicates
select distinct "City"
from "Jupiter".employee_addresses
order by "City" desc;

---(30)
-----Subsetting Data
select "Employee_ID", "Recipients", "Qtr1"
from "Jupiter".employee_donations
where "Qtr1" > 20
order by "Qtr1" desc


----------Joins

select E."Employee_ID", "Gender", "Employee_Name"
from "Jupiter".employee_addresses as EA , "Jupiter".employees as E
where E."Employee_ID" = EA."Employee_ID"

------Lab2-------- 45

-- (floor((TO_DATE('01SEP2023', 'DDMONYYYY') - TO_DATE("Start_Date", 'DDMONYYYY'))/365.25) as YOS)
------Inner joins
select floor((TO_DATE('01SEP2023', 'DDMONYYYY') - TO_DATE("Start_Date", 'DDMONYYYY'))/365.25) as YOS, "Employee_Name"
from "Jupiter".employee_addresses as EA , "Jupiter".employee_information as IA
where EA."Employee_ID" = IA."Employee_ID" and
      floor((TO_DATE('01SEP2023', 'DDMONYYYY') - TO_DATE("Start_Date", 'DDMONYYYY'))/365.25)  > 30
order by "Employee_Name"


----- Creating a Summary Report from Two Tables: (4)
---- extract year : extract(YEAR from TO_DATE("Order_Date", 'DDMONYYYY')) >= 2010

select PD."Product_ID", "Product_Name", SUM("Quantity") as "TotalSold"
from "Jupiter".product_dim as PD, "Jupiter".order_fact as OF
where PD."Product_ID" = OF."Product_ID" and extract(YEAR from TO_DATE("Order_Date", 'DDMONYYYY')) >= 2010
group by PD."Product_ID","Product_Name"
order by "TotalSold" desc, "Product_Name"

---------IN LINE___________
/*List all active Sales Department employees who have annual salaries
significantly lower (less than 95%) than the average salary for everyone
with the same job title.*/


select "Employee_Name","Salary", e."Job_Title"
from (
select AVG("Salary") as avg_dept , "Job_Title"
from "Jupiter".employee_payroll as ep, "Jupiter".employee_organization as eo
where ep."Employee_ID" = eo."Employee_ID"
  and "Department" = 'Sales'
  and "Employee_Term_Date" is null
group by "Job_Title") as job, "Jupiter".salesstaff as e
where e."Job_Title" = job."Job_Title" and CAST(REPLACE(REPLACE("Salary",'$',''),',','')
AS INTEGER) < avg_dept*0.95
and "Emp_Term_Date" is null
order by 1;

----------SUB Query---------------

/*Generate a report that displays Job_Title for job groups with an
average salary greater than the average salary of the company as a
whole.*/

select
"Job_Title",
AVG(CAST(REPLACE(REPLACE("Salary",'$',''),',','') AS INTEGER)) as AvgSalary
from "Jupiter".temp_staff
group by "Job_Title"
having
    AVG(CAST(REPLACE(REPLACE("Salary",'$',''),',','')AS INTEGER)) >
                (select
                     AVG(CAST(REPLACE(REPLACE("Salary",'$',''),',','')AS INTEGER)) as A
    from "Jupiter".temp_staff);

----------LAB3-----------------
-----------Noncorrelated Subquery
/*The jupiter.order_fact table contains information about orders that were placed
by customers. Create a report that lists the retail customers whose average retail
price exceeds the company average retail sales*/

select
    "Customer_Name",
    AVG(CAST(REPLACE(REPLACE("Total_Retail_Price",'$',''),',','')AS DOUBLE PRECISION)) as Mean
from "Jupiter".order_fact as of, "Jupiter".customer as c
where of."Customer_ID" = c."Customer_ID" and "Order_Type" =1
group by "Customer_Name"
having AVG(CAST(REPLACE(REPLACE("Total_Retail_Price",'$',''),',','')AS DOUBLE PRECISION)) > (
    select
        AVG(CAST(REPLACE(REPLACE("Total_Retail_Price",'$',''),',','')AS DOUBLE PRECISION))
    from "Jupiter".order_fact
    where "Order_Type" =1
    )
order by Mean desc

/*Each month, a memo that lists the employees who have birthdates for that month
is posted. Create a report for the month of September and list Employee_ID and
the first and last names for all employees who have birthdates during the month
of September.*/

select e."Employee_ID","Employee_Name"
from "Jupiter".employee_addresses as ea, "Jupiter".employees as e
where ea."Employee_ID" = e."Employee_ID" and extract (Month from TO_DATE("Birth_Date", 'MM/DD/YYYY')) = 09
order by "Employee_ID"

select e."Employee_ID","Employee_Name"
from "Jupiter".employee_addresses as ea, "Jupiter".employees as e
where ea."Employee_ID" = e."Employee_ID" and extract (Month from TO_DATE("Birth_Date", 'MM/DD/YYYY')) = 09
order by "Employee_Name"
----or below

select "Employee_ID", "Employee_Name"
from "Jupiter".employee_addresses
where "Employee_ID" IN (select "Employee_ID"
from "Jupiter".employees
where EXTRACT(MONTH FROM TO_DATE("Birth_Date", 'MM/DD/YYYY')) = 09
order by "Employee_ID")
order by "Employee_Name"

-----------Set operators
select "Name"
from "Jupiter".train_a
Where "Date" is not null
EXCEPT
select "Name"
from "Jupiter".train_b
where "EDate" is not null

------------Lab 4-----------

/* In Postgres, create a report that displays the total salary for female and male
sales representatives and the total number of female and male sales
representatives. The jupiter.salesstaff table contains information about all the
Jupiter Star sales representatives, including Salary and Gender.*/

select "Gender",  count(*) as Total, 'Total Paid Sales Representatives:' ,SUM(CAST(REPLACE(REPLACE("Salary",'$',''),',','')AS INTEGER))
from "Jupiter".salesstaff
where "Job_Title" like '%Rep%'
group by "Gender"

--------using union---------------
select 'Total Paid  Female Sales Representatives:', sum(CAST(REPLACE(REPLACE("Salary",'$',''),',','')AS DOUBLE PRECISION)),
count(*) as Total
from "Jupiter".salesstaff
where "Gender" = 'F' and "Job_Title" like '%Rep%'
UNION
select 'Total Paid  male Sales Representatives:', sum(CAST(REPLACE(REPLACE("Salary",'$',''),',','')AS DOUBLE PRECISION)),
count(*) as Total
from "Jupiter".salesstaff
where "Gender" = 'M' and "Job_Title" like '%Rep%';

/*In Postgres, create a report that displays the Employee_ID of employees who
have phone numbers, but do not appear to have address information. The
jupiter.employee_phones table contains Employee_ID and Phone_Number. If an
employee’s address is on file, the jupiter.employee_addresses table contains the
Employee_ID value and address information. */

select "Employee_ID"
from "Jupiter".employee_phones
Except
select "Employee_ID"
from "Jupiter".employee_addresses
order by "Employee_ID"