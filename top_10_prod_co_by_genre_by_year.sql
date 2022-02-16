WITH gen_rank as (
select cm.title, genre.mg.id as g_id, genre.mg.name as g_name from commons.movies cm CROSS JOIN unnest( genres as mg ) as genre where substr( cm.release_date, 1, 4 ) = :inYear )
,
gen_count as ( select count(1) as g_count, g_name from gen_rank group by 2 order by 1 DESC LIMIT 10)


, prod_co as (
select cm.title, (select g_name from gen_count limit 1) as g_name, pc.pct.name as pc_name from commons.movies cm CROSS JOIN unnest( cm.genres as mg ) as genre CROSS JOIN UNNEST ( cm.production_companies as pct ) as pc where substr( cm.release_date, 1, 4 ) = :inYear and genre.mg.name = (select g_name from gen_count limit 1))
, prod_cnt as (
SELECT g_name, pc_name, count(1) as g_pc_count from prod_co group by 1, 2 order by 3 desc limit 10
)
select ROW_NUMBER() OVER() as Rank_, pc_name as Production_Company, g_name as Genre, g_pc_count as Total from prod_cnt;
