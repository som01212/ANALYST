/*
 * OECD 국가 연평균 근로 시간
 * github에 있는 연평균_근로시간_OECD.xlsx 파일의 테이블을 데이터베이스에 저장, 분석.
 1. 우리나라(한국)의 연평균 근로시간을 출력하세요.
 2. 2018년에 한국의 평균 근로시간보다 근로시간이 더 긴 국가들을 찾아보세요.
 3. 2018년의 평균 근로시간 상위 5개 국가들을 찾아보세요.
 4. 가장 긴 근로시간은 몇 년도의 어느 나라인 지 찾아보세요.
 5. 각각의 연도에서 평균 근로시간이 가장 많은 나라들을 찾아보세요.
 */

create table oecd_worktime (
    country varchar2(50 char),
    y_2014 number(4),
    y_2015 number(4),
    y_2016 number(4),
    y_2017 number(4),
    y_2018 number(4)
);

update oecd_worktime
set country = replace(country, ' ', '');

update oecd_worktime
set country=substr(country,4);

commit;

-- 나라별, 연도별 근로시간
select 
*
from oecd_worktime
;

select dump(country) from oecd_worktime;

select
y_2014
from oecd_worktime
where country='한국';

select
    '[' || country || ']'
from oecd_worktime;

select
length(country)
from oecd_worktime;

-- 1. 우리나라(한국)의 연평균 근로시간을 출력하세요.
select
*
from oecd_worktime
where country='한국'
;

select
y_2018
from oecd_worktime
where country='한국'
;

-- 2. 2018년에 한국의 평균 근로시간보다 근로시간이 더 긴 국가들을 찾아보세요.
select
country
from oecd_worktime
where y_2018 > (
    select
        y_2018
    from oecd_worktime
    where country='한국'
    )
;



-- 3. 2018년의 평균 근로시간 상위 5개 국가들을 찾아보세요.
--select
--    country,
--    y_2018
--from oecd_worktime
--order by y_2018 desc;

--select
--    country,
--    y_2018
--from(
--        select
--            country,
--            y_2018
--        from oecd_worktime
--        order by y_2018 desc;
--)
--where

with t as (
        select
            country,
            y_2018
        from oecd_worktime
        order by y_2018 desc
)
select t.country, t.y_2018
from t
fetch first 5 rows only;



-- 4. 가장 긴 근로시간은 몇 년도의 어느 나라인 지 찾아보세요.
--select *
--from oecd_worktime
--unpivot (
--    worktime
--    for year in (
--        y_2014 as 2014,
--        y_2015 as 2015,
--        y_2016 as 2016,
--        y_2017 as 2017,
--        y_2018 as 2018
--    )
--);

with t as (
    select *
    from oecd_worktime
    unpivot (
        worktime
        for year in (
            y_2014 as 2014,
            y_2015 as 2015,
            y_2016 as 2016,
            y_2017 as 2017,
            y_2018 as 2018
        )
    )
)
select *
from t
where worktime=(
    select max(worktime)
    from t
)
;


-- 5. 각각의 연도에서 평균 근로시간이 가장 많은 나라들을 찾아보세요.
with t as (
    select *
    from oecd_worktime
    unpivot (
        worktime
        for year in (
            y_2014 as 2014,
            y_2015 as 2015,
            y_2016 as 2016,
            y_2017 as 2017,
            y_2018 as 2018
        )
    )
)
select
    year,
    country,
    worktime
from (
    select
        year,
        country,
        worktime,
        rank() over ( partition by year order by worktime desc) as "RANKING"
    from t
)


where RANKING = 1
;
    
