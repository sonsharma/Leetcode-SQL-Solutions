# https://leetcode.com/problems/hopper-company-queries-i/

-- active drivers - Count rides for each driver in 2020 using (2)
-- accepted_rides - Rides + accepted_rides 
-- order by month

WITH RECURSIVE CTE2 AS (SELECT 1 as num
                  UNION all
                  SELECT
                    num+1 as num
                 FROM CTE2 where num<12),
    CTE AS (SELECT 
        r.ride_id,
        a.ride_id as accepted_rides,
        a.driver_id, 
        requested_at
    FROM Rides r LEFT JOIN AcceptedRides a USING(ride_id)
           WHERE year(requested_at) = 2020)


SELECT num as 'month' ,
    IFNULl(COUNT(DISTINCT d.driver_id), 0) AS active_drivers,
    IFNULl(COUNT(DISTINCT accepted_rides), 0) AS accepted_rides
FROM CTE2 LEFT JOIN CTE ON num = month(requested_at)
        LEFT JOIN Drivers d ON date_format(join_date,'%Y-%m') <= CONCAT('2020-',LPAD(num,2,'00'))
GROUP BY num

#Another solution - better
WITH RECURSIVE CTE AS (SELECT 1 month
                        UNION
                        SELECT
                            month+1 month
                        FROM CTE
                        WHERE month <= 11),
Accepted_rides AS (SELECT
                        month(r.requested_at) month,
                        COUNT(*) accepted_rides
                    FROM AcceptedRides a LEFT JOIN Rides r USING(ride_id)
                    WHERE year(r.requested_at) = 2020
                    GROUP BY month(r.requested_at))

SELECT
    c.month,
    COUNT(d.driver_id) active_drivers,
    IFNULL(a.accepted_rides, 0) accepted_rides
FROM CTE c 
    LEFT JOIN Accepted_Rides a USING(month)
    LEFT JOIN Drivers d ON YEAR(d.join_date) < '2020' or c.month >= month(d.join_date) and year(d.join_date) = '2020'
GROUP BY 1