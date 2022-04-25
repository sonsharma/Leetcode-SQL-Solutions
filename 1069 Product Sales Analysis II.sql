-- https://leetcode.com/problems/product-sales-analysis-ii/

SELECT
    product_id, sum(quantity) as total_quantity
FROM
    Sales
GROUP BY product_id;