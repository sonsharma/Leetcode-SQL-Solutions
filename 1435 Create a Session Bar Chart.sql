# https://leetcode.com/problems/create-a-session-bar-chart/

SELECT
    b.bin as BIN, ifnull(count(s.bin), 0) as TOTAL 
FROM
    (SELECT '[0-5>' AS bin
     UNION ALL
     SELECT '[5-10>' AS bin
     UNION ALL
     SELECT '[10-15>' AS bin
     UNION ALL
     SELECT '15 or more' AS bin) b LEFT JOIN
        (SELECT 
    CASE when (duration/60) < 5 then '[0-5>'
        when duration/60 < 10 then '[5-10>'
        when (duration/60) < 15 then '[10-15>'
        else '15 or more' end as bin FROM Sessions)  s ON b.bin = s.bin
GROUP BY b.bin

#Another solution - Better
WITH CTE AS ( SELECT '[0-5>' bin
             UNION
             SELECT '[5-10>' bin
             UNION
             SELECT '[10-15>' bin
             UNION
             SELECT '15 or more' bin)

SELECT
    bin,
    SUM(CASE WHEN bin = '[0-5>' and duration/60 >= 0 and duration/60 < 5 THEN 1
        WHEN bin = '[5-10>' and duration/60 >= 5 and duration/60 < 10 THEN 1
        WHEN bin = '[10-15>' and duration/60 >= 10 and duration/60 < 15 THEN 1
        WHEN bin = '15 or more ' and duration/60 >= 15 THEN 1
        ELSE 0 END) total
FROM CTE c JOIN Sessions s
GROUP BY 1

