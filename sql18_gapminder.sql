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
 * 1. 테이블에는 모두 몇 개의 나라가 있을까요?
 select distinct country from gapminder;
  select distinct count(country) from gapminder;

 * 2. 테이블에는 모두 몇 개의 대륙이 있을까요?
  select distinct continent from gapminder;
  select distinct count(continent) from gapminder;
 * 3. 테이블에는 저장된 데이터는 몇년도부터 몇년도까지 조사한 내용일까요?
 select distinct year from gapminder
 where year= (select min(year)from gapminder) or year=(select max(year) from gapminder);
 
 
 * 4. 기대 수명이 최댓값인 레코드(row)를 찾으세요.
 select * from gapminder
 where life_exp=
(select max(life_exp) from gapminder);
 
 * 5. 인구가 최댓값인 레코드(row)를 찾으세요.
 where pop=
(select max(pop) from gapminder);

 * 6. 1인당 GDP가 최댓값인 레코드(row)를 찾으세요.
 select * from gapminder
 where gdp_percap=
(select max( gdp_percap) from gapminder);
 
 * 7. 우리나라의 통계 자료만 출력하세요.
 select * from gapminder
 where country like '%Korea%';
 
 * 8. 연도별 1인당 GDP의 최댓값인 레코드를 찾으세요.
 select year, gdp_percap from gapminder
 where gdp_percap=
(select max( gdp_percap) from gapminder)
group by year;
 
  select year,max(gdp_percap) from gapminder
 group by year;
 
 * 9. 대륙별 1인당 GDP의 최댓값인 레코드를 찾으세요.
 select continent, max(gdp_percap) from gapminder
 group by continent;
 * 10. 연도별, 대륙별 인구수를 출력하세요.
 select continent,to_char(year,'YYYY'), pop from gapminder
 group by to_char(year,'YYYY'), continent;
 
 *     인구수가 가장 많은 연도와 대륙은 어디인가요?
select continent,to_char(year,'YYYY'), pop from gapminder
where pop= (select max(pop) from gapminder);
 
 * 11. 연도별, 대륙별 기대 수명의 평균을 출력하세요.
 select to_char(year,'YYYY'), continent, round(avg(life_exp),1) from gapminder
group by year, continent;

*     기대 수명이 가장 긴 연도와 대륙은 어디인가요?
select to_char(year,'YYYY'), continent from gapminder
where life_exp=(select max(life_exp) from gapminder);

 * 12. 연도별, 대륙별 1인당 GDP의 평균을 출력하세요.
 select to_char(year,'YYYY'), continent, round(avg(gdp_percap),1) from gapminder
 group by to_char(year,'YYYY'), continent;

 *     1인당 GDP의 평균이 가장 큰 연도와 대륙은 어디인가요?
 select to_char(year,'YYYY'), continent, round(avg(gdp_percap),1) as "gdp" from gapminder
 where gdp_percap = (select max(gdp_percap) from gapminder);
 
 * 13. 10번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
 * 14. 11번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
 * 15. 12번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
 */