# https://leetcode.com/problems/employees-earning-more-than-their-managers/

-- use employee - find for each employee -> their manager salary using second alias
-- put inner join condition to handle employee having no manager
-- apply a filter condition

SELECT
    e1.Name as Employee
FROM Employee e1 
        JOIN Employee e2 ON e1.ManagerId = e2.Id and e1.Salary > e2.Salary
;