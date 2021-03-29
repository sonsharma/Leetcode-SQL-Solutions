SELECT
    extra as report_reason,
    COUNT(DISTINCT post_id) as report_count
FROM Actions
WHERE action_date = '2019-07-04' and action = 'report'
GROUP BY extra
;