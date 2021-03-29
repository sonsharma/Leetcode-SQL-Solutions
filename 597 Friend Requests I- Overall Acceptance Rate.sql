# https://leetcode.com/problems/friend-requests-i-overall-acceptance-rate/

SELECT

    ifnull(round(count(DISTINCT requester_id, accepter_id)/count(DISTINCT sender_id, send_to_id),2),0.00) as accept_rate
FROM
    FriendRequest f, RequestAccepted r
;

#Another solution
SELECT
    COALESCE(ROUND(COUNT(DISTINCT CONCAT(requester_id, accepter_id))/COUNT(DISTINCT CONCAT(sender_id, send_to_id)) ,2), 0) as accept_rate
FROM FriendRequest f, RequestAccepted r

