# https://leetcode.com/problems/tournament-winners/
-- Matches - all players who played till now + their scores
-- Distinct players in 1 - Their total score
-- Merge 2 with Players table 
-- take the max score for each group

WITH CTE AS (SELECT first_player as player_id, first_score as score from Matches
            UNION ALL
             SELECT second_player as player_id, second_score as score from Matches
            ),
    CTE2 AS (SELECT player_id, sum(score) as score
            FROM CTE 
            GROUP BY player_id)
   
SELECT
    DISTINCT p.group_id,
    FIRST_VALUE(p.player_id) OVER (Partition by group_id ORDER BY c.score desc, p.player_id) as player_id
FROM Players p LEFT JOIN CTE2 c USING (player_id)

