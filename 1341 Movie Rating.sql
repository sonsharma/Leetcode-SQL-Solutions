# https://leetcode.com/problems/movie-rating/

-- # of movies per user_id -> return highest one | order by user_id
-- for each movie - avg(rating) -> return highest one
--  union 1 and 2

WITH CTE AS (SELECT u.name as results
             FROM Movie_Rating m LEFT JOIN Users u USING(user_id)
             GROUP BY m.user_id
             ORDER BY COUNT(DISTINCT m.movie_id) desc, u.name
             LIMIT 1),
             
    CTE2 AS (SELECT title as results
            FROM Movie_Rating mr JOIN Movies m USING(movie_id)
            WHERE DATE_FORMAT(created_at, '%Y-%m') = '2020-02'
            GROUP BY mr.movie_id
            ORDER BY AVG(rating) desc, m.title asc
            LIMIT 1
            )
            
SELECT results FROM CTE
UNION
SELECT results FROM CTE2
;