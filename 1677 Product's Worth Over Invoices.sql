# https://leetcode.com/problems/products-worth-over-invoices/

SELECT 
    name, 
    ifnull(sum(rest),0) rest, 
    ifnull(sum(paid),0) paid, 
    ifnull(sum(canceled),0) canceled, 
    ifnull(sum(refunded),0) refunded
FROM Product p JOIN Invoice USING(product_id)
GROUP BY p.product_id
ORDER BY name
;