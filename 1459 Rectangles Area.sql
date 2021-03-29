# https://leetcode.com/problems/rectangles-area/

-- two temp points tables - join them 
-- filter on rectangle condition
-- order area desc, p1, p2

SELECT
    p1.id p1,
    p2.id p2,
    ABS(p1.x_value - p2.x_value) * ABS(p1.y_value - p2.y_value) area
FROM Points p1 JOIN Points p2 ON p1.id <> p2.id and p1.id < p2.id
HAVING area <> 0
ORDER BY 3 desc, p1.id, p2.id