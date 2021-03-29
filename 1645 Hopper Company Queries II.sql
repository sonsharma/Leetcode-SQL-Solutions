# https://leetcode.com/problems/hopper-company-queries-ii/

-- active drivers - Count rides for each driver in 2020 using (2)
-- accepted_rides - Rides + accepted_rides 
-- divide and order by month

WITH RECURSIVE 
    CTE2 AS (SELECT 1 as num
                  UNION all
                  SELECT
                    num+1 as num
                 FROM CTE2 where num<12),
                 
    CTE AS (SELECT month(requested_at) as num,
                count(distinct a.driver_id) as working_driver
             FROM Rides r LEFT JOIN AcceptedRides a USING(ride_id)
             WHERE year(requested_at) = 2020
             GROUP BY num),
             
    CTE3 AS (select months.num, ifnull(max(t1.active_drivers) over (order by num),0) as active_drivers
        from cte2 months left join   
        (select month(join_date) as month, count(driver_id) over (order by join_date rows unbounded preceding) as active_drivers
        from drivers
        where year(join_date) <= 2020) t1
        on t1.month = months.num)

SELECT c1.num as 'month' ,
   IFNULL(ROUND(working_driver*100/ 
                active_drivers,2), 0) AS working_percentage
FROM CTE2 c1 LEFT JOIN CTE c2 ON c1.num = c2.num
        LEFT JOIN CTE3 d ON c1.num = d.num 
GROUP BY c1.num

# Another solution - better
-- make months table
-- for each month-> find how many distinct drivers accepted rides
-- available drivers for each month
-- divide (2)/(3)
WITH RECURSIVE CTE AS (SELECT 1 month
                        UNION
                        SELECT
                            month+1 month
                        FROM CTE
                        WHERE month <= 11),
                 
    Accepted_rides AS (SELECT
                        month(r.requested_at) month,
                        COUNT(DISTINCT a.driver_id) num_drivers
                      FROM AcceptedRides a LEFT JOIN Rides r USING(ride_id)
                      WHERE YEAR(r.requested_at) = '2020'
                      GROUP BY 1)

SELECT
    c.month,
    ROUND(IFNULL( a.num_drivers*100/ COUNT(d.driver_id), 0), 2) working_percentage
FROM CTE c 
    LEFT JOIN Accepted_rides a USING(month)
    LEFT JOIN Drivers d ON YEAR(d.join_date) < '2020' or (c.month >= month(d.join_date) and YEAR(d.join_date) = '2020')
GROUP BY 1