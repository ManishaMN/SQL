
--36878
select count(*)
from movies

--13271
select count(*)
from movies
where dvd_price >20

/*
378,Francisco Walton
1920,Francisco Javier Chong
*/
select id, name
from people
where name like 'Francisco%'

/* run the query for output  :) */
select name, movie_name
from movies m, people p, people_movies pm
where m.id = pm.movie_id and p.id = pm.person_id

/* run the query for output  :) */
select name, count(movie_name) as movie_count
from movies m, people p, people_movies pm
where m.id = pm.movie_id and p.id = pm.person_id
group by name
order by movie_count desc

/* run the query for output  :) */
select AVG(dvd_price) as Avg_dvdPrice, rating
from movies
group by rating

/* run the query for output  :) */
select AVG(dvd_price) as Avg_dvdPrice, rating
from movies
group by rating
having Avg_dvdPrice >20

/* 982712.7799995932 */
select sum(dvd_price) as GrandTotalCost
from movies

/* run the query for output  :) */
select id, dvd_price, (dvd_price/2) as newDvdPrice
from movies

--6181
select count(id)
from movies m
where id not in ( select movie_id from people_movies)

/* run the query for output  :) */
create table new_studio_count_2
as
select studio_name, count(*) as moviecount
from studios s, movies m
where s.id = m.studio_id
group by studio_name

/* run the query for output  :) */
INSERT INTO people (id, name) VALUES (3000, 'Jack Smith');

/*check for above*/
select *
from people
where id = 3000