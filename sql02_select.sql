/*
* alt+f5 새파일
* 기본적인 질의(query) 문법: 테이블에서 데이터를 검색.
* (문법) select 검색하고 싶은 컬럼이름, 컬럼이름, 컬럼이름 from 테이블 이름;  
* dual 테이블에서 검색하는 기능이 아니라 더미 가상의 테이블이름
* 테이블의 모든 컬럼을 검색: select * from 테이블 이름;
*/

-- 직원테이블(emp)에서 사번(empno)과 직원이름(ename)
select empno, ename from emp;

-- 직원 테이블에서 모든 컬럼을 검색
select * from emp; --컬럼 순서를 지정할 수 없음

select empno, ename, job, mgr, hiredate, sal, comm, deptno 
from emp; --출력된 열을 내가 선택할 수 있음
--> 출력되는 컬럼의 순서는 테이블을 생성할 때의 컬럼 순서 그대로.

--> 출력되는 컬럼의 순서를 원하는대로 바꾸고 싶을때 
select empno, ename, job, sal, comm, hiredate, mgr, deptno
from emp;

-- 컬럼 이름에 별명(alias) 설정
-- (문법) select 컬럼 이름 as "별명" from 테이블이름;
-- (문법) select 컬럼 이름 별명 from 테이블이름;
-- as 키워드는 생략가능.
-- 별명에는 작은따옴표('')는 사용할 수 없음!
-- 별명을 감싸는 큰따옴표("")는 생략할 수 있음
-- 별명중간에 공백이 있는 경우 큰따옴표를 생략할 수 없음.
-- 별명 이름에 대소문자를 구분하고 싶을 때 큰 따옴표를 써야 함.

select empno "ename" from emp; --별명을 준 문법때문에 이렇게 뜸

-- 직원 테이블에서 사번과 직원이름을 검색
select empno as 사번, ename as 직원이름 
from emp;
 
-- 부서 테이블(dept)에서 부서번호, 부서이름, 위치
select 
    deptno as 부서번호,
    dname as 부서이름,
    loc as 위치
from dept;

-- 연결 연산자 (||) 파이프연산자라고 부름: 2개 이상의 컬럼(또는 문자열) 값들을 합쳐서 하나의 문자열로 만들어줌.
-- 직원 테이블에서 직원의 이름과 급여를 검색.
-- 'smith는 급여는 800입니다' 형식으로 출력.
select
    ename|| '의 급여는 ' ||sal ||'입니다.' as 직원급여
from emp;

-- 부서테이블에서 부서번호와 이름을 '10 - 부서이름'
select 
    deptno|| '- ' ||dname as "부서번호와 이름"
from dept;

-- 검색결과를 정렬해서 출력하기
--(문법) select 컬럼이름,...  frome 테이블이름 order by 정렬기준컬럼 [asc/desc],...
-- asc: 오름차순(ascending order). 정렬의 기본은 오름차순이라 생략가능.
-- desc: 내림차순(descenging order). 생략불가

--직원 이름을 알파벳 순서대로 출력
select ename from emp
order by ename; -->asc 생략가능

select ename from emp
order by ename desc;


-- 직원 테이블에서 부서 번호와 직원이름을 검색.
-- 출력순서:(1) 부서번호 오름차순, (2) 직원이름 오름차순.
select deptno, ename from emp
order by deptno,ename;

--직원 테이블에서 부서번호, 직원이름, 입사일을 검색.
--정렬순서:(1) 부서번호,(2) 입사일
select deptno,ename,hiredate
from emp
order by deptno,hiredate;

-- 직원 테이블에서 업무,직원이름,급여를 검색.
-- 정렬순서:(1)업무,(2)급여 내림차순
select job, ename, sal 
from emp
order by job, sal desc;

-- 중복되는 데이터 제거하고 출력하는 방법.
--(문법) select distinct 컬럼이름 from 테이블이름 [order by]

-- 직원 테이블에서 부서번호를 검색
select deptno from emp; --> 결과14행 
select distinct deptno from emp; --> 결과3행
select distinct deptno from emp order by deptno;

--중복되지 않는 부서 번호와 업무를 검색.
select deptno, job from emp;  --> 결과14행 
select distinct deptno, job from emp; -->결과9행
select distinct deptno, job from emp order by deptno,job;

--(주의) select distinct 구문에서 distinct는 단 한번만 사용해야함.
--select distinct deptno, distinct job from emp; -->에러 발생



