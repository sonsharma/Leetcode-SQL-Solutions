-- https://leetcode.com/problems/the-first-day-of-the-maximum-recorded-degree-in-each-city/

SELECT
    city_id,
    day,
    degree
FROM (SELECT
    *,
    DENSE_RANK() OVER(PARTITION BY city_id ORDER BY degree desc, day) rnk
FROM Weather) c
WHERE rnk = 1
