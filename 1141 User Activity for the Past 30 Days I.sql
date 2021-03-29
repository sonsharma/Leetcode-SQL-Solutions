#https://leetcode.com/problems/user-activity-for-the-past-30-days-i/

SELECT
    activity_date as day, count(distinct user_id) as active_users
FROM
    Activity
WHERE activity_date between date_sub('2019-07-27', INTERVAL 29 day) and '2019-07-27'
GROUP BY activity_date 


