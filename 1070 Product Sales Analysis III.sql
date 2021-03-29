# https://leetcode.com/problems/product-sales-analysis-iii/submissions/

SELECT product_id,
    year as first_year,
    quantity,
    price
FROM Sales
WHERE (product_id, year) in (SELECT product_id,
            min(year) FROM Sales
            GROUP BY product_id)

#Another Solution
WITH CTE AS (
    SELECT
        product_id,
        `year` as first_year,
        quantity,
        price,
        rank() OVER (partition by product_id order by year) as row_num
    FROM Sales)

 SELECT
    p.product_id,
    s.first_year,
    s.quantity,
    s.price
 FROM Product p 
    LEFT JOIN CTE s USING(product_id)
WHERE row_num = 1