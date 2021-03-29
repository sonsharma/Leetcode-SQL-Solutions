# https://leetcode.com/problems/human-traffic-of-stadium/
SELECT
    DISTINCT s1.*
FROM Stadium s1, Stadium s2,  Stadium s3 
WHERE s1.people >= 100 and s2.people >= 100 and s3.people >= 100
    AND ( s1.id - s2.id = 1 and s1.id - s3.id = 2 and s2.id - s3.id = 1 -- s1,s2,s3
    OR s2.id - s1.id = 1 and s2.id - s3.id = 2 and s1.id - s3.id = 1    -- s2,s1,s3
    OR s3.id - s2.id = 1 and s3.id - s1.id = 2 and s2.id - s1.id = 1)   -- s3,s2,s1
ORDER BY s1.visit_date


# Another solution
SELECT id,visit_date, people
FROM (SELECT
    *,
    LAG(people, 2) OVER (ORDER BY Id) as lag2,
    LAG(people, 1) OVER (ORDER BY Id) as lag1,
    LEAD(people, 1) OVER (ORDER BY Id) as lead1,
    LEAD(people, 2) OVER (ORDER BY Id) as lead2
FROM Stadium)d
WHERE people>=100 and ((lag2>=100 and lag1>=100) or (lead1>=100 and lead2>=100) or (lag1>=100 and lead1>=100))

# Another solution
SELECT
    id,
    visit_date,
    people
FROM (SELECT
    *,
    IF(LAG(people, 2) OVER (ORDER BY ID) >= 100, 1, 0) as prev2,
    IF(LAG(people, 1) OVER (ORDER BY ID) >= 100, 1, 0) as prev1,
    IF(people >= 100, 1, 0) as curr,
    IF(LEAD(people, 1) OVER (ORDER BY ID) >= 100, 1, 0) as exd1,
    IF(LEAD(people, 2) OVER (ORDER BY ID) >= 100, 1, 0) as exd2
FROM Stadium) s
WHERE prev2 + prev1 + curr = 3 
    or prev1 + curr + exd1 = 3 
    or curr + exd1 + exd2 = 3