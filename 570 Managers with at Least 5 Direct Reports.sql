# https://leetcode.com/problems/managers-with-at-least-5-direct-reports/

SELECT Name 
FROM Employee
WHERE Id in (SELECT
    ManagerId
FROM Employee
GROUP BY ManagerId
HAVING count(*) >= 5)