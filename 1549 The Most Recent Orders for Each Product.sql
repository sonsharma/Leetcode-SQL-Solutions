# https://leetcode.com/problems/the-most-recent-orders-for-each-product/

-- for each product_id - rank acc. to order_date desc
-- filter value in (1) using rank = 1
-- join (2) with products -> to get product_name (JOIN)
-- order by product_name, product_id, order_id

WITH CTE AS (SELECT 
                product_id,
                order_id,
                order_date,
                RANK() OVER (PARTITION BY product_id ORDER BY order_date desc) as productDate_rank
            FROM Orders)

SELECT 
    product_name,
    product_id,
    order_id,
    order_date
FROM CTE LEFT JOIN Products USING(product_id)
WHERE productDate_rank = 1
ORDER BY 1, 2, 3
;