-- https://leetcode.com/problems/find-the-start-and-end-number-of-continuous-ranges/

WITH CTE AS (SELECT log_id, row_number() OVER (ORDER BY log_id) as row_num
            FROM Logs)

SELECT min(log_id) as start_id, max(log_id) as end_id
FROM CTE
GROUP BY log_id - row_num
;

-- Another solution (without window function)

SELECT
    l1.log_id start_id,
    min(l2.log_id) end_id
FROM (SELECT log_id FROM Logs WHERE log_id - 1 NOT IN (SELECT * FROM Logs)) l1 
    JOIN (SELECT log_id FROM Logs WHERE log_id + 1 NOT IN (SELECT * FROM Logs)) l2
    ON l1.log_id <= l2.log_id
GROUP BY 1
ORDER BY 1

-- Another solution (similar to first one)
WITH logs_1 AS (SELECT
        log_id,
        IFNULL(log_id - 1 - LAG(log_id, 1) OVER (ORDER BY log_id), 0) group_col
    FROM Logs)

SELECT 
    min(log_id) start_id,
    max(log_id) end_id
FROM (SELECT
    log_id,
    SUM(group_col) OVER (ORDER BY log_id) groupings
FROM logs_1) l
GROUP BY groupings