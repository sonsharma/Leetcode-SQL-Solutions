# https://leetcode.com/problems/trips-and-users/

SELECT 
    Request_at as Day, 
    ROUND(COUNT(IF(Status != 'completed', TRUE, NULL)) / COUNT(*), 2)as 'Cancellation Rate'
FROM Trips t
WHERE t.client_id not in (SELECT Users_id FROM Users where Banned = 'YES') 
	and t.driver_id not in (SELECT Users_id FROM Users where Banned = 'YES') 
	and Request_at between '2013-10-01' and '2013-10-03'
GROUP BY Request_at

# Another solution
SELECT
    Request_at Day,
    ROUND(SUM(CASE WHEN u.Banned != 'Yes' and Status != 'completed' THEN 1 else 0 END)/SUM(CASE WHEN u.Banned != 'Yes' THEN 1 ELSE 0 END), 2) 'Cancellation Rate'
FROM Trips t 
 LEFT JOIN Users u ON t.Client_id = u.Users_id or t.Driver_id = u.users_id and u.banned = 'yes' 
WHERE Request_at between '2013-10-01' and '2013-10-03'
GROUP BY 1