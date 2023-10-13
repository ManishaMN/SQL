
--------select
select *
from genres

select genre
from genres

select genre as g
from genres

---create table
create table man as
select 10*dvd_price as price , movie_name
from movies
where price > 60
group by  movie_name
---column calculation

select movie_name, release_year
from movies

select 10*dvd_price as price , movie_name
from movies
where price > 60
group by  movie_name

------joins

select movie_name, genre
from movies as m, genres as g
where m.genre_id = g.id
--------Lab2
----  Inner Joins (Gothika (Widescreen) / Queen Of The Damned)

select name,movie_name
from people as p, movies as m, people_movies as pm
where pm.person_id = p.id and pm.movie_id = m.id
order by name


---- summary report from 2 tables 39

select name,count(movie_name) as moviecount
from people as p, movies as m, people_movies as pm
where pm.person_id = p.id and pm.movie_id = m.id
group by name
order by moviecount desc

----------LAB3
/*
 Find all movies that are NOT one of the following genre categories:
Page | 3
• 'Comedy','Comedy/Drama','Exercise','Fantasy','Foreign','Animation','
Horror','TV Classics','VAR','War'
• Display only the movie name
• Order the report by descending movie nam
 */

select  distinct movie_name
from movies as m, genres as g
where
  m.genre_id = g.id and
    genre NOT IN ('Comedy','Comedy/Drama','Exercise','Fantasy','Foreign','Animation','
Horror','TV Classics','VAR','War')
order by movie_name desc

/*Find the names of the people who own the following movies:
• Movie_ID = '20372','8727','31670'
• Note that in the table people_movies, the column ID refers to the ID
of the table, and person_id refers to the ID of the person. Refer back
to the last slide of Class #3 for a diagram of the tables.
• Order the report by ascending person name */

select name
from people as p, people_movies as pm
where pm.person_id = p.id  and movie_id IN('20372','8727','31670')
order by name

/*Tables: practice.movies,
practice.genres
List all movies that start with ‘Da’ or all genres
that start with ‘B’
Hint: where movie_name like ‘B% */

select movie_name
from movies
where movie_name like 'Da%'
UNION
select genre
from genres
where genre like 'B%'

-------LAb 4--------

select "id"
from "movies"
EXCEPT
select "movie_id"
from people_movies
order by "id"


select count(*)
from (select "id"
from "movies"
EXCEPT
select "movie_id"
from people_movies
order by "id")