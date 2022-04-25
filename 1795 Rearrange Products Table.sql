-- https://leetcode.com/problems/rearrange-products-table/

WITH store AS (SELECT 'store1' as store
              UNION
              SELECT 'store2' as store
              UNION
              SELECT 'store3' as store)

SELECT
    product_id,
    store,
    CASE WHEN store = "store1" THEN store1
        WHEN store = "store2" THEN store2
        WHEN store = "store3" THEN store3
        ELSE null 
    END as price
FROM Products, Store
HAVING price IS NOT NULL;

-- Another solution (Better)
SELECT product_id, 'store1' AS store, store1 AS price FROM Products WHERE store1 IS NOT NULL
UNION 
SELECT product_id, 'store2' AS store, store2 AS price FROM Products WHERE store2 IS NOT NULL
UNION 
SELECT product_id, 'store3' AS store, store3 AS price FROM Products WHERE store3 IS NOT NULL

ORDER BY 1,2 ASC;