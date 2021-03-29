# https://leetcode.com/problems/restaurant-growth/

WITH CTE AS (SELECT
        visited_on, 
        SUM(amount) OVER (ORDER BY visited_on range between INTERVAL '6' DAY preceding and current row) as amount,
        dense_rank() OVER (ORDER BY visited_on) as row_rank
    FROM Customer)

SELECT visited_on, min(amount) as amount, ROUND(min(amount)/7, 2) as average_amount
FROM CTE
WHERE row_rank > 6
GROUP BY visited_on
ORDER BY visited_on


# Another
SELECT 
    visited_on,
    MIN(amount) as amount,
    average_amount
FROM (SELECT
    visited_on,
    SUM(AMOUNT) OVER (ORDER BY visited_on range between INTERVAL 6 day preceding and current row) AS amount,
    ROUND((SUM(AMOUNT) OVER (ORDER BY visited_on range between INTERVAL 6 day preceding and current row))/7, 2) AS average_amount,
    DENSE_RANK() OVER (ORDER BY visited_on) AS date_rank
FROM Customer
) c
WHERE date_rank >= 7
GROUP BY 1
ORDER BY 1
