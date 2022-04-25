-- https://leetcode.com/problems/average-selling-price/
	
SELECT
    p.product_id, round(sum(p.price*u.units)/sum(units),2) as average_price
FROM
    Prices p JOIN UnitsSold u ON p.product_id = u.product_id 
                        and u.purchase_date BETWEEN p.start_date and p.end_date
GROUP BY p.product_id