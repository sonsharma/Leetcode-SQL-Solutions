# https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/

-- alias of two emp tables
-- order by emp_id

SELECT
    e1.reports_to AS employee_id,
    e2.name AS name,
    COUNT(e1.employee_id) AS reports_count,
    ROUND(AVG(e1.age)) AS average_age
FROM Employees e1 JOIN Employees e2 ON e1.reports_to = e2.employee_id
GROUP BY e1.reports_to
HAVING e1.reports_to is NOT NULL
ORDER BY e1.reports_to
;

# Another solution
SELECT
    e1.reports_to employee_id,
    e2.name,
    COUNT(e1.employee_id)  reports_count,
    ROUND(AVG(e1.age)) average_age
FROM Employees e1 LEFT JOIN Employees e2 ON e1.reports_to = e2.employee_id
WHERE e1.reports_to is not null
GROUP BY 1
ORDER BY 1