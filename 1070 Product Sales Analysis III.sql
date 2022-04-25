-- https://leetcode.com/problems/product-sales-analysis-iii/submissions/

SELECT product_id,
    year as first_year,
    quantity,
    price
FROM Sales
WHERE (product_id, year) in (SELECT product_id,
            min(year) FROM Sales
            GROUP BY product_id)

-- Another Solution
SELECT 
    product_id,
    first_year,
    quantity,
    price
FROM (SELECT
    product_id,
    year first_year,
    quantity,
    price,
    rank() OVER (PARTITION BY product_id ORDER BY year) rk
FROM Sales) s
WHERE rk = 1
;