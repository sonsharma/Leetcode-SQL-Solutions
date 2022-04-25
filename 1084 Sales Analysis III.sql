-- https://leetcode.com/problems/sales-analysis-iii/

select s.product_id, p.product_name
from sales s, product p
where s.product_id = p.product_id
group by s.product_id, p.product_name
having min(s.sale_date) >= '2019-01-01' 
    and max(s.sale_date) <= '2019-03-31';

-- Another solution
SELECT
    p.product_id,
    MIN(product_name) product_name
FROM product p LEFT JOIN sales USING (product_id)
GROUP BY p.product_id
HAVING SUM(sale_date >= '2019-01-01' and sale_date <= '2019-03-31') = COUNT(*);