-- https://leetcode.com/problems/list-the-products-ordered-in-a-period/

SELECT
    product_name, sum(unit) as unit
FROM
    Products p LEFT JOIN Orders o ON p.product_id = o.product_id and (o.order_date between '2020-02-01' and '2020-02-29')
GROUP BY product_name
HAVING sum(unit) >= 100 

