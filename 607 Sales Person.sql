-- https://leetcode.com/problems/sales-person/

WITH CTE AS (SELECT
    sales_id
FROM Orders o LEFT JOIN company c USING(com_id)
WHERE c.name = 'RED')

SELECT
    name
FROM salesperson
WHERE sales_id not in (SELECT * FROM CTE);

-- Another Solution
SELECT
    s.name
FROM SalesPerson s
    LEFT JOIN Orders o USING(sales_id)
    LEFT JOIN Company c ON o.com_id = c.com_id
GROUP BY s.name
HAVING SUM(c.name = 'RED') = 0 OR COUNT(o.order_id) = 0;