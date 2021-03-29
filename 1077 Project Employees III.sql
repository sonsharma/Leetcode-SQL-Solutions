# https://leetcode.com/problems/project-employees-iii/

-- join project + employee
--  get max exp_years of every project_id
-- filter 1 based on 2

WITH CTE AS (SELECT 
                 p.project_id,
                 e.employee_id,
                 e.experience_years
             FROM Project p LEFT JOIN Employee e USING(employee_id))

SELECT 
    project_id,
    employee_id
FROM CTE 
WHERE (project_id, experience_years) in (SELECT project_id, max(experience_years)
        FROM CTE
        GROUP BY project_id)
;

# Another solution
-- join project + employee
-- rank using exp_yrs
-- select with rank 1

WITH CTE AS (SELECT 
                 p.project_id,
                 e.employee_id,
                 RANK() OVER (partition by p.project_id order by e.experience_years desc) as row_rank
             FROM Project p LEFT JOIN Employee e USING(employee_id))

SELECT 
    project_id,
    employee_id
FROM CTE 
WHERE row_rank = 1
;