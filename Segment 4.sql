-- Segment 4: Release Date Analysis


-- Determine the distribution of content releases by month and year.

select release_year, month(date_added) as month, count(show_id) as content_count from netflix_data
group by release_year, month order by release_year, month;

-- This query gives the count of content for all the months of different years.


-- Analyse the seasonal patterns in content releases.

select month(date_added) as month, count(show_id) as content_count from netflix_data
group by month order by content_count desc;

-- This query gives the count produced in all the months. 
-- January produced the most number of content, i.e., 2505.
-- Apart from this, each month produces content in the range of 400-700.


-- Identify the months and years with the highest number of releases.

with cte as (select month(date_added) as month, count(show_id) as content_count,
row_number() over (order by count(show_id) desc) as rn1 from netflix_data
group by month),
cte2 as (select release_year as year, count(show_id) as content_count,
row_number() over (order by count(show_id) desc) as rn2 from netflix_data
group by year)
(select month, year from cte join cte2 where rn1=1 and rn2=1);

-- In the year 2018, most number of content was produced. 
-- Further, specifically in January, most number of content was produced.