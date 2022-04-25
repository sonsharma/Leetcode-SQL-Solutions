-- https://leetcode.com/problems/number-of-times-a-driver-was-a-passenger/

SELECT
    driver_id,
    IFNULL(cnt, 0) cnt
FROM Rides r1 
    LEFT JOIN (SELECT passenger_id, count(*) cnt FROM Rides GROUP BY 1) r2 
    ON r1.driver_id = r2.passenger_id
GROUP BY driver_id

-- Another Solution
SELECT
  D.driver_id,
  COUNT(R2.passenger_id) AS cnt
FROM
  (SELECT DISTINCT R1.driver_id FROM Rides R1) D
  LEFT JOIN Rides R2 ON D.driver_id = R2.passenger_id
GROUP BY
  D.driver_id;