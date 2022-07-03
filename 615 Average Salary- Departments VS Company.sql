-- https://leetcode.com/problems/average-salary-departments-vs-company/


WITH CTE AS (SELECT s.*, e.department_id
FROM Salary s LEFT JOIN Employee e USING(employee_id)),

CTE2 AS (SELECT department_id, DATE_FORMAT(pay_date,'%Y-%m') as pay_month,
            avg(amount) OVER (PARTITION BY DATE_FORMAT(pay_date,'%Y-%m')) as monthly_avg,
            avg(amount) OVER (PARTITION BY DATE_FORMAT(pay_date,'%Y-%m'), department_id) as department_avg
         FROM CTE 
)


SELECT 
    pay_month,
    department_id,
    CASE WHEN MIN(department_avg) > MIN(monthly_avg) THEN 'higher'
        WHEN MIN(department_avg) < MIN(monthly_avg) THEN 'lower'
        ELSE 'same' END as comparison
FROM CTE2
GROUP BY pay_month, department_id

-- Another solution (concise)

-- Get department id information in salary table
-- find avg(salary) for each 'year-month', department 
-- find overall avg(salary of company)
-- compare 2 with 3

WITH CTE AS (SELECT
    DATE_FORMAT(pay_date, '%Y-%m') pay_month,
    department_id,
    AVG(amount) OVER (partition by DATE_FORMAT(pay_date, '%Y-%m'), department_id) dept_avg,
    AVG(amount) OVER (partition by DATE_FORMAT(pay_date, '%Y-%m')) monthly_avg
FROM Salary LEFT JOIN employee USING(employee_id)
)

SELECT
    pay_month,
    department_id,
    IF(dept_avg > monthly_avg, 'higher', IF(dept_avg < monthly_avg, 'lower', 'same')) comparison
FROM CTE
GROUP BY 1, 2
ORDER BY 1 desc, 2