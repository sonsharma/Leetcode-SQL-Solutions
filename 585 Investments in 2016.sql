#https://leetcode.com/problems/investments-in-2016/
SELECT
    SUM(i1.TIV_2016) as TIV_2016
FROM Insurance i1
WHERE i1.TIV_2015 IN (SELECT i2.TIV_2015 FROM Insurance i2 WHERE i2.pid <> i1.pid)
    AND 
    (i1.lat, i1.lon) NOT in (SELECT i3.lat, i3.lon FROM Insurance i3 WHERE i3.pid <> i1.pid)

#Another solution

SELECT sum(TIV_2016) as TIV_2016
FROM insurance 
WHERE TIV_2015 in (SELECT TIV_2015
FROM insurance i1
GROUP BY TIV_2015
HAVING count(TIV_2015) > 1)
AND concat(lat,",",lon) IN (SELECT concat(i1.lat,",",i1.lon) as latlon
FROM insurance i1
GROUP BY concat(i1.lat,",",i1.lon)
HAVING count(concat(i1.lat,",",i1.lon)) = 1)


