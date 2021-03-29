# https://leetcode.com/problems/unique-orders-and-customers-per-month/

SELECT
    DATE_FORMAT(order_date,'%Y-%m') AS month, 
    count(distinct order_id) as order_count,
    count(distinct customer_id) as customer_count
FROM Orders o
WHERE invoice > 20
GROUP by 1

