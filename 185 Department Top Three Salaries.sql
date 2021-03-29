# https://leetcode.com/problems/department-top-three-salaries/

WITH CTE as (SELECT *,
             dense_rank() OVER (Partition by DepartmentId ORDER BY Salary desc) as salRank
FROM Employee
)

SELECT 
    d.Name as Department, e.Name as Employee, e.Salary as Salary
FROM Department d JOIN CTE e ON d.Id = e.DepartmentId
WHERE row_num in (1,2,3)
;