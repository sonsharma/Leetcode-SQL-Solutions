-- https://leetcode.com/problems/tasks-count-in-the-weekend/

SELECT 
    SUM(WEEKDAY(submit_date)>=5) AS weekend_cnt,
    SUM(WEEKDAY(submit_date)<5) AS working_cnt
FROM Tasks;