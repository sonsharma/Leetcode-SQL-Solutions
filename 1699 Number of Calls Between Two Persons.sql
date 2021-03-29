# https://leetcode.com/problems/number-of-calls-between-two-persons/

WITH CTE AS (SELECT 
                 from_id as person1,
                 to_id as person2,
             duration
            FROM Calls WHERE from_id < to_id
             UNION ALL
             SELECT 
                to_id as person1, 
                from_id as person2, duration
            FROM Calls WHERE from_id > to_id)


SELECT 
    person1,
    person2,
    count(*) as call_count,
    sum(duration) as total_duration
FROM CTE
GROUP BY person1, person2

#Another solution

WITH CTE AS (SELECT * FROM Calls
UNION ALL
SELECT to_id, from_id, duration FROM Calls)

SELECT
    from_id person1,
    to_id person2,
    COUNT(*) call_count,
    SUM(duration) total_duration
FROM CTE 
WHERE from_id < to_id
GROUP BY 1, 2