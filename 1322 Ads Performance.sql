# https://leetcode.com/problems/ads-performance/

SELECT
    ad_id, 
    ifnull(round(sum(if(action = 'Clicked', 1, 0))*100/(sum(if(action = 'Clicked', 1, 0)) + sum( if(action = 'Viewed', 1, 0))),2),0) as ctr 
FROM
    Ads
GROUP BY ad_id
ORDER BY ctr desc, ad_id asc