# https://leetcode.com/problems/biggest-window-between-visits/

-- sort the dates for each user_id -> find diff of day between each consecutive visit
-- if next date is null then sub the date from '2021-01-01'
-- find the max of dates

SELECT user_id, max(wind) as biggest_window
FROM (SELECT
    user_id,
    IFNULL(DATEDIFF(LEAD(visit_date, 1) OVER (PARTITION BY user_id ORDER BY visit_date), visit_date),
           DATEDIFF('2021-01-01', visit_date)) as wind
FROM UserVisits) w
GROUP BY user_id
ORDER BY user_id

#Another solution - better
WITH CTE AS (SELECT
                user_id,
                DATEDIFF(IFNULL(LEAD(visit_date, 1) OVER (PARTITION BY user_id ORDER BY visit_date), '2021-01-01'), visit_date) vwindow
            FROM UserVisits)

SELECT
    user_id,
    MAX(vwindow) biggest_window
FROM CTE
GROUP BY 1
ORDER BY 1