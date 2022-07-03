-- https://leetcode.com/problems/sales-by-day-of-the-week/

SELECT
    item_category as category,
    sum(if(dayname(o.order_date)='Monday', quantity, 0)) as Monday,
    sum(if(dayname(o.order_date)='Tuesday', quantity, 0)) as Tuesday,
    sum(if(dayname(o.order_date)='Wednesday', quantity, 0)) as Wednesday,
    sum(if(dayname(o.order_date)='Thursday', quantity, 0)) as Thursday,
    sum(if(dayname(o.order_date)='Friday', quantity, 0)) as Friday,
    sum(if(dayname(o.order_date)='Saturday', quantity, 0)) as Saturday,
    sum(if(dayname(o.order_date)='Sunday', quantity, 0)) as Sunday
FROM Items i LEFT JOIN Orders o USING(item_id)
GROUP BY item_category
ORDER BY item_category

-- Another similar solution
-- JOIN Order with Items -> item_id
-- segregate order_date on basis of day of week -> get sum(qty)
-- group by item_cate
-- order by item_cate

SELECT
    item_category category,
    SUM(IF(DAYOFWEEK(order_date) = 2, quantity, 0)) Monday,
    SUM(IF(DAYOFWEEK(order_date) = 3, quantity, 0)) Tuesday,
    SUM(IF(DAYOFWEEK(order_date) = 4, quantity, 0)) Wednesday,
    SUM(IF(DAYOFWEEK(order_date) = 5, quantity, 0)) Thursday,
    SUM(IF(DAYOFWEEK(order_date) = 6, quantity, 0)) Friday,
    SUM(IF(DAYOFWEEK(order_date) = 7, quantity, 0)) Saturday,
    SUM(IF(DAYOFWEEK(order_date) = 1, quantity, 0)) Sunday
FROM Items i LEFT JOIN Orders o USING(item_id)
GROUP BY 1
ORDER BY 1