-- https://leetcode.com/problems/arrange-table-by-gender/

WITH CTE AS (SELECT *,
    CASE WHEN gender = "female" THEN 1
        WHEN gender = "other" THEN 2
        ELSE 3 END gender_id,
    DENSE_RANK() OVER (PARTITION BY gender ORDER BY user_id) user_id_rnk
FROM genders)

SELECT user_id, gender
FROM CTE
ORDER BY user_id_rnk, gender_id