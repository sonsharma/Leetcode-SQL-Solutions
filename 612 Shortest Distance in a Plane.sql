# https://leetcode.com/problems/shortest-distance-in-a-plane/

SELECT 
    round(sqrt(min(power(p2.y - p1.y,2) + power(p2.x - p1.x,2))),2) as shortest
FROM
    point_2d p1 cross join point_2d p2 ON p1.x != p2.x OR p1.y != p2.y
    ;