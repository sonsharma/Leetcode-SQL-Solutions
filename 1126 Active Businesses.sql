WITH CTE as (SELECT
    event_type, AVG(occurences) as avg_occurences
FROM Events
GROUP BY event_type)

SELECT
    business_id
FROM Events e LEFT JOIN CTE c ON e.event_type = c.event_type
WHERE e.occurences > c.avg_occurences
GROUP BY business_id
HAVING count(e.event_type) > 1
;