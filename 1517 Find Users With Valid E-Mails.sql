# https://leetcode.com/problems/find-users-with-valid-e-mails/submissions/

SELECT
    *
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9-_.]*@leetcode\.com'
