-- Segment 6: Co-occurrence Analysis

-- Identify the most common pairs of genres/categories that occur together in content.

with cte as ((select genre1 as genre1, genre2 as genre2, count(show_id) as content_count
from netflix_data where genre1 is not null and genre2 is not null group by genre1, genre2)
union all
(select genre2 as genre1, genre3 as genre2, count(show_id) as content_count
from netflix_data where genre2 is not null and genre3 is not null group by genre2, genre3)
union all
(select genre1 as genre1, genre3 as genre2, count(show_id) as content_count
from netflix_data where genre1 is not null and genre3 is not null group by genre1, genre3))
(select genre1, genre2, sum(content_count) as content_count
from cte group by genre1,genre2 order by content_count desc);

-- The 5 top genre pairs are (Dramas, International movies), (Comedies, International movies),
-- (Dramas, Independent movies), (International TV Shows, TV Dramas), (Comedies, Dramas)


-- Analyse the relationship between genres/categories and content duration.

with cte as ((select genre1 as genre, type, avg(duration) as duration
from netflix_data where genre1 is not null group by genre1,type)
union all
(select genre2 as genre, type, avg(duration) as duration
from netflix_data where genre2 is not null group by genre2,type)
union all
(select genre3 as genre, type, avg(duration) as duration
from netflix_data where genre3 is not null group by genre3,type))
(select genre, type, case when type='Movie' then concat(round(average_duration,2),' minutes')
else concat(round(average_duration,2),' seasons') end as average_duration from
(select genre, type, avg(duration) as average_duration
from cte group by genre,type) a);

-- This query gives the average_duration for content for each genre