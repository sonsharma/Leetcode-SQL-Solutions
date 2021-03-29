#https://leetcode.com/problems/the-most-recent-three-orders/ 

-- rank order_date in desc for each customer 
-- filter order with rank 1,2,3 
-- order customer_name, cust_id, order_date desc

SELECT
    customer_name, 
    customer_id,
    order_id,
    order_date
FROM (SELECT
        name as customer_name, 
        customer_id,
        order_id,
        order_date,
        RANK() OVER (PARTITION BY customer_id ORDER BY order_date desc) as order_rank
        FROM Orders LEFT JOIN Customers c USING(customer_id)) o
WHERE order_rank <= 3
ORDER BY customer_name, customer_id, order_date desc
;