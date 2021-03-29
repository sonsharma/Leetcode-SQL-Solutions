# https://leetcode.com/problems/department-highest-salary/

SELECT
    d.name as Department, e2.name as Employee, s.Salary
FROM
    Department d 
    JOIN (SELECT DepartmentId, max(Salary) as Salary
         FROM Employee 
         GROUP BY DepartmentId) s ON d.Id = s.DepartmentId
    JOIN Employee e2 ON s.DepartmentId = e2.DepartmentId and s.Salary = e2.Salary
;

# Another solution
SELECT 
    department, 
    employee, 
    Salary
FROM (SELECT
    d.Name Department,
    e.Name Employee,
    Salary,
    Rank() OVER (Partition by e.DepartmentId ORDER BY Salary desc) as srank
FROM Employee e JOIN Department d ON e.DepartmentId = d.Id
) s
WHERE srank = 1