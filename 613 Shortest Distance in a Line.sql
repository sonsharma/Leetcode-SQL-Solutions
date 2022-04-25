-- https://leetcode.com/problems/shortest-distance-in-a-line/

SELECT
    min(abs(p1.x - p2.x)) as shortest
FROM
    point p1 join point p2 ON p1.x != p2.x;

 -- Another solution
SELECT
    MIN(ABS(p1.x-p2.x)) as shortest
FROM point p1, point p2 
WHERE p1.x <> p2.x

-- Another Solution
SELECT
    abs(p1.x - p2.x) shortest
FROM point p1 JOIN point p2 ON p1.x <> p2.x
ORDER BY 1
LIMIT 1