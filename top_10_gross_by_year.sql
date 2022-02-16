SELECT DATE('yyyy', release_date) from commons.movies;
with movie_list as ( select title, popularity from commons.movies where order by 2 DESC limit 10 )
select row_number() over(), title, popularity from movie_list order by 3 DESC

Rank | Title | Revenue | % of Revenue
with movie_rev as ( select :inYear, sum(revenue) as tot_rev from commons.movies where substr( release_date, 1, 4 ) = :inYear group by 1),
movie_list as ( select title, revenue, r.tot_rev as total from commons.movies, movie_rev as r where substr( release_date, 1, 4 ) = :inYear order by 2 DESC limit 10 )
select row_number() over() as title_rank, title, revenue, (revenue/total::float)*100::float(2,2) as pct_rev  from movie_list order by 3 DESC;
