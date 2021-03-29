# https://leetcode.com/problems/consecutive-numbers/

SELECT DISTINCT ConsecutiveNums FROM
(SELECT
     (CASE 
              WHEN LAG(Num, 1) OVER (ORDER BY ID) = Num and LEAD(Num, 1) OVER (ORDER BY ID) = Num
              THEN Num END) as ConsecutiveNums
FROM Logs)m
WHERE ConsecutiveNums is not NULL;

# Another solution
-- Find previous and next record - check its the same as current, if same then 1 else 0
-- sum({1}})
-- filter where {2} = 2

SELECT
    DISTINCT Num ConsecutiveNums
FROM (SELECT
        Num,
        IF(LAG(Num) OVER (ORDER BY Id) = NUM, 1, 0) as PrevNum,
        IF(LEAD(Num) OVER (ORDER BY Id) = NUM, 1, 0) as NextNum
    FROM Logs) l
WHERE PrevNum + NextNum = 2

# Another solution 
SELECT DISTINCT
    l1.Num AS ConsecutiveNums
FROM
    Logs l1,
    Logs l2,
    Logs l3
WHERE
    l1.Id = l2.Id - 1
    AND l2.Id = l3.Id - 1
    AND l1.Num = l2.Num
    AND l2.Num = l3.Num
;