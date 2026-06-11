/*select 문자 연습하기
 * call_chicken.csv 데이터 분석
 * 1. github에 있는 CSV 파일을 다운로드.
     csv(comm-sparated values)파일: 테이블처럼 값들이 행과 열로 배치된 텍스트 파일. 값들은 쉼표로 구분된 파일.
     어떤 os에서도 단순 텍스트 파일은 열어서 편집가능하기 때문에, 데이터를 공유할 때 많이 사용하는 형식.
 * 2. CSV 파일 내용을 저장할 수 있는 테이블 생성
 *    테이블 이름(call_chicken), 컬럼 이름(call_date, call_day, gu, ages, gender, calls)
 * 3. CSV 파일 데이터를 테이블로 임포트(import)
 * 4. 분석:
 *    (1) 통화 건수의 최댓값, 최솟값
 *    (2) 통화 건수가 최댓값이거나 최솟값인 레코드 출력
 *    (3) 통화 요일별 통화 건수의 평균
 *    (4) 연령대별 통화 건수의 평균
 *    (5) 통화 요일별 연령대별 통화 건수의 평균
 *    (6) 구별 성별 통화 건수의 평균
 *    (7) 요일별 구별 연령대별 통화 건수의 평균
 */
 
 --2. 테이블 생성
 create table call_chicken (
        call_date       date, --정수, 문자열보다는 날짜타입이 더 적절함.
        call_day        varchar2(10 char), --char(1) 고정길이, varchar2 가변길이,
        gu               varchar2(10 char),
        ages             varchar2(10 char),
        gender         varchar2(10 char),
        calls             number(4)
        );
        
-- 3. 생성된 테이블에 데이터 임포트( import, 불러오기)
-- [ 접속 ] 페널> call_chicken 테이블 오른쪽 클릭 > 데이터임포트

select * from call_chicken;
--통화 건수의 최댓값, 최솟값
select max(calls), min(calls) from call_chicken;

--통화 건수가 최댓값이거나 최솟값인 레코드 출력
select * from call_chicken
where  calls=(select max(calls) from call_chicken) or 
            calls =(select min(calls) from call_chicken);

--통화 요일별 통화 건수의 평균
select call_day, round(avg(calls),1) from call_chicken
group by call_day;

--연령대별 통화 건수의 평균
select ages ,round(avg(calls),1) from call_chicken
group by ages;

--통화 요일별 연령대별 통화 건수의 평균
select call_day, ages ,round(avg(calls),1) from call_chicken
group by call_day, ages;

--구별 성별 통화 건수의 평균
select gu, gender, round(avg(calls),1) from call_chicken
group by gu, gender;

--요일별 구별 연령대별 통화 건수의 평균
select call_day,gu, ages, round(avg(calls),1) from call_chicken
group by call_day, gu, ages;
