#https://leetcode.com/problems/find-the-team-size/

-- HOW MANY TEAM ARE THERE - SIZE of that team
-- for each employee - check their team id - find size from (1)

WITH CTE AS (SELECT 
                team_id, count(*) as team_size
            FROM Employee
            GROUP BY team_id)

SELECT 
    e.employee_id,
    c.team_size
FROM Employee e LEFT JOIN CTE c USING(team_id)
GROUP BY e.employee_id
;

#Another solution - using window function
SELECT
    employee_id,
    COUNT(*) OVER (Partition by team_id) as team_size
FROM Employee