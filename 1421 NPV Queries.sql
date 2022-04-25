-- https://leetcode.com/problems/npv-queries/

SELECT q.id, q.year, IFNULL(n.NPV, 0) as npv
FROM Queries q LEFT JOIN NPV n ON q.id = n.id and q.year = n.year

