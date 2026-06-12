/*
 * github의 gapminder.tsv 파일 다운로드, 테이블에 데이터 임포트.
 * TSV(tab-separated values): 값들이 탭으로 구분된 텍스트 파일. csv 파일의 일종.
 * 테이블 이름: gapminder
 * 컬럼 이름: country, continent, year, life_exp(기대수명), pop(인구수), gdp_percap(1인당 GDP)
 */
 create table gapminder(
            country varchar2(100 char),
            continent varchar2(100 char),
            year        date,
            life_exp    number(5,5),
            pop         number(15,10),
            gdp_percap          number(15,10)
            );
 
 CREATE TABLE gapminder (
    country      VARCHAR2(100 CHAR),
    continent    VARCHAR2(100 CHAR),
    year         DATE,
    life_exp     NUMBER,
    pop          NUMBER,
    gdp_percap   NUMBER
);
 drop table gapminder;

select * from gapminder;
-- 테이블의 전체 행의 개수 1704
select count(country) from gapminder;
select count(*), count(mgr) from emp; --null값 비교

select count(country), count(continent), count(year), count(life_exp), count(pop), count(gdp_percap) from gapminder;
--> null이 없음.

select * from gapminder
order by country, year
offset 0 rows
fetch next 20 rows only;

-- 연속형 변수 vs 범주(카테고리)형 범주
-- 연속형 변수 - 숫자( 정수 또는 실수). (예) 연도, 기대수명, 인구수, 1인당 GDP, ...
-- 연속형 변수의 통계량 - 최댓값, 최솟값, 합계, 평균, 분산, 표준편차, 중앙값(중위값), ...
-- 범주형 변수 - 문자열, 정수 (예) 국가이름, 대륙이름, 연도, ...
-- 범주형 변수의 통계량 - 개수(빈도수) 

 * 1. 테이블에는 모두 몇 개의 나라가 있을까요?
 select distinct country from gapminder;
  select  count(distinct country) from gapminder;

 * 2. 테이블에는 모두 몇 개의 대륙이 있을까요?
  select distinct continent from gapminder;
  select  count(distinct continent) from gapminder;
  
  select continent, count(*) from gapminder
  group by continent
  order by continent;
  
  -- 연속형 변수 기술 통계량(descriptive atstistics)
  -- 기대수명(life_exp) 기술 통계량
  select 
    round( avg(life_exp),2 ) as 평균,
    round(variance(life_exp),2) as 분산,
    round(stddev(life_exp), 2 )as 표준편차,
    max(life_exp) as 최댓값,
    min(life_exp) as 최솟값,
    median(life_exp) as 중앙값
from gapminder;
  
-- 인구 기술 통계량
  select 
    round( avg(pop),2 ) as 평균,
    round(variance(pop),2) as 분산,
    round(stddev(pop), 2 )as 표준편차,
    max(pop) as 최댓값,
    min(pop) as 최솟값,
    median(pop) as 중앙값
from gapminder;
  
  
  
  
 * 3. 테이블에는 저장된 데이터는 몇년도부터 몇년도까지 조사한 내용일까요?
 select distinct year from gapminder
 where year= (select min(year)from gapminder) or year=(select max(year) from gapminder);
 
 
 * 4. 기대 수명이 최댓값인 레코드(row)를 찾으세요.
 select * from gapminder
 where life_exp=
(select max(life_exp) from gapminder);
 
 * 5. 인구가 최댓값인 레코드(row)를 찾으세요.
  select * from gapminder
 where pop=
(select max(pop) from gapminder);

 * 6. 1인당 GDP가 최댓값인 레코드(row)를 찾으세요.
 select * from gapminder
 where gdp_percap=
(select max( gdp_percap) from gapminder);
 
 * 7. 우리나라의 통계 자료만 출력하세요.
 select * from gapminder
 where lower(country) like '%korea%'; --> 소문자 대문자인지 모르니깐 일단 통일해서 추출. 거기서 한국문자를 찾아냄
 
 select * from gapminder
 where country like '%Korea, Rep%';
 
 * 8. 연도별 1인당 GDP의 최댓값인 레코드를 찾으세요.

  select to_char(year,'YYYY'),max(gdp_percap) from gapminder
 group by year;
 
  select * from gapminder
 where gdp_percap in
(select max( gdp_percap) from gapminder group by year) order by year;


select * from gapminder
 where (year,gdp_percap) in
(select  year,max( gdp_percap) from gapminder group by year) order by year; -- where절의 서브쿼리의 select는 똑같이 사용되어야함 year,max( gdp_percap)
  -- 다중 행, 다중 컬럼 서브쿼리
  -- 연도와 gdp를 비교하는 것
 
 -- rank() 함수을 이용한 그룹별 최댓값 찾기
 select g.*, rank() over(partition by year order by gdp_percap desc) as RANKING
 from gapminder g;
 
 with t as ( 
  select g.*, rank() over(partition by year order by gdp_percap desc) as RANKING  
  from gapminder g)
select t.* from t where t.RANKING <=6;
/*/ where t.RANKING=1*/
 
 * 9. 대륙별 1인당 GDP의 최댓값인 레코드를 찾으세요.
 select *
 from gapminder where (continent, gdp_percap) in
 (select continent, max(gdp_percap) from gapminder
 group by continent);
 
 with t as(
 select g.*,
           rank() over(partition by continent order by gdp_percap desc) as RANKING
           from gapminder g
 ) select t.* from t where t.RANKING =1;
 
 * 10. 연도별, 대륙별 인구수를 출력하세요.
 select continent,to_char(year,'YYYY'), sum(pop) from gapminder
 group by year, continent;
 
  select to_char(year,'YYYY'), continent, sum(pop) from gapminder
 group by year, continent
 order by year, continent;
 
 -- piovt() 함수
 with t as(
    select year, continent, pop from gapminder 
    ) 
    select * from t
    pivot( 
        sum(pop) for continent in ('Africa' as AFRICA,
                                                'Americas' AS AMERICAS, 
                                                'Asia' AS ASIA,
                                                'Europe' AS EUROPE,
                                                'Oceania' AS OCEANIA) -- for 다음에 컬럼이름. 피벗의 컬럼이 될 값
    )
    order by year
    ;
 
 with t as(
    select to_char(year,'YYYY') as year, continent, pop from gapminder
    )
    select * from t
    pivot(
        sum(pop) for year in (1952, 1957, 1962,
                                          1967, 1972, 1977, 
                                          1982,1987, 1992,
                                          1997,2002, 2007 )
        );
 
 
 -- 연도별, 대륙별 인구수가 가장 많은 연도, 대륙, 그때의 인구수
 select 
    year, continent, sum(pop) as TOTAL_POP
    from gapminder
group by year, continent
order by TOTAL_POP desc;
 
 
  select 
    year, continent, sum(pop) as TOTAL_POP
    from gapminder
group by year, continent
order by TOTAL_POP desc
offset 0 rows
fetch next 1 rows only;
 
with t as ( 
    select year, continent, sum(pop) as TOTAL_POP
    from gapminder
    group by year, continent
    )
    select t.* from t where t.TOTAL_POP = (
    select max(t.TOTAL_POP) from t
    );
-- 인라인 뷰를 사용하는 장점....t절이 생기면....또 다른 서브쿼리에서도 사용가능하다~
 
 *     인구수가 가장 많은 연도와 대륙은 어디인가요?
select continent,to_char(year,'YYYY'), pop from gapminder
where pop= (select max(pop) from gapminder);
 
-- 11. 연도별, 대륙별 기대 수명의 평균을 출력하세요.
 select to_char(year,'YYYY'), continent, round(avg(life_exp),1) from gapminder
group by year, continent;
--문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
 with t as(
    select to_char(year,'YYYY') as year, continent, round(avg(life_exp),1) as avg_exp from gapminder group by year,continent
    ) 
    select * from t
    pivot( 
        (avg(avg_exp)) for continent in ('Africa' as AFRICA,
                                                'Americas' AS AMERICAS, 
                                                'Asia' AS ASIA,
                                                'Europe' AS EUROPE,
                                                'Oceania' AS OCEANIA) -- for 다음에 컬럼이름. 피벗의 컬럼이 될 값
    )
    order by year
    ;
    
   with t as(
    select to_char(year,'YYYY') as year, continent,life_exp  from gapminder 
    ) 
    select year,
            round(
    
    
    from t
    pivot( 
        avg(life_exp) for continent in ('Africa' as AFRICA,
                                                'Americas' AS AMERICAS, 
                                                'Asia' AS ASIA,
                                                'Europe' AS EUROPE,
                                                'Oceania' AS OCEANIA) -- for 다음에 컬럼이름. 피벗의 컬럼이 될 값
    )
    order by year
    ;  
    
 --PIVOT ( 집계함수(컬럼) FOR 피벗할_컬럼 IN (값) )
 --WITH 절을 쓰고 바깥에서 PIVOT이나 다른 연산을 할 때는, 
 --무조건 안쪽 가상 테이블이 완성해서 배달해 준 컬럼 이름(별칭)만 가지고 대화해야 한다는 철칙을 꼭 기억해 주세요!


*     기대 수명이 가장 긴 연도와 대륙은 어디인가요?
select to_char(year,'YYYY'), continent from gapminder
where life_exp=(select max(life_exp) from gapminder);

select year, continent, round(avg(life_exp),2) as avg_life
from gapminder
group by year, continent
order by avg_life desc
offset 0 rows
fetch next 1 rows only;

with t as(
select year, continent, avg(life_exp) as avg_life
from gapminder
group by year, continent
)
select t.* from t
where t.avg_life= 
(select max(t.avg_life) from t);

 * 12. 연도별, 대륙별 1인당 GDP의 평균을 출력하세요.
 select to_char(year,'YYYY'), continent, round(avg(gdp_percap),1)from gapminder 
 group by to_char(year,'YYYY'), continent;
 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
 with t  as(
  select to_char(year,'YYYY')as year, continent, round(avg(gdp_percap),1) as avg_gdp from gapminder group by to_char(year,'YYYY'), continent
)
    select * from t
    pivot( 
        avg(avg_gdp) for continent in ('Africa' as AFRICA,
                                                'Americas' AS AMERICAS, 
                                                'Asia' AS ASIA,
                                                'Europe' AS EUROPE,
                                                'Oceania' AS OCEANIA) -- for 다음에 컬럼이름. 피벗의 컬럼이 될 값
    )
    order by year
    ;
    
   WITH t AS (
  SELECT 
    TO_CHAR(year, 'YYYY') AS year, 
    continent, 
    -- 1. avg_gdp의 공백을 완전히 지웠습니다.
    ROUND(AVG(gdp_percap), 1) AS avg_gdp 
  FROM gapminder 
  GROUP BY TO_CHAR(year, 'YYYY'), continent
)
SELECT * FROM t
PIVOT ( 
    -- 2. 바깥쪽에서도 공백이 없는 정확한 별칭 이름을 사용합니다.
    AVG(avg_gdp) FOR continent IN ('Africa' AS AFRICA,
                                   'Americas' AS AMERICAS, 
                                   'Asia' AS ASIA,
                                   'Europe' AS EUROPE,
                                   'Oceania' AS OCEANIA)
)
ORDER BY year; 
 
 
 
 
 
 
 
 
 *     1인당 GDP의 평균이 가장 큰 연도와 대륙은 어디인가요?
 select to_char(year,'YYYY'), continent, round(avg(gdp_percap),1) from gapminder 
 where gdp_percap = (select max(avg(gdp_percap)) from gapminder group by year, continent) ;
 
 select year, continent, rank() over (order by avg(gdp_percap) desc) from gapminder group by year, continent;
 

  select year, continent, (
  select
  rank() over (order by avg(gdp_percap) desc) as ranking from gapminder where ranking=1 group by year, continent)
 from gapminder;
 
 
 select year, continent, (
  select
  rank() over (order by avg(gdp_percap) desc) as ranking from gapminder group by year, continent)
 where ranking =1
  ;
--> 셀렉트 서브쿼리에서는 where절이 우선으로 진행이되어서 윈도우 함수는 사용할수가 없음
-- 먼저랭킹1위가 어디에서 찾을 수 없으니깐.
-- 그래서 FROM절 서브쿼리를 사용해야함.

select year,continent from (select year, continent,
  rank() over (order by avg(gdp_percap) desc) as ranking from gapminder group by year, continent )t where t.ranking =1;
  
select rank() over (order by avg(gdp_percap) desc) as ranking from gapminder group by year, continent ;
--> 이 셀렉트 절을 바로 사용할 수 없는 이유는 결과값 랭킹열 하나임 그거를 두고year, continent는 못찾음. 
/* GROUP BY 절은 컴퓨터 내부의 계산 과정에서 그룹을 묶어줄 뿐, 
최종 결과 화면에 컬럼을 나타나게 하려면 반드시 SELECT 절에 이름을 직접 적어주어야 합니다.*/

with t as (select year, continent,
  rank() over (order by avg(gdp_percap) desc) as ranking from gapminder group by year, continent  )
  select t.* from t where  t.ranking =1;

 
 
 * 13. 10번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
 * 14. 11번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
 * 15. 12번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
 */