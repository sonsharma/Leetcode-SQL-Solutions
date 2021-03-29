# https://leetcode.com/problems/team-scores-in-football-tournament/

WITH CTE AS (SELECT match_id, 
    IF(host_goals >= guest_goals, host_team, guest_team) AS win_team,
    IF(host_goals >= guest_goals, guest_team, host_team) AS lose_team,
    IF(host_goals = guest_goals, 1, 0) AS tie
FROM Matches)

SELECT 
    t.team_id,
    t.team_name,
    SUM(CASE WHEN tie = 0 and t.team_id = m.win_team THEN 3
            WHEN tie = 1 THEN 1
            ELSE 0 END) as num_points
FROM Teams t LEFT JOIN CTE m ON t.team_id = m.win_team or t.team_id = m.lose_team
GROUP BY t.team_id
ORDER BY num_points desc, t.team_id

# Another solution
SELECT
    team_id,
    team_name,
    COALESCE(SUM(CASE WHEN t.team_id = m.host_team THEN
        CASE WHEN host_goals > guest_goals THEN 3
            WHEN host_goals = guest_goals THEN 1
            ELSE 0 END
        WHEN t.team_id = m.guest_team THEN
         CASE WHEN host_goals < guest_goals THEN 3
            WHEN host_goals = guest_goals THEN 1
            ELSE 0 END 
    END), 0) as num_points
FROM teams t 
    LEFT JOIN Matches m ON t.team_id = m.host_team or t.team_id = m.guest_team
GROUP BY 1
ORDER BY 3 desc, 1
;