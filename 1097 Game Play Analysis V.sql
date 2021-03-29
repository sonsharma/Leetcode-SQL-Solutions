# https://leetcode.com/problems/game-play-analysis-v/

WITH CTE AS (SELECT 
    player_id,
    min(event_date) as install_dt
FROM Activity
GROUP BY player_id),

installs AS (SELECT
                install_dt,
                count(*) as installs
            FROM CTE 
            GROUP BY install_dt)

SELECT
    i.install_dt,
    i.installs,
    round(COUNT(a.event_date)/i.installs, 2) AS Day1_retention
FROM installs i 
    LEFT JOIN CTE c USING(install_dt)
    LEFT JOIN Activity a ON c.player_id = a.player_id 
        and DATE_ADD(i.install_dt, interval 1 Day) = a.event_date 
GROUP BY i.install_dt
;