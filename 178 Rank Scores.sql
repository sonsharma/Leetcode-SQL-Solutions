-- https://leetcode.com/problems/rank-scores/

SELECT 
    s1.score,
    COUNT(DISTINCT s2.score)  as 'RANK'
FROM
    Scores s1 LEFT JOIN Scores s2 ON s1.score <= s2.score
GROUP BY s1.id
ORDER BY 2

-- Another solution

 SELECT
    score,
    dense_rank() OVER (order by score desc) as 'Rank'
FROM Scores
ORDER BY 2;

-- Another solution
SELECT
  Score,
  (SELECT count(*) FROM (SELECT distinct Score s FROM Scores) tmp WHERE s >= Score) Rank
FROM Scores
ORDER BY Score desc