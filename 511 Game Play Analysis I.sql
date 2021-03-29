# https://leetcode.com/problems/game-play-analysis-i/

SELECT
    a.player_id,
    min(a.event_date) as 'first_login'
FROM
    Activity a
GROUP BY a.player_id;