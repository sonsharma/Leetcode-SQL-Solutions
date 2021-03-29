# https://leetcode.com/problems/sellers-with-no-sales/

SELECT
    DISTINCT seller_name
FROM
    Seller s LEFT JOIN Orders o ON s.seller_id = o.seller_id and YEAR(o.sale_date) = 2020
WHERE o.seller_id is NULL
ORDER BY seller_name

#Another solution
SELECT seller_name
FROM Seller
WHERE seller_id not in (SELECT
                seller_id
            FROM Orders
            WHERE year(sale_date) = '2020')
ORDER BY 1