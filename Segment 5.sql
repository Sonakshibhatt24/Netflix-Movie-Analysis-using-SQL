-- Segment 5: Rating Analysis


-- Investigate the distribution of ratings across different genres.

with cte as ((select genre1 as genre, rating, count(rating) as rating_count
from netflix_data where genre1 is not null group by genre1,rating)
union all
(select genre2 as genre, rating, count(rating) as rating_count
from netflix_data where genre2 is not null group by genre2,rating)
union all
(select genre3 as genre, rating, count(rating) as rating_count
from netflix_data where genre3 is not null group by genre3,rating))
(select genre, rating, sum(rating_count) as rating_count from
cte group by genre,rating order by genre, rating_count desc);

-- This query gives the content count for rating count accross different genres.


-- Analyse the relationship between ratings and content duration.

select rating, type, case when type='movie' then concat(round(average_duration,2),' minutes')
else concat(round(average_duration,2),' seasons') end as average_duration from
(select rating, type, avg(duration) as average_duration from netflix_data
group by rating, type)a order by rating;

-- This query gives the average duration for each rating based on the type of the content.