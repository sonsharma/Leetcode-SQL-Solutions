# https://leetcode.com/problems/game-play-analysis-iii/

SELECT player_id, event_date, 
    SUM(games_played) OVER (PARTITION BY player_id Order by event_date) as games_played_so_far
FROM Activity
ORDER BY player_id, event_date desc
;

# Another solution
SELECT
    a1.player_id,
    a1.event_date,
    SUM(a2.games_played) as games_played_so_far
FROM Activity a1 LEFT JOIN Activity a2 
    ON a1.event_date >= a2.event_date and a1.player_id = a2.player_id
GROUP BY 1, 2