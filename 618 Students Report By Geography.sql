# https://leetcode.com/problems/students-report-by-geography/

SELECT 
    MIN(CASE WHEN Continent = 'America' THEN Name END) AS America,
    MIN(CASE WHEN Continent = 'Asia' THEN Name END) AS Asia,
    MIN(CASE WHEN Continent = 'Europe' THEN Name END) AS Europe
FROM (SELECT 
    *,
    row_number() OVER (PARTITION BY Continent Order by Name) as stu_rank
FROM Student) s
GROUP BY stu_rank

# Another solution
WITH CTE AS (SELECT
        CASE WHEN continent = 'America' then @r1:=@r1+1
            WHEN continent = 'Asia' then @r2 := @r2 +1
            WHEN continent = 'Europe' then @r3 := @r3 +1 END as row_num,
        CASE WHEN continent = 'America' then name END as America,
        CASE WHEN continent = 'Asia' then name END AS Asia,
        CASE WHEN continent = 'Europe' then name END as Europe
FROM Student, (SELECT @r1 :=0, @r2 :=0, @r3:=0)r 
ORDER BY Name)

SELECT min(America) as America,
    min(Asia) as Asia,
    min(Europe) as Europe
FROM CTE
GROUP BY row_num