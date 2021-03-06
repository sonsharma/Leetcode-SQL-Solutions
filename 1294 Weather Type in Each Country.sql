# https://leetcode.com/problems/weather-type-in-each-country/

SELECT
    country_name,
    CASE WHEN AVG(weather_state) <= 15 THEN 'Cold'
        WHEN AVG(weather_state) >= 25 THEN 'Hot'
        ELSE "Warm" END AS weather_type
FROM Countries c 
     JOIN Weather w ON c.country_id = w.country_id and LEFT(day,7) = '2019-11'
GROUP BY 1