#https://leetcode.com/problems/new-users-daily-count/submissions/

-- get data for last 90 days
-- for each user - get login_date
-- count user for each login_date in (2)


SELECT
    login_date,
    COUNT(user_id) as user_count
FROM (SELECT
        user_id,
        min(activity_date) as login_date
    FROM Traffic
    WHERE activity = 'login'
    GROUP BY user_id) s
WHERE login_date >= SUBDATE('2019-06-30', Interval 90 day)
GROUP BY login_date
;