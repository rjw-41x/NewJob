WITH gen_rank as (
select cm.title, genre.mg.id as g_id, genre.mg.name as g_name from commons.movies cm CROSS JOIN unnest( genres as mg ) as genre where substr( cm.release_date, 1, 4 ) = :inYear )
,
gen_count as ( select count(1) as g_count, g_name from gen_rank group by 2 order by 1 DESC LIMIT 10)
select row_number() over() as g_rank, g_name, g_count from gen_count order by 3 DESC;
