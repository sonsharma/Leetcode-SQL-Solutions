# https://leetcode.com/problems/running-total-for-different-genders/

SELECT
    gender,
    day,
    SUM(score_points) OVER (Partition by gender ORDER BY day) AS total
FROM Scores
GROUP BY 1, 2
ORDER BY 1, 2