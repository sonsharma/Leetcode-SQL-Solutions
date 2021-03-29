# https://leetcode.com/problems/calculate-salaries/

-- find max salary using window function for each company
-- apply case condition for taxes based on (1)
-- round()

SELECT
    company_id,
    employee_id,
    employee_name,
    ROUND(CASE 
        WHEN MAX(salary) OVER (PARTITION BY company_id) < 1000 
          THEN salary
        WHEN MAX(salary) OVER (PARTITION BY company_id) between 1000 and 10000 
          THEN salary*0.76
        ELSE salary*0.51 END) as salary
FROM Salaries