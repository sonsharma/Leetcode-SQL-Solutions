-- https://leetcode.com/problems/products-with-three-or-more-orders-in-two-consecutive-years/

-- Optimised solution
SELECT 
    DISTINCT d.product_id 
FROM (
    SELECT product_id, 
        YEAR(purchase_date) AS curr_year,
        LEAD(YEAR(purchase_date)) OVER(PARTITION BY product_id ORDER BY YEAR(purchase_date)) AS next_year
     FROM orders
     GROUP BY product_id, curr_year
     HAVING COUNT(order_id) >= 3) d
 WHERE d.next_year = d.curr_year + 1;


-- Long approach
WITH CTE AS (SELECT
                product_id,
                year(purchase_date) yr,
                count(*) order_cnt
            FROM Orders
            GROUP BY 1, 2)

SELECT 
    DISTINCT (product_id)
FROM (
    SELECT
    *,
    LAG(order_cnt, 1) OVER (PARTITION BY product_id ORDER BY yr) lag_order_cnt,
    LEAD(order_cnt, 1) OVER (PARTITION BY product_id ORDER BY yr) lead_order_cnt,
    LAG(yr, 1) OVER (PARTITION BY product_id ORDER BY yr) lag_yr,
    LEAD(yr, 1) OVER (PARTITION BY product_id ORDER BY yr) lead_yr
FROM CTE) c
WHERE 
    (lag_yr IS NOT NULL AND ABS(lag_yr - yr) = 1 AND lag_order_cnt>=3 AND order_cnt>=3) 
    OR (lead_yr IS NOT NULL AND ABS(lead_yr - yr) = 1 AND lead_order_cnt>=3 AND order_cnt>=3)
;