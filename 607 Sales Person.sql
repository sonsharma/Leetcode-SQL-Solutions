# https://leetcode.com/problems/sales-person/

WITH CTE AS (SELECT
    sales_id
FROM Orders o LEFT JOIN company c USING(com_id)
WHERE c.name = 'RED')

SELECT
    name
FROM salesperson
WHERE sales_id not in (SELECT * FROM CTE);