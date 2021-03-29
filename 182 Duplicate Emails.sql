# https://leetcode.com/problems/duplicate-emails/

SELECT
    Email
FROM
    Person
GROUP BY Email
HAVING count(*) > 1;

