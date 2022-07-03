-- https://leetcode.com/problems/department-top-three-salaries/

WITH cte AS (SELECT
   d.name department,
   e.name employee,
   salary,
   DENSE_RANK() OVER (PARTITION BY d.id ORDER BY salary desc) rk
FROM department d JOIN employee e ON d.id = e.departmentId)

SELECT
    department,
    employee,
    salary
FROM cte
WHERE rk <= 3