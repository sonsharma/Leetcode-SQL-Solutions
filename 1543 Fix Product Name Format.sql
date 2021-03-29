# https://leetcode.com/problems/fix-product-name-format/

SELECT
    lower(trim(product_name)) as product_name, 
    left(sale_date, 7) as sale_date, 
    count(*) as total
FROM Sales
GROUP BY lower(trim(product_name)), left(sale_date, 7)
ORDER BY lower(trim(product_name)), left(sale_date, 7)

# Another solution
SELECT
    lower(trim(product_name)) product_name,
    DATE_FORMAT(sale_date, '%Y-%m') sale_date,
    COUNT(*) total
FROM Sales
GROUP BY 1, 2
ORDER BY 1, 2