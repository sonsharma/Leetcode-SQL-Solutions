# https://leetcode.com/problems/invalid-tweets/

SELECT tweet_id
FROM Tweets
WHERE length(content) > 15