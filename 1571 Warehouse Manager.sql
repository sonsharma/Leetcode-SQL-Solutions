# https://leetcode.com/problems/warehouse-manager/
SELECT
    name as warehouse_name, 
    sum(units*width*length*height) as volume
FROM Warehouse w LEFT JOIN Products p USING(product_id)
GROUP BY name