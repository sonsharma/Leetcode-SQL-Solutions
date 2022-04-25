-- https://leetcode.com/problems/all-people-report-to-the-given-manager/

WITH RECURSIVE CTE AS (
    SELECT employee_id, 1 as elevel
    FROM Employees
    WHERE manager_id = 1 AND employee_id != 1
    
    UNION ALL

    SELECT e.employee_id, c.elevel + 1 as elevel
    FROM Employees e JOIN CTE c ON e.manager_id = c.employee_id
)

SELECT employee_id
FROM CTE
WHERE elevel<=3
;

-- Another solution
WITH direct_report AS (SELECT
        employee_id
    FROM Employees
    WHERE (employee_id <> manager_id AND manager_id = 1)),

2_direct_report AS (SELECT
    employee_id
FROM employees
WHERE manager_id IN (SELECT employee_id FROM direct_report))

SELECT employee_id FROM direct_report
UNION
SELECT employee_id FROM 2_direct_report
UNION
(SELECT
    employee_id
FROM employees
WHERE manager_id IN (SELECT employee_id FROM 2_direct_report))