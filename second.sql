select 
	quest_nm
from
(
select
	a.quest_rk as quest_rk
	, in_jan_flg1
	, in_feb_flg1
	, in_jan_all
	, in_feb_all
	, cast(in_jan_flg1 as double precision) / cast(in_jan_all as double precision) as jan_part
	, cast(in_feb_flg1 as double precision) / cast(in_feb_all as double precision) as feb_part
	, abs(cast(in_jan_flg1 as double precision) / cast(in_jan_all as double precision) - cast(in_feb_flg1 as double precision) / cast(in_feb_all as double precision)) as delta
from
(
select
	quest_rk
	, count(*) as in_jan_flg1
from 
	cource_analytics.game as g
where
	g.game_flg = 1
	and extract(month from g.game_dttm) = 1
group by
	1
) a
left join
(
select
	quest_rk
	, count(*) as in_feb_flg1
from 
	cource_analytics.game as g
where
	g.game_flg = 1
	and extract(month from g.game_dttm) = 2
group by
	1
) b
on a.quest_rk = b.quest_rk
left join
(
select
	quest_rk
	, count(*) as in_jan_all
from 
	cource_analytics.game as g
where
	extract(month from g.game_dttm) = 1
group by
	1
) c
on a.quest_rk = c.quest_rk
left join
(
select
	quest_rk
	, count(*) as in_feb_all
from 
	cource_analytics.game as g
where
	extract(month from g.game_dttm) = 2
group by
	1
) d
on a.quest_rk = d.quest_rk
order by 
	delta desc
	, quest_rk
limit 1
) e
left join
	cource_analytics.quest as f
on e.quest_rk = f.quest_rk;
	
	
	