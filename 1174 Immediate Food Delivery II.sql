# https://leetcode.com/problems/immediate-food-delivery-ii/
WITH CTE AS (Select order_date, 
             customer_pref_delivery_date,
             rank() OVER (Partition by customer_id ORDER BY order_date) as date_rank
            FROM Delivery)
            
SELECT
    ROUND(SUM(IF(order_date = customer_pref_delivery_date, 1, 0))*100/COUNT(*), 2) as immediate_percentage
FROM CTE 
WHERE date_rank = 1