# https://leetcode.com/problems/hopper-company-queries-iii/

-- Build month recursive cte
-- find avg ride dist and avg ride duration for each AcceptedRides gruop by month(requested_at)
-- join 1 and 2

WITH Recursive months AS (SELECT 1 as month
                         UNION ALL
                         SELECT month + 1
                         FROM months where month<12),
    AcceptedR AS (SELECT
                 month(requested_at) as month,
                  sum(ride_distance) AS average_ride_distance,
                  sum(ride_duration) AS average_ride_duration
                 FROM AcceptedRides a LEFT JOIN Rides r USING(ride_id)
                  WHERE year(requested_at) = 2020
                 GROUP BY month(requested_at)),
    month_window AS (SELECT 
                        m.month, 
                        IFNULL(average_ride_distance, 0) as average_ride_distance,
                        IFNULL(average_ride_duration, 0) as average_ride_duration
                     FROM months m LEFT JOIN AcceptedR USING(month)
                    GROUP BY m.month)
    
SELECT 
    month, 
    ROUND(IFNULL(AVG(average_ride_distance) OVER (ORDER BY month rows between current row and 2 following), 0), 2) as average_ride_distance,
    ROUND(IFNULL(AVG(average_ride_duration) OVER (ORDER BY month rows between current row and 2 following), 0), 2) as average_ride_duration
FROM month_window
LIMIT 10

#Another solution - better

-- make months table
-- calculate total ride dist and duration for each months ride in accepted rides table
-- merge 1 and 2 -> use window function to calculate avg of 3 months dist and duration

WITH RECURSIVE CTE AS (SELECT 1 month
                      UNION
                      SELECT month+1 month
                      FROM CTE WHERE month <= 11),
                      
    Accepted_rides AS (SELECT
                       month(r.requested_at) month,
                       SUM(ride_distance) ride_distance,
                       SUM(ride_duration) ride_duration
                      FROM AcceptedRides a LEFT JOIN Rides r USING(ride_id)
                      WHERE YEAR(r.requested_at) = '2020'
                      GROUP BY 1)

SELECT
    c.month,
    ROUND(IFNULL((SUM(ride_distance) OVER (ORDER BY c.month rows between current row and 2 following))/3, 0), 2) average_ride_distance,
    ROUND(IFNULL((SUM(ride_duration) OVER (ORDER BY c.month rows between current row and 2 following))/3, 0), 2)  average_ride_duration
FROM CTE c LEFT JOIN Accepted_rides a USING(month)
LIMIT 10