# https://leetcode.com/problems/average-time-of-process-per-machine/

SELECT
    machine_id, ROUND((SUM(if(activity_type='end', timestamp, 0)) - SUM(if(activity_type='start', timestamp, 0)))/COUNT(DISTINCT process_id), 3) as processing_time
FROM Activity a
GROUP BY machine_id
;