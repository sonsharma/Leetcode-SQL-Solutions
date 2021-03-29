# https://leetcode.com/problems/reformat-department-table/
SELECT     id,
        max(Jan_Revenue) as Jan_Revenue,
        max(Feb_Revenue) as Feb_Revenue,      
        max(Mar_Revenue) as Mar_Revenue,
        max(Apr_Revenue) as Apr_Revenue,
        max(May_Revenue) as May_Revenue,
        max(Jun_Revenue) as Jun_Revenue,
        max(Jul_Revenue) as Jul_Revenue,
        max(Aug_Revenue) as Aug_Revenue,
        max(Sep_Revenue) as Sep_Revenue,
        max(Oct_Revenue) as Oct_Revenue,
        max(Nov_Revenue) as Nov_Revenue,
        max(Dec_Revenue) as Dec_Revenue
FROM (SELECT
    id,
        CASE when month = 'Jan' then revenue end as Jan_Revenue,
        CASE when month = 'Feb' then revenue end as Feb_Revenue,      
        CASE when month = 'Mar' then revenue end as Mar_Revenue,
        CASE when month = 'Apr' then revenue end as Apr_Revenue,
        CASE when month = 'May' then revenue end as May_Revenue,
        CASE when month = 'Jun' then revenue end as Jun_Revenue,
        CASE when month = 'Jul' then revenue end as Jul_Revenue,
        CASE when month = 'Aug' then revenue end as Aug_Revenue,
        CASE when month = 'Sep' then revenue end as Sep_Revenue,
        CASE when month = 'Oct' then revenue end as Oct_Revenue,
        CASE when month = 'Nov' then revenue end as Nov_Revenue,
        CASE when month = 'Dec' then revenue end as Dec_Revenue
FROM
    Department
ORDER BY id)f
GROUP by id

# Another solution
SELECT 
    id,
    SUM(IF(month ='Jan', revenue, null)) as Jan_Revenue,
    SUM(IF(month ='Feb', revenue, null)) as Feb_Revenue,
    SUM(IF(month ='Mar', revenue, null)) as Mar_Revenue,
    SUM(IF(month ='Apr', revenue, null)) as Apr_Revenue,
    SUM(IF(month ='May', revenue, null)) as May_Revenue,
    SUM(IF(month ='Jun', revenue, null)) as Jun_Revenue,
    SUM(IF(month ='Jul', revenue, null)) as Jul_Revenue,
    SUM(IF(month ='Aug', revenue, null)) as Aug_Revenue,
    SUM(IF(month ='Sep', revenue, null)) as Sep_Revenue,
    SUM(IF(month ='Oct', revenue, null)) as Oct_Revenue,
    SUM(IF(month ='Nov', revenue, null)) as Nov_Revenue,
    SUM(IF(month ='Dec', revenue, null)) as Dec_Revenue
FROM Department
GROUP BY id

