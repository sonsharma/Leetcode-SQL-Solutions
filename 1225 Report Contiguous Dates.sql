# https://leetcode.com/problems/report-contiguous-dates/

-- (row_number-fail_date) - use it to find group of continuous dates - group it
-- repeat same for success table as well
-- merge 1 and 2 together
-- order by start_date

SELECT 
    'failed' as period_state,
    min(fail_date) as start_date,
    max(fail_date) as end_date
FROM (SELECT 
        fail_date,
        row_number() OVER (ORDER BY fail_date) as row_num
    FROM Failed
    WHERE fail_date between '2019-01-01' and '2019-12-31') f
GROUP BY SUBDATE(fail_date, INTERVAL row_num day)

UNION ALL

SELECT 
    'succeeded' as period_state,
    min(success_date) as start_date,
    max(success_date) as end_date
FROM (SELECT 
        success_date,
        row_number() OVER (ORDER BY success_date) as row_num
    FROM succeeded
    WHERE success_date between '2019-01-01' and '2019-12-31') s
GROUP BY SUBDATE(success_date, INTERVAL row_num day)

ORDER BY start_date


#Another solution
WITH x AS (
    SELECT 'failed' AS period_state, fail_date AS date_x, ROW_NUMBER() OVER(ORDER BY fail_date) AS r FROM Failed
    UNION
    SELECT 'succeeded' AS period_state, success_date AS date_x, ROW_NUMBER() OVER(ORDER BY success_date) AS r FROM Succeeded
)
SELECT
    period_state,
    MIN(date_x) AS start_date,
    MAX(date_x) AS end_date
FROM x
WHERE date_x LIKE '2019%'
GROUP BY 1, DATE_ADD(date_x, INTERVAL -r DAY)
ORDER BY 2


#Another solution
-- success - for a date -> lower date is not present - start_date
    --             higher_date not present - end date
-- repeat it for failed
-- merge 1,2 tables together

WITH failed_1 as (SELECT *
        FROM Failed f 
        WHERE year(fail_date) = 2019),
    Succeeded_1 as (SELECT *
        FROM Succeeded f 
        WHERE year(success_date) = 2019)

SELECT "failed" as period_state, f1.fail_date as start_date, min(f2.fail_date) as end_date
FROM    (SELECT fail_date FROM Failed_1 
        WHERE DATE_ADD(fail_date, INTERVAL -1 DAY)  NOT IN (SELECT * FROM Failed_1)) f1, 
        (SELECT fail_date FROM Failed_1 
        WHERE DATE_ADD(fail_date, INTERVAL 1 DAY) NOT IN (SELECT * FROM Failed_1)) f2
WHERE f1.fail_date <= f2.fail_date
GROUP BY f1.fail_date

UNION

SELECT "succeeded" as period_state, f1.success_date as start_date, min(f2.success_date) as end_date
FROM    (SELECT success_date FROM Succeeded_1 
        WHERE DATE_ADD(success_date, INTERVAL -1 DAY)  NOT IN (SELECT * FROM Succeeded_1)) f1, 
        (SELECT success_date FROM Succeeded_1 
        WHERE DATE_ADD(success_date, INTERVAL 1 DAY) NOT IN (SELECT * FROM Succeeded_1)) f2
WHERE f1.success_date <= f2.success_date
GROUP BY f1.success_date

ORDER BY start_date

