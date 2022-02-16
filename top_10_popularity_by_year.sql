SELECT DATE('yyyy', release_date) from commons.movies;
with movie_list as ( select title, popularity from commons.movies where order by 2 DESC limit 10 )
select row_number() over(), title, popularity from movie_list order by 3 DESC

Rank | Title | Popularity


final version
with movie_list as ( select title, popularity from commons.movies where substr( release_date, 1, 4 ) = '2006' order by 2 DESC limit 10 )
select row_number() over() as title_rank, title, popularity from movie_list order by 3 DESC
