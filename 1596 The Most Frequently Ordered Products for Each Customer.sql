-- https://leetcode.com/problems/the-most-frequently-ordered-products-for-each-customer/

-- for each customer, product, -> rank (how many times a product has been ordered - count each distinct date)
-- filter out rows with rank 1

WITH CTE AS (SELECT 
    customer_id,
    product_id,
    RANK() OVER (PARTITION BY customer_id ORDER BY countOrder desc) as prod_rank
FROM (SELECT 
        customer_id,
        product_id,
        count(DISTINCT order_date) as countOrder
    FROM Orders 
    GROUP BY customer_id, product_id) s)
    
SELECT 
    c.customer_id,
    c.product_id,
    p.product_name
FROM CTE c LEFT JOIN Products p USING(product_id)
WHERE prod_rank = 1

-- Another solution - Better
WITH CTE AS (SELECT
    customer_id,
    product_id,
    RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(product_id) DESC) product_rank
FROM Orders
GROUP BY 1, 2)

SELECT
    c.customer_id,
    c.product_id,
    p.product_name
FROM CTE c LEFT JOIN Products p USING(product_id)
WHERE c.product_rank = 1