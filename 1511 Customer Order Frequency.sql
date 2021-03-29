# https://leetcode.com/problems/customer-order-frequency/

SELECT c.customer_id, name
FROM Customers c
    LEFT JOIN Orders o USING(customer_id)
    LEFT JOIN Product p USING(product_id)
GROUP by customer_id
HAVING SUM(if(month(o.order_date)=6 and year(o.order_date)=2020,o.quantity*p.price,0)) >=100 
and SUM(if(month(o.order_date)=7 and year(o.order_date)=2020,o.quantity*p.price,0)) >=100 