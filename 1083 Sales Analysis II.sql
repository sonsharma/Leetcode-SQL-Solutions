-- https://leetcode.com/problems/sales-analysis-ii/submissions/

SELECT s.buyer_id
FROM Sales s JOIN Product p USING(product_id)
GROUP BY s.buyer_id
HAVING SUM(p.product_name = 'S8') > 0 AND SUM(p.product_name = 'iPhone') > 0

-- Another solution

SELECT
    buyer_id
FROM (SELECT
    buyer_id,
    SUM(IF(product_name = 'S8', 1, 0)) s8_flag,
    SUM(IF(product_name = 'iPhone', 1, 0)) iPhone_flag
FROM sales LEFT JOIN product USING(product_id)
GROUP BY buyer_id) p
WHERE s8_flag >=1 and iPhone_flag = 0;