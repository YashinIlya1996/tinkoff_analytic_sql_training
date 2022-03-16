select 
	count(distinct par.partner_rk) as creative_cnt
from 
	cource_analytics.partner par
left join 
	cource_analytics."location" as loc
on 
	par.partner_rk = loc.partner_rk
left join
	cource_analytics.legend as l
on 
	par.partner_rk = l.partner_rk
where 
	loc.location_rk is null
	and not l.legend_rk is null;

