/*
* OECD 국가 연평균 근로 시간
 * github에 있는 연평균_근로시간_OECD.xlsx 파일의 테이블을 데이터베이스에 저장, 분석.
 1. 우리나라(한국)의 연평균 근로시간을 출력하세요.
 2. 2018년에 한국의 평균 근로시간보다 근로시간이 더 긴 국가들을 찾아보세요.
 3. 2018년의 평균 근로시간 상위 5개 국가들을 찾아보세요.
 4. 가장 긴 근로시간은 몇 년도의 어느 나라인 지 찾아보세요.
 5. 각각의 연도에서 평균 근로시간이 가장 많은 나라들을 찾아보세요.
 */
 
 create table working (
        country      varchar2(20 char), 
        "2014"     number(5),
        "2015"     number(5),
        "2016"     number(5),
        "2017"     number(5),
        "2018"     number(5)
        );
        
select * from working;
-- 우리나라(한국)의 연평균 근로시간을 출력하세요.
select country,avg(2014,2015) from working

SELECT 
    country, 
    ("2014" + "2015") FROM working;

select 
 ("2014"+"2015"+"2016"+"2017"+"2018")/5 from working
 where country like '%한국%';
 
 --2018년에 한국의 평균 근로시간보다 근로시간이 더 많은 국가들을 찾아보세요.
select 
 country from working
where "2018" > ( select "2018" from working where country like '%한국%');

--2018년의 평균 근로시간 상위 5개 국가들을 찾아보세요.
select country,rank()over (order by "2018") from working 
offset 0 rows
fetch next 5 rows only;

--각각의 연도에서 평균 근로시간이 가장 많은 나라들을 찾아보세요.
select * from working;


select country, 
        rank() over( order by "2014" desc),
        rank() over( order by "2015" desc),
        rank() over( order by "2016" desc), 
        rank()over( order by "2017" desc ),
        rank() over( order by "2018" desc) from working;

-- 가장 긴 근로시간은 몇 년도의 어느 나라인 지 찾아보세요.
select  * from (select max("2014") from working),
                    (select max("2015") from working),
                    (select max("2016") from working),
                    (select max("2017") from working),
                    (select max("2018") from working);
                    where country;

with t as (
select  * from (select max("2014") from working),
                    (select max("2015") from working),
                    (select max("2016") from working),
                    (select max("2017") from working) as "y17",
                    (select max("2018") from working) as "y_18";
)
select t.country
from t
where t.y17 = 2148 and t.y18=2148;

 
