# https://leetcode.com/problems/customers-who-bought-products-a-and-b-but-not-c/

-- customer_id who have bought product A and B
-- customer_id who have not bough product C
-- (1)-(2) -> find their names from customer table
-- order by customer_id

SELECT DISTINCT c1.customer_id, c2.customer_name
FROM Orders c1 LEFT JOIN Customers c2 USING(customer_id)
WHERE c1.customer_id  NOT IN (SELECT DISTINCT customer_id FROM Orders WHERE product_name = 'C')
    and c1.customer_id IN (SELECT DISTINCT customer_id FROM Orders WHERE product_name = 'A' )
    and c1.customer_id IN (SELECT DISTINCT customer_id FROM Orders WHERE product_name = 'B' )

