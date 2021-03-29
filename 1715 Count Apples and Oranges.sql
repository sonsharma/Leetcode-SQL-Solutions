# https://leetcode.com/problems/count-apples-and-oranges/
	
-- for each box - add chest.applecount 
-- for each box - add chest.orangecount 
-- find total apple, oranges

SELECT
    SUM(IF(c.chest_id is null, 0, c.apple_count)) + SUM(b.apple_count) as apple_count,
    SUM(IF(c.chest_id is null, 0, c.orange_count)) + SUM(b.orange_count) as orange_count
FROM Boxes b LEFT JOIN Chests c USING(chest_id)


