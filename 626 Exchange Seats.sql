#https://leetcode.com/problems/exchange-seats/

SELECT
    *
FROM
    seat s1
        LEFT JOIN
    seat s2 ON (s1.id+1)^1 = s2.id
ORDER BY s1.id;

# Another student
SELECT
    CASE WHEN id = (SELECT max(id) FROM seat) and id%2 = 1 THEN id
        WHEN id%2 = 1 THEN id + 1
        WHEN id%2 = 0 THEN id - 1 
    END AS id,
    student
FROM seat
ORDER BY 1