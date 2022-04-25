-- https://leetcode.com/problems/ad-free-sessions/

SELECT
    session_id
FROM Playback p LEFT JOIN Ads a ON p.customer_id = a.customer_id AND (timestamp BETWEEN start_time AND end_time)
GROUP BY session_id
HAVING SUM(IFNULL(a.timestamp, 0)) = 0