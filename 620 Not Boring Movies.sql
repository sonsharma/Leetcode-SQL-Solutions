# https://leetcode.com/problems/not-boring-movies/

SELECT
    *
FROM
    cinema
WHERE id%2 = 1 and description != 'boring'
order by rating desc