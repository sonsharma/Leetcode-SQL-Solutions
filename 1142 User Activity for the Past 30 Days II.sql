# https://leetcode.com/problems/user-activity-for-the-past-30-days-ii/

SELECT round(ifnull(avg(average_sessions_per_user),0.00),2) as average_sessions_per_user
FROM
(SELECT
    count(distinct session_id) as average_sessions_per_user
FROM
    Activity
WHERE activity_date between date_sub('2019-07-27', INTERVAL 29 day) and '2019-07-27'
GROUP BY user_id) a