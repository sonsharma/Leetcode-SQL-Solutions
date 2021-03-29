# https://leetcode.com/problems/leetflex-banned-accounts/submissions/

SELECT
    DISTINCT l1.account_id
FROM LogInfo l1 JOIN LogInfo l2
ON l1.account_id = l2.account_id and l1.ip_address <> l2.ip_address and l1.login between l2.login and l2.logout