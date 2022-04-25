-- https://leetcode.com/problems/grand-slam-titles/

SELECT
    player_id,
    player_name,
    SUM(IF(Wimbledon=player_id, 1, 0) + IF(Fr_open=player_id, 1, 0) + IF(US_open=player_id, 1, 0) + IF(Au_open=player_id, 1, 0)) grand_slams_count
FROM Players p, Championships c
GROUP BY player_id
HAVING grand_slams_count > 0

-- Another solution

select p.player_id,p.player_name, 
sum(p.player_id=c.wimbledon)+sum(p.player_id=c.fr_open)+sum(p.player_id=c.us_open)+sum(p.player_id=c.au_open) as grand_slams_count
from Players p
inner join Championships c
on p.player_id=c.wimbledon  or p.player_id=c.fr_open or p.player_id=c.us_open or p.player_id=c.au_open
group by player_id; 

-- Another solution

with cte as (
select wimbledon as id from championships
union all
select fr_open as id from championships
union all
select us_open as id from championships
union all
select au_open as id from championships
)
select p.player_id,p.player_name, count(*) as grand_slams_count
from Players p inner join cte on
p.player_id=cte.id
group by p.player_id;