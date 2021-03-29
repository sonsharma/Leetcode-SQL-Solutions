# https://leetcode.com/problems/game-play-analysis-ii/

SELECT
    player_id,
    device_id
FROM
    (SELECT
        player_id,
        device_id,
        dense_rank() over (partition by 
                            player_id 
                           order by 
                            event_date) date_rank
    FROM
        Activity
    ) temp
WHERE
    date_rank = 1;

# Another solution

SELECT
    player_id,
    device_id
FROM Activity
WHERE (player_id, event_date) IN (SELECT
    a.player_id,
    min(a.event_date) 
FROM
    Activity a
GROUP BY a.player_id)