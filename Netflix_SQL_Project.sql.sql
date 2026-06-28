

-- ==========================================================
-- NETFLIX SQL PROJECT
-- Author : Atharva Avhad
-- ==========================================================

/* ==========================================================
   SECTION 1 : BASIC QUERIES
   ========================================================== */

-- 1. Total Number of Records
SELECT COUNT(*) AS total_records
FROM netflix_title;

-- 2. Total Movies
SELECT COUNT(*) AS movie_count
FROM netflix_title
WHERE type='Movie';

-- 3. Total TV Shows
SELECT COUNT(*) AS tv_show_count
FROM netflix_title
WHERE type='TV Show';

-- 4. Count Indian Titles
SELECT COUNT(*) AS india_titles
FROM netflix_title
WHERE country='India';


/* ==========================================================
   SECTION 2 : FILTERING
   ========================================================== */

-- 5. TV-MA Rated Content
SELECT *
FROM netflix_title
WHERE rating='TV-MA';

-- 6. Titles Released After 2020
SELECT *
FROM netflix_title
WHERE release_year > 2020;

-- 7. Titles Released Before 2015
SELECT *
FROM netflix_title
WHERE release_year < 2015;

-- 8. All Titles From India
SELECT *
FROM netflix_title
WHERE country='India';

-- 9. Titles Directed by S. S. Rajamouli
SELECT *
FROM netflix_title
WHERE director='S.S. Rajamouli';


/* ==========================================================
   SECTION 3 : AGGREGATE FUNCTIONS
   ========================================================== */

-- 10. Maximum Duration
SELECT MAX(duration) AS max_duration
FROM netflix_title;

-- 11. Minimum Duration
SELECT MIN(duration) AS min_duration
FROM netflix_title;

-- 12. Average Release Year
SELECT AVG(release_year) AS average_release_year
FROM netflix_title;

-- 13. Latest Release Year
SELECT MAX(release_year) AS latest_release
FROM netflix_title;

-- 14. Oldest Release Year
SELECT MIN(release_year) AS oldest_release
FROM netflix_title;


/* ==========================================================
   SECTION 4 : GROUP BY
   ========================================================== */

-- 15. Count Titles by Genre
SELECT listed_in,
COUNT(*) AS total_titles
FROM netflix_title
GROUP BY listed_in;

-- 16. Count Titles by Type
SELECT type,
COUNT(*) AS total_titles
FROM netflix_title
GROUP BY type;

-- 17. Count Titles by Country
SELECT country,
COUNT(*) AS total_titles
FROM netflix_title
GROUP BY country;

-- 18. Count Titles by Rating
SELECT rating,
COUNT(*) AS total_titles
FROM netflix_title
GROUP BY rating;


/* ==========================================================
   SECTION 5 : NULL HANDLING
   ========================================================== */

-- 19. Count Available Directors
SELECT COUNT(*) AS director_available
FROM netflix_title
WHERE director IS NOT NULL;

-- 20. Find NULL Directors
SELECT title
FROM netflix_title
WHERE director IS NULL;

-- 21. Replace NULL Directors
SELECT title,
COALESCE(director,'Unknown') AS director
FROM netflix_title;

-- 22. Replace NULL Country
SELECT title,
COALESCE(country,'Not Available') AS country
FROM netflix_title;


/* ==========================================================
   SECTION 6 : ORDER BY
   ========================================================== */

-- 23. Latest Netflix Title
SELECT *
FROM netflix_title
ORDER BY release_year DESC
LIMIT 1;

-- 24. Oldest Netflix Title
SELECT *
FROM netflix_title
ORDER BY release_year ASC
LIMIT 1;


/* ==========================================================
   SECTION 7 : WINDOW FUNCTIONS
   ========================================================== */

-- 25. Generate Row Numbers
SELECT *,
ROW_NUMBER() OVER() AS row_num
FROM netflix_title;

-- 26. Rank Titles by Release Year
SELECT title,
release_year,
RANK() OVER(ORDER BY release_year DESC) AS ranking
FROM netflix_title;


/* ==========================================================
   SECTION 8 : STRING SEARCH
   ========================================================== */

-- 27. Titles Containing "Love"
SELECT *
FROM netflix_title
WHERE title LIKE '%Love%';

-- 28. Titles Starting With "The"
SELECT *
FROM netflix_title
WHERE title LIKE 'The%';


/* ==========================================================
   SECTION 9 : ADVANCED QUERIES
   ========================================================== */

-- 29. Find Duplicate Titles
SELECT title,
COUNT(*) AS total
FROM netflix_title
GROUP BY title
HAVING COUNT(*) > 1;

-- 30. Latest Movie From Every Country
SELECT *
FROM
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY country ORDER BY release_year DESC) AS rn
FROM netflix_title
WHERE type='Movie'
)t
WHERE rn=1;

