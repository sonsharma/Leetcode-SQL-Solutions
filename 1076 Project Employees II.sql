#https://leetcode.com/problems/project-employees-ii/

SELECT project_id
from Project
GROUP BY project_id
HAVING count(employee_id) = (SELECT
        count(employee_id) as num
    FROM
        Project p
    GROUP BY project_id
    ORDER BY count(employee_id) desc
    LIMIT 1)