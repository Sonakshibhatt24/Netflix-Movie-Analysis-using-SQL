-- Segment 1: Database - Tables, Columns, Relationships


-- Identify the tables in the dataset and their respective columns.

desc netflix_data;

-- There is only one table in the dataset, it is netflix_data. The columns are show_id, type,
-- title, director, country, date_added, release_year, rating, duration, and listed_in.
-- The column listed_in is further splitted into 3 columns genre1, genre2, genre3.


-- Determine the number of rows in each table within the schema.

select count(*) as number_of_rows from netflix_data;

-- There are 8777 rows in the netflix_data table.


-- Identify and handle any missing values in the dataset.

select sum(case when show_id is null then 1 else 0 end) as show_id_nulls,
sum(case when type is null then 1 else 0 end) as type_nulls,
sum(case when title is null then 1 else 0 end) as title_nulls,
sum(case when director is null then 1 else 0 end) as director_nulls,
sum(case when country is null then 1 else 0 end) as country_nulls,
sum(case when date_added is null then 1 else 0 end) as date_added_nulls,
sum(case when release_year is null then 1 else 0 end) as release_year_nulls,
sum(case when rating is null then 1 else 0 end) as rating_nulls,
sum(case when duration is null then 1 else 0 end) as duration_nulls,
sum(case when listed_in is null then 1 else 0 end) as listed_in_nulls
from netflix_data;

-- No column in the netflix_data table has null value.