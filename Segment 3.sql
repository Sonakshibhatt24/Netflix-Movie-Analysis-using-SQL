-- Segment 3: Genre and Category Analysis


-- Determine the unique genres and categories present in the dataset.

(select distinct genre1 as genre from netflix_data where genre1 is not null)
union
(select distinct genre2 as genre from netflix_data where genre2 is not null)
union
(select distinct genre3 as genre from netflix_data where genre3 is not null);

-- This query lists all the unique genres present in the dataset. 
-- There are 44 unique genres available in the dataset.


-- Calculate the percentage of movies and TV shows in each genre.

with cte as ((select genre1 as genre, type, 
sum(case when type='movie' then 1 else 0 end)/count(show_id)*100 as movie_percentage,
sum(case when type='TV show' then 1 else 0 end)/count(show_id)*100 as TV_show_percentage
from netflix_data where genre1 is not null group by genre1,type)
union all
(select genre2 as genre, type, 
sum(case when type='movie' then 1 else 0 end)/count(show_id)*100 as movie_percentage,
sum(case when type='TV show' then 1 else 0 end)/count(show_id)*100 as TV_show_percentage
from netflix_data where genre2 is not null group by genre2,type)
union all
(select genre3 as genre, type, 
sum(case when type='movie' then 1 else 0 end)/count(show_id)*100 as movie_percentage,
sum(case when type='TV show' then 1 else 0 end)/count(show_id)*100 as TV_show_percentage
from netflix_data where genre3 is not null group by genre3,type))
select genre, type, concat(round(avg(movie_percentage),2),'%') as movie_percentage, 
concat(round(avg(TV_show_percentage),2),'%') as TV_show_percentage from cte group by genre,type;

-- This query give the percentage of movies and TV shows in each genre.

-- Identify the most popular genres/categories based on the number of productions.

with cte as ((select genre1 as genre, count(show_id) as content_count
from netflix_data where genre1 is not null group by genre1)
union all
(select genre2 as genre, count(show_id) as content_count
from netflix_data where genre2 is not null group by genre2)
union all
(select genre3 as genre, count(show_id) as content_count
from netflix_data where genre3 is not null group by genre3))
select genre, sum(content_count) as content_count from cte 
group by genre order by content_count desc;

-- The top 5 genres with highest number of content producted are International TV Shows, Dramas, 
-- Comedies, Stand-Up Comedy, International movies and documentaries


-- Calculate the cumulative sum of content duration within each genre.

with cte as ((select genre1 as genre, type, sum(duration) as duration
from netflix_data where genre1 is not null group by genre1,type)
union all
(select genre2 as genre, type, sum(duration) as duration
from netflix_data where genre2 is not null group by genre2,type)
union all
(select genre3 as genre, type, sum(duration) as duration
from netflix_data where genre3 is not null group by genre3,type))
(select genre, type, case when type='Movie' then concat(cumulative_duration,' minutes')
else concat(cumulative_duration,' seasons') end as cumulative_duration from
(select genre, type, sum(duration) as cumulative_duration
from cte group by genre,type) a);

-- This query results in list of all genres and their cumulative content duration.