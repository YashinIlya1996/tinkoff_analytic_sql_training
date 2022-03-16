select
	name
	, city_nm
	, avg_game_time
from
(
select
	g.employee_rk
	, first_name || ' ' || last_name as name
	, city_nm
	, avg(time) as avg_game_time
	, e.gender_cd
	, row_number() over (partition by city_nm order by avg(time)) as num
from
	cource_analytics.game as g
left join cource_analytics.quest as q
	on g.quest_rk = q.quest_rk
left join cource_analytics."location" as l
	on q.location_rk = l.location_rk
left join cource_analytics.employee as e
	on g.employee_rk = e.employee_rk
group by 1, 2, 3, 5
order by 3, 4
) a
where
	gender_cd = 'f'
	and num = 2
	