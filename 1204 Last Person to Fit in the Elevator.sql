# https://leetcode.com/problems/last-person-to-fit-in-the-elevator/

WITH CTE AS (SELECT person_name, turn,
            SUM(weight) OVER (ORDER BY turn) as cum_sum
            FROM Queue)
            
SELECT
    person_name
FROM CTE
WHERE cum_sum <= 1000
ORDER BY turn desc
LIMIT 1