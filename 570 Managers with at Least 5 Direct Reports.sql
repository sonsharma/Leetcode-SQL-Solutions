-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/

SELECT Name 
FROM Employee
WHERE Id in (SELECT
    ManagerId
FROM Employee
GROUP BY ManagerId
HAVING count(*) >= 5)

-- Another Solution 
SELECT
    e.name
FROM employee m JOIN employee e ON m.managerId = e.id
GROUP BY m.managerId
HAVING count(m.id) >= 5
;