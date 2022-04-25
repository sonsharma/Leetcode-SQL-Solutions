-- https://leetcode.com/problems/rising-temperature/

SELECT
    weather.id AS 'Id'
FROM
    weather
        JOIN
    weather w ON DATEDIFF(weather.recordDate, w.recordDate) = 1
        AND weather.Temperature > w.Temperature
;

-- Another solution

SELECT id
FROM (SELECT
    id,
    IF(DATEDIFF(recordDate, lag(recordDate, 1) OVER (ORDER BY recordDate)) = 1
       and (lag(temperature, 1) OVER (ORDER BY recordDate) < temperature), 1, 0) flag
FROM weather) w 
WHERE flag = 1;