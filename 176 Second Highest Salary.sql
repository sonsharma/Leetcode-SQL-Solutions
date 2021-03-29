#https://leetcode.com/problems/second-highest-salary/

SELECT 
    IFNULL(
        (SELECT 
        DISTINCT Salary 
    FROM
        Employee
    ORDER BY Salary desc
    LIMIT 1 OFFSET 1), null) as SecondHighestSalary;