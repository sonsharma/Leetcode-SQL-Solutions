-- https://leetcode.com/problems/sales-analysis-i/

SELECT seller_id
FROM (SELECT
        seller_id,
        RANK() OVER (ORDER BY SUM(price) desc) AS seller_rank
    FROM Sales
    GROUP BY seller_id) s
WHERE seller_rank = 1