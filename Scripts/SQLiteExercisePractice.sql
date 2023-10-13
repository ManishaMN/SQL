----- Lab1--------

---Counting Rows: (16)

select count(*)
from education_levels

----Grouping By (951)
select country_id, count(*)
from records
group by country_id