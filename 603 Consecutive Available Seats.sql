-- https://leetcode.com/problems/consecutive-available-seats/

SELECT
    distinct b.seat_id
FROM
    cinema a join cinema b
    ON abs(a.seat_id - b.seat_id) = 1 and a.free = 1 and b.free = 1;

-- Another solution
SELECT
    DISTINCT c1.seat_id
FROM cinema c1 JOIN cinema c2 
    ON (c1.seat_id = c2.seat_id - 1 or c1.seat_id - 1 = c2.seat_id) and c1.free = 1 and c2.free = 1
ORDER BY 1

-- Another solution
SELECT seat_id
FROM (SELECT
    seat_id, free, 
    LAG(free, 1) OVER (ORDER BY seat_id) lag1, 
    LEAD(free, 1) OVER (ORDER BY seat_id) lead1
FROM cinema) s
WHERE free = 1 and (lag1 = 1 OR lead1 = 1)
ORDER BY 1
;