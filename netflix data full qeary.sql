select * from netflix;

-- Task 1- Count the Number of Movies vs TV Shows


select type ,
count(*) as show_count
from netflix
group by 1;



-- Task 2-  Find the Most Common Rating for Movies and TV Shows

select * from(
select type,rating,count(*),
rank() over(partition by type order by count(*) desc ) as rn
from netflix
GROUP by 1,2) as t
where rn =1;

-- Task 3 List All Movies Released in a Specific Year (e.g., 2020)

select * from netflix
where release_year = '2020'
and type = 'Movie';

-- Task 4 Find the Top 5 Countries with the Most Content on Netflix

select unnest(string_to_array(country,',')) as newCountry ,count(*) 
from netflix
group by 1
order by 2 desc
limit 5 

-- Task 5 Identify the Longest Running Movie

select * from netflix where title in (

select  title, max(cast(split_part(duration,' ',1) as int )) as dur
from netflix
where type = 'Movie'
group by 2

)

-- Task 6  get details of the highest running movie
SELECT *
FROM netflix
WHERE type = 'Movie'
  AND CAST(SPLIT_PART(duration,' ',1) AS INT) = (
      SELECT MAX(CAST(SPLIT_PART(duration,' ',1) AS INT))
      FROM netflix
      WHERE type = 'Movie'
  );

-- Task 7 get the Tv show with longest Season

select max(cast(split_part(duration,' ',1) as int)) as Season
from netflix
where type  = 'TV Show'


-- Task 8 get the details of Tv show with longest Season

select * from netflix
where type = 'TV Show'
and cast(split_part(duration,' ',1) as int) =
					(select max(cast(split_part(duration,' ',1) as int))
					from netflix
					where type = 'TV Show')


-- Task 9 . Find Content Added in the Last 5 Years

select * 
from netflix
where to_date(date_added,'Month DD, YYYY') >= current_date - interval '5 years';


-- Task 10. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

select * from(
select *,
unnest(string_to_array(director, ',')) as directorName
from netflix) t 
where directorName = 'Rajiv Chilaka'

-- Task 11.. List All TV Shows with More Than 5 Seasons

select *
from netflix
where type = 'TV Show'
and cast(split_part(duration,' ',1) as int) >= 5;


-- Task 12. Count the Number of Content Items in Each Genre

select trim(unnest(string_to_array(listed_in, ','))) as genre,
count(*) as total_count
from netflix
group by 1

-- Task 13.Find each year and the average numbers of content release in India on netflix.
--return top 5 

select extract(year from to_date(date_added,'Month DD YYYY') ) as yr,
count(*) as total_count,
round(
count(*)::numeric / (select count(*) from netflix where country = 'India')::numeric *100
,2)
as avgContent_by_year
from netflix 
where country = 'India'
group by 1
order by 3 desc 
limit 4

--Task 14 List All Movies that are Documentaries
select * from(
select trim(unnest(string_to_array(listed_in,','))) as listt, *
from netflix
where type ='Movie')t 
where listt='Documentaries'



select * 
from netflix 
where type = 'Movie'
and listed_in like '%Documentaries%'

-- Task 15 Find All Content Without a Director

select * 
from netflix 
where director is null

-- Task 16 Find How Many Movies Actor 'Salman Khan' Appeared in the Last 20 Years

select count(*) 
from netflix 
where Casts like '%Salman Khan%'
and release_year >= extract(year from current_date) - 20

    /* but thiw wont work evrytime and not the right approach , supoose we have a cast 'Salman Khannnar'
	that will also return with like 
	so better use uunest - string to array*/

select count(*)
from netflix
where type = 'Movie'
and exists (
			select 1
			from unnest(string_to_array(casts,',')) as actor
			where trim(actor) = 'Salman Khan'
		)
-- Task 17 Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

select trim(unnest(string_to_array(casts,','))),
count(*) as total_films_acted
from netflix 
where type = 'Movie'
and country like  '%India%'
group by 1
order by 2 desc
limit 10


-- Task 18 Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

select  count(*)
from netflix
where description Ilike '%Violence%' or description Ilike '%Kill%'

-- Task 19 Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords , return count of each conetent

select category,count(*) as countofMovies
from (

	select 
	case
		when description Ilike '%Violence%' then 'Violence Movie'
		when description Ilike '%Kill%' then 'Murder Movie'
		else 'Others'
		
	end as category
	from netflix
)
group by category

-- Task 20 Find the top 5 directors who directed the most movies and TV shows combined

SELECT trim(unnest(string_to_array(director,','))) as directors,
count(*) as total_direction
from netflix
group by 1
order by 2 desc
limit 5

-- Task 21 Find actors who have appeared in both movies and TV shows.

select trim(unnest(string_to_array(casts,','))) as actors
from netflix 
group by 1 
having count(distinct type) = 2



--Task 22: Find Movies Where the Title Contains More Than 3 Words

SELECT *
FROM netflix
WHERE array_length(string_to_array(title, ' '), 1) > 3;

--Task 23 : Count Number of Titles per Genre and Year (Dramas)

SELECT *
FROM (
    SELECT 
        TRIM(UNNEST(string_to_array(listed_in, ','))) AS genre, 
        release_year,
        COUNT(*) AS total
    FROM netflix
    GROUP BY 1, 2
) t
WHERE genre = 'Dramas';

--Task 24 : Find Titles with Exactly 2 Genres

select * 
from netflix 
where array_length(string_to_array(listed_in,','),1) =2

--Task 25 : Find Movies That Belong to the Genre 'Dramas'

SELECT *
FROM (
    SELECT 
        TRIM(UNNEST(string_to_array(listed_in, ','))) AS genre, 
        *
    FROM netflix
) t
WHERE genre = 'Dramas';


-- Task 26 : Find Movies Released After 2015 with 'Comedy' in Their Genre

SELECT *
FROM (
    SELECT 
        TRIM(UNNEST(string_to_array(listed_in, ','))) AS genre, 
        *
    FROM netflix
) t
WHERE genre = 'Comedies'
and release_year > 2015;

-- Task 27: Find the Number of Genres for Each Movie

SELECT 
    title,
    array_length(string_to_array(listed_in, ','), 1) AS genre_count
FROM netflix;

-- Task 28 Find the average duration of movies by rating.

select rating,
round(
avg(cast(split_part(duration,' ',1) as int)),2) as avgduration
from netflix 
where type = 'Movie'
group by 1

--Task 29 

SELECT 
    title,
    rating,
    CAST(SPLIT_PART(duration, ' ', 1) AS INT) AS total_seasons
FROM netflix
WHERE type = 'TV Show'
ORDER BY total_seasons DESC
LIMIT 1;



select 
round(
max(cast(split_part(duration,' ',1) as int)),2) as avgduration
from netflix 
where type = 'Movie'


-- Task 30 Find the most common genre in each country

with unn as (

select 
trim(gen) as genre,
trim(con) as country
from netflix 
cross join lateral unnest(string_to_array(listed_in,',')) as g(gen)
cross join lateral unnest(string_to_array(country,',')) as c(con)

)
select * from(
	select country,genre,
	count(*) as total_count,
	rank() over(partition by country order by count(*) desc) as rn
	from unn
	group by 1,2
	
)
where rn =1
order by total_count desc

-- Task 31 Find movies added in each month of the year 5 years back from current year

select to_char(to_date(date_added,'Month DD,YYYY'),'Month') as months,
count(*) as total_count
from netflix 
where extract(year from to_date(date_added,'Month DD,YYYY')) = extract(year from current_date - interval '5 years')
group by 1
order by min(to_date(date_added,'Month DD,YYYY'))

-- Task 32 Find actors who appeared in the most number of content with rating 'TV-MA'.

select trim(act) as actor,
count(*) as total
from netflix 
cross join lateral unnest(string_to_array(casts,',')) as c(act)
where rating = 'TV-MA'
group by 1
order by 2 desc
limit 10

-- Task 33 Find directors who directed both movies and TV shows.

select trim(unnest(string_to_array(director,','))) as dir
from netflix n
group by 1
having count(distinct type) =2

-- Task 34 Find the top 5 actors who appeared in the most international TV shows.

with unns as (
select 
trim(act) as actor,
trim(gen) as genre 
from netflix 
cross join lateral unnest(string_to_array(listed_in,',')) as g(gen)
cross join lateral unnest(string_to_array(casts,',')) as c(act)

)
select actor, count(*) as total_movies_acted
from unns 
where genre Ilike 'International TV Shows'
group by 1
order by 2 desc
limit 5

-- Task 35 Find the earliest added content per country

with unn as (
	select trim(con) as new_country,
	to_date(date_added,'Month DD,YYYY') as newDate
	from netflix 
	cross join lateral unnest(string_to_array(country,',')) as c(con)
	where date_added is not null
)

select new_country , newDate 
from(
	select new_country ,newDate,
	row_number() over(partition by new_country order by newDate ) as rn
	from unn
	)t
where rn =1
				

-- Task 36 Find content that has the word 'love' in the title but 'crusading' in the description.

SELECT * 
FROM netflix 
WHERE title ILIKE '%love%' 
AND description Ilike '%crusading%'
  -- AND description ~* '\bcrusading\b';


-- Task 37 Count the number of actors who have appeared in only 1 movie

select trim(unnest(string_to_array(casts,','))) as actors,count(*)
from netflix 
where type ='Movie'
group by 1
having count(*) = 1

--Task 38 Find the average number of seasons for TV shows per rating.

select rating , round(
avg(cast(split_part(duration ,' ',1) as int)),2)  as avg_n_of_seasons
from netflix 
where type = 'TV Show'
group by 1


-- Task 39 List all content whose cast includes more than 10 actors.


select *
from netflix 
where array_length(string_to_array(casts,','),1) > 10

-- Task 40 Find movies released before 2000 but added to Netflix after 2015

select * 
from netflix 
where release_year < 2000
and to_char(to_date(date_added,'Month DD,YYYY'),'YYYY') > '2015'

-- Task 40 Rank genres by the average duration of movies.

with unn as (
	select trim(gen) as genre,
	cast(split_part(duration,' ',1) as int) as minutes
	from netflix,
	 unnest(string_to_array(listed_in,',')) as gen
	 where type = 'Movie'

)
	select genre , round(avg(minutes),2) as avgMnt,
	rank() over( order by avg(minutes) desc) as rn
	from unn
	group by 1

-- Task 41 Find the top 5 months in which Netflix added the most content.

select to_char(to_date(date_added,'Month DD,YYYY'),'Month') as months,
count(*) as total
from netflix 
where date_added is not null
group by 1
order by 2 desc
limit 5


-- Task 42 Find directors with the highest average number of seasons for TV shows they directed.

with unn as (
	select trim(dir) as directr, cast(split_part(duration,' ',1) as int) as season
	from netflix , unnest(string_to_array(director,',')) as dir
	where type ='TV Show'
	
	
)
select directr , round(avg(season),2) as avgSeasons
from unn
group by 1
order by 2 desc

-- Task 43 Categorize movies by duration:  Short (<90 min), Medium (90–150 min), Long (>150 min)

select
case
	when cast(split_part(duration,' ',1) as int) <90 then 'Short'
	when cast(split_part(duration,' ',1) as int) between 90 and 150 then 'Medium'
	else 'Long'
end as Movie_Duration_type , count(*)

from netflix 
where type = 'Movie'
group by Movie_Duration_type

-- Task 44 Find actors who frequently appear together (co-actors). For example, actors who appeared in at least 5 movies together.

with co as (
	select trim(a1.actor) as actor1,
	trim(a2.actor) as actor2
	from netflix
	cross join lateral unnest(string_to_array(casts,',')) as a1(actor)
	cross join lateral unnest(string_to_array(casts,',')) as a2(actor)
	where a1.actor < a2.actor
)

select actor1,actor2 , count(*) as total_movies_together
from co 
group by 1,2
having count(*) > 5 
order by 3 desc

-- Task 45 Calculate year-over-year growth in the number of content items added.

with yrr as (

	select 
	extract(year from to_date(date_added,'Month DD,YYYY')) as yr,
	count(*) as total_content
	from netflix
	where date_added is not null
	group by 1
	
)

select yr,
total_content,
lag(total_content) over(order by yr) as prev_year_contnet,

round(
((total_content - lag(total_content) over(order by yr)) /  lag(total_content) over(order by yr)::numeric) *100,2)
as y_y_growth
from yrr

/*  in PostgreSQL, whenever you divide two integer values and expect a fractional or decimal result,
you should cast at least one of them to numeric (or decimal).
by this, u can preserve -ve value also , otherwise it will giv u 0 as integer devision is 0 */


-- Task 46 Compare each year’s content count with the previous year.

with yearly as (

	select extract(year from to_date(date_added,'Month DD,YYYY')) as year,
	count(*) as total_content
	from netflix 
	where date_added is not null
	group by 1
	
)
select year,total_content,
lag(total_content) over(order by year) as prev_year_content
from yearly

-- Task 47 Compute 3-year moving content total and  average of moving content added.

with yearly as (

	select extract(year from to_date(date_added,'Month DD,YYYY')) as year,
	count(*) as total_content
	from netflix
	where date_added is not null
	group by 1
)

select year,
total_content,
(total_content + lag(total_content,1) over(order by year) + lag(total_content,2) over(order by year)) as total_3Y_moving_count,
((total_content + lag(total_content,1) over(order by year) + lag(total_content,2) over(order by year))/3) as avg_moving_content_3Y
from yearly



-- Task 48 Find growth comparing next year instead of previous year.

with yearly as (

	select extract(year from to_date(date_added,'Month DD,YYYY')) as year,
	count(*) as total_content
	from netflix
	where date_added is not null
	group by 1
)

select year,
total_content,
lead(total_content) over(order by year) as next_year_content,
round(
((lead(total_content) over(order by year) - total_content ) / total_content::numeric) *100,2) as yr_yr_growth
from yearly


-- Task 49 Rank years by content added and compare with previous year.

WITH yrr AS (
    SELECT 
        extract(year from to_date(date_added,'Month DD,YYYY')) AS yr,
        count(*) AS total_content
    FROM netflix
    WHERE date_added IS NOT NULL
    GROUP BY 1
)
SELECT 
    yr,
    total_content,
    lag(total_content) OVER(ORDER BY total_content DESC) AS prev_content_by_rank,
    rank() OVER(ORDER BY total_content DESC) AS rank_year
FROM yrr;


-- Task 50 Previous year content only for movies (ignore TV shows).

with yearly as (

	select extract(year from to_date(date_added,'Month DD,YYYY')) as yr ,
	count(*) as total_content
	from netflix 
	where date_added is not null
	and type='Movie'
	group by 1
	
)
select 
yr, total_content,
lag(total_content) over(order by yr) as prev_yr_contnet,
round(
((total_content - lag(total_content) over(order by yr)) / lag(total_content) over(order by yr)::numeric) *100,2) as yoy_growth
from yearly 


