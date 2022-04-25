-- https://leetcode.com/problems/exchange-seats/

SELECT
    s1.id,
    IFNULL(s2.student, s1.student) student
FROM
    seat s1
        LEFT JOIN
    seat s2 ON (s1.id+1)^1-1 = s2.id
ORDER BY s1.id;

-- Another solution
SELECT
    CASE WHEN id = (SELECT max(id) FROM seat) and id%2 = 1 THEN id
        WHEN id%2 = 1 THEN id + 1
        WHEN id%2 = 0 THEN id - 1 
    END AS id,
    student
FROM seat
ORDER BY 1

-- Another solution 
SELECT
    IFNULL(s2.id, s1.id) id,
    s1.student student
FROM seat s1 LEFT JOIN seat s2 
    ON CASE WHEN s1.id%2=1 THEN s1.id=s2.id-1
        WHEN s1.id%2=0 THEN s1.id=s2.id+1
        END
ORDER BY 1
