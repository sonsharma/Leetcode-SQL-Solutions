# https://leetcode.com/problems/product-sales-analysis-i/

SELECT
    product_name, year, price
FROM
      Sales s LEFT JOIN Product p USING(product_id);

#Another solution
SELECT
    p.product_name,
    s.year,
    s.price
FROM Product p JOIN Sales s USING(product_id)