# Netflix Movies and TV Shows Data Analysis using SQL

![](https://github.com/najirh/netflix_sql_project/blob/main/logo.png)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```


## Solved 50+ Business Problems and Solutions  

Those Problems are:  

- Q1. Count the Number of Movies vs TV Shows  
- Q2. Find the Most Common Rating for Movies and TV Shows  
- Q3. List All Movies Released in a Specific Year (e.g., 2020)  
- Q4. Find the Top 5 Countries with the Most Content on Netflix  
- Q5. Identify the Longest Running Movie  
- Q6. Get details of the highest running movie  
- Q7. Get the TV show with longest Season  
- Q8. Get the details of TV show with longest Season  
- Q9. Find Content Added in the Last 5 Years  
- Q10. Find All Movies/TV Shows by Director 'Rajiv Chilaka'  
- Q11. List All TV Shows with More Than 5 Seasons  
- Q12. Count the Number of Content Items in Each Genre  
- Q13. Find each year and the average numbers of content release in India on Netflix. Return top 5  
- Q14. List All Movies that are Documentaries  
- Q15. Find All Content Without a Director  
- Q16. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 20 Years  
- Q17. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India  
- Q18. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords  
- Q19. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords, return count of each content  
- Q20. Find the top 5 directors who directed the most movies and TV shows combined  
- Q21. Find actors who have appeared in both movies and TV shows  
- Q22. Find Movies Where the Title Contains More Than 3 Words  
- Q23. Count Number of Titles per Genre and Year (Dramas)  
- Q24. Find Titles with Exactly 2 Genres  
- Q25. Find Movies That Belong to the Genre 'Dramas'  
- Q26. Find Movies Released After 2015 with 'Comedy' in Their Genre  
- Q27. Find the Number of Genres for Each Movie  
- Q28. Find the average duration of movies by rating  
- Q29. Find the TV show with the highest number of seasons  
- Q30. Find the most common genre in each country  
- Q31. Find movies added in each month of the year 5 years back from current year  
- Q32. Find actors who appeared in the most number of content with rating 'TV-MA'  
- Q33. Find directors who directed both movies and TV shows  
- Q34. Find the top 5 actors who appeared in the most international TV shows  
- Q35. Find the earliest added content per country  
- Q36. Find content that has the word 'love' in the title but 'crusading' in the description  
- Q37. Count the number of actors who have appeared in only 1 movie  
- Q38. Find the average number of seasons for TV shows per rating  
- Q39. List all content whose cast includes more than 10 actors  
- Q40. Find movies released before 2000 but added to Netflix after 2015  
- Q41. Rank genres by the average duration of movies  
- Q42. Find the top 5 months in which Netflix added the most content  
- Q43. Find directors with the highest average number of seasons for TV shows they directed  
- Q44. Categorize movies by duration: Short (<90 min), Medium (90–150 min), Long (>150 min)  
- Q45. Find actors who frequently appear together (co-actors). For example, actors who appeared in at least 5 movies together  
- Q46. Calculate year-over-year growth in the number of content items added  
- Q47. Compare each year’s content count with the previous year  
- Q48. Compute 3-year moving content total and average of moving content added  
- Q49. Find growth comparing next year instead of previous year  
- Q50. Rank years by content added and compare with previous year  
- Q51. Previous year content only for movies (ignore TV shows)

 
 ## What I Learned  

During this project, I gained hands-on experience with a wide range of **PostgreSQL functions and concepts** while solving real business problems. Some of the key learnings include:  

- **Window Functions**:  
  - `LAG()` and `LEAD()` for year-over-year and next-year comparisons  
  - `RANK()` for ranking genres, directors, etc.  

- **String & Array Functions**:  
  - `split_part()` to extract parts of strings (e.g., duration values)  
  - `string_to_array()` to convert comma-separated values into arrays  
  - `unnest()` with `cross join lateral` to normalize multiple values (e.g., multiple actors, directors, countries)  
  - `array_length()` to count the number of items in an array  

- **Type Casting & Conversion**:  
  - `CAST()` and `::numeric` to handle integer division correctly  
  - `to_date()` and `to_char()` for handling `date_added` strings  

- **Joins and Cross Joins**:  
  - `cross join lateral` to expand arrays into rows for deeper analysis  

- **Advanced Filtering**:  
  - Regular expressions (`~*`, `\bword\b`) for word boundary matches  
  - `ILIKE` for case-insensitive pattern matching  

These techniques not only helped answer business questions but also deepened my understanding of PostgreSQL’s advanced capabilities.  






## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Common Ratings:** Insights into the most common ratings provide an understanding of the content's target audience.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.
- **Content Categorization:** Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.




Thank you for your support, and I look forward to connecting with you!
