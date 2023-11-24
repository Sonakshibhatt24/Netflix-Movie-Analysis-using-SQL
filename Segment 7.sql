-- Segment 7: International Expansion Analysis

-- Identify the countries where Netflix has expanded its content offerings.

select country, release_year as releasing_year
from (select country, release_year, 
row_number() over (partition by country order by release_year) as rn
from netflix_data where country!= 'Not Given') a where rn=1;

-- This query gives a list of all countries along with the year in which netflix
-- had its first content released.


-- Analyse the distribution of content types in different countries.

select country, count(show_id) as content_count from netflix_data 
where country!= 'Not Given' group by country order by content_count desc;

-- This query gives the content count for each country. United States has the highest 
-- number of content produced, i.e., 3239, followed by India where the content produced is 1056.
-- It is followed by United Kingdom, Pakistan, Canada.


-- Investigate the relationship between content duration and country of production.

select country, type, case when type='Movie' then concat(round(avg_duration,2),' minutes')
else concat(round(avg_duration,2),' seasons') end as average_duration from
(select country, type, avg(duration) as avg_duration
from netflix_data where country!='Not Given'
group by country, type) a order by country;

-- This query gives the average duration of content for each country and the content type.