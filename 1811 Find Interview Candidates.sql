-- https://leetcode.com/problems/find-interview-candidates/

WITH CTE AS (SELECT gold_medal AS user_id, contest_id FROM contests
            UNION
            SELECT silver_medal AS user_id, contest_id FROM contests
            UNION
            SELECT bronze_medal AS user_id, contest_id FROM contests),

    interview_cand AS (SELECT
            gold_medal user_id
        FROM Contests
        GROUP BY gold_medal
        HAVING COUNT(*) >= 3

        UNION 

        SELECT 
            user_id
        FROM (SELECT
            user_id,
            COUNT(*) OVER (PARTITION BY user_id ORDER BY contest_id RANGE BETWEEN 2 PRECEDING AND CURRENT ROW) AS streak
        FROM CTE) c
        WHERE streak >= 3)

SELECT
    name,
    mail
FROM interview_cand LEFT JOIN Users USING(user_id)
