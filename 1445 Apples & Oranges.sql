# https://leetcode.com/problems/apples-oranges/

-- for each date - find sales for sum(apple) - sum(orange)
-- order by sale_date ('YYYY-MM-DD')

SELECT 
    sale_date, SUM(IF(fruit = 'apples', sold_num, 0)) - SUM(IF(fruit = 'oranges', sold_num, 0)) as diff
FROM Sales
GROUP BY 1
ORDER BY 1