#https://leetcode.com/problems/user-purchase-platform/submissions/
WITH CTE AS (SELECT spend_date, 'desktop' platform FROM Spending
UNION 
SELECT spend_date, 'mobile' platform FROM Spending
UNION
SELECT spend_date, 'both' platform FROM Spending
)

SELECT 
    c.spend_date,
    c.platform,
    ifnull(sum(s.amount),0) as total_amount,
    ifnull(COUNT(s.user_id),0) as total_users
FROM CTE c LEFT JOIN (SELECT user_id, spend_date, IF(COUNT(*) > 1, 'both', platform) AS 'platform',
    sum(amount) as amount
FROM Spending
GROUP BY user_id, spend_date) s
ON c.spend_date = s.spend_date and c.platform=s.platform
GROUP BY c.spend_date, c.platform

# Another solution
WITH CTE AS (SELECT spend_date, 'desktop' platform FROM Spending
        UNION 
        SELECT spend_date, 'mobile' platform FROM Spending
        UNION
        SELECT spend_date, 'both' platform FROM Spending),
        
CTE2 AS (SELECT
    spend_date,
    user_id,
    CASE WHEN COUNT(platform) = 2 THEN 'both' 
        else platform END as platform,
    SUM(amount) as total_amount
FROM Spending s
GROUP BY user_id, spend_date)

SELECT
    c1.spend_date,
    c1.platform,
    SUM(IFNULL(c2.total_amount,0)) as total_amount,
    COUNT(user_id) as total_users
FROM CTE c1 LEFT JOIN CTE2 c2 ON c1.spend_date = c2.spend_date and c1.platform=c2.platform
GROUP BY c1.platform, c1.spend_date