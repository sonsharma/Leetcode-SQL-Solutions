# https://leetcode.com/problems/game-play-analysis-iv/

SELECT ROUND(count(a.player_id)/a3.total, 2) as fraction FROM (
    SELECT a1.player_id as player_id from
(SELECT player_id, min(event_date) as event_date
FROM Activity
GROUP BY player_id) a1 LEFT JOIN Activity A2 ON SUBDATE(a1.event_date, INTERVAL -1 DAY) = a2.event_date and a1.player_id = a2.player_id
WHERE a2.event_date is not null) a, (SELECT count(DISTINCT player_id) as total FROM Activity) a3

# another solution
WITH CTE AS (SELECT
            player_id,
            min(event_date) event_date
        FROM Activity
        GROUP BY player_id)

SELECT
    ROUND(SUM(IF(DATE_SUB(a1.event_date, INTERVAL 1 Day) = a2.event_date, 1, 0))/ COUNT(DISTINCT a1.player_id), 2) fraction
FROM Activity a1 LEFT JOIN CTE a2 
        ON a1.player_id = a2.player_id 