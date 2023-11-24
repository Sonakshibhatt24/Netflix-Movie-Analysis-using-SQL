-- Segment 2: Content Analysis


-- Analyse the distribution of content types (movies vs. TV shows) in the dataset.

select type, count(show_id) as content_count from netflix_data
group by type;

-- There are 6121 movies and 2656 TV shows in the dataset.


-- Determine the top 10 countries with the highest number of productions on Netflix.

select country, content_count from (select country, count(show_id) as content_count, 
row_number() over (order by count(show_id) desc) as rn from netflix_data
where country!='Not Given' group by country)a where rn<=10;

-- This query gives the list of top 10 countries which produce highest number of contents.
-- The top 3 countries in this list are United States, India and United Kingdom.

-- Investigate the trend of content additions over the years.

select release_year, count(show_id) as content_count from netflix_data
group by release_year order by content_count desc;

-- The year 2018 has the highest number of productions, i.e., 1141. 
-- In 2017, the production count was 1030. In 2019, the production count was 1027. 
-- In 2020, the production count was 952. Further, 1925, 1947, 1959, 1961, 1966 are the years
-- with one production.


-- Analyse the relationship between content duration and release year.

select release_year, type, case when type='movie' then concat(round(average_duration,2),' minutes')
else concat(round(average_duration,2),' seasons') end as average_duration from
(select release_year, type, avg(duration) as average_duration from netflix_data
group by release_year, type order by type, release_year) a order by release_year;

-- This query gives the average duration of movies and average season count of TV shows for each year.

 
-- Identify the directors with the most content on Netflix.

select director, count(show_id) as content_count from netflix_data
where director!='Not Given' group by director order by content_count desc;

-- The directors with highest number of contents are Rajiv Chilaka, Jan Suter, Alastrair Forthergill,
-- Suhas Kadav and Marcus Raboy. Further, there are 2579 productions with director name not specified.