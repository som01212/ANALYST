/*
*조건검색 -where구문
*조건을 만족하는 행(row)들을 검색하는 방법.
*(문법) select 컬럼이름,...from 테이블이름 where조건식[order by] ;
*
* 조건식에서 사용되는 연산자들:
* (1) 비교연산자: =,!=,>,>=,<,<=,is null, is not null,...
* (2) 논리연산자: and, or, not
*/

-- 10번 부서에서 근무하는 직원들의 사번, 이름, 부서번호, 급여 출력.
select empno, ename, deptno, sal 
from emp 
where deptno=10;

-- 10번 부서가 아닌 근무하는 직원들의 사번, 이름, 부서번호, 급여 출력.
select empno, ename, deptno, sal 
from emp 
where deptno != 10;

-- 수당(comm)이 null이 아닌 직원들의 모든 정보를 출력.
select * from emp
where comm is not null;

-- 수당(comm)이 null인 직원들의 모든 정보를 출력.
select * from emp
where comm is null;

-- (주의) null인 지 아닌 지를 비교할 때는 =, !=연산자를 사용하면 안됨!!
-- 반드시 is null 또는 is not null 키워드를 사용해야함!!
select * from emp
where comm = null; --> 0개 행(row)가 선택.
select * from emp 
where comm != null; --> 0개 행(row)가 선택.

-- 수당이 null이 아닌 직원들의 부서번호, 사번, 이름, 급여, 수당을 검색.
-- 정렬순서 (1) 부서번호, (2) 사번
select deptno,empno,ename,sal,comm from emp
where comm is not null
order by deptno, empno;

-- 급여가 2000 이상인 직원들의 이름, 업무, 급여 출력.
-- 정렬순서 (1) 급여 내림차순 (2) 이름 
select ename,job,sal from emp
where sal >=2000
order by sal desc, ename;

-- 급여가 2000이상이고 3000이하인 직원들의 이름, 업무, 급여를 출력.
-- 정렬순서: 급여 내림차순
select ename, job, sal from emp
where sal >=2000 and sal <= 3000  
order by sal desc;

--select ename, job, sal from emp
--where 2000 <= sal <=3000 --> sql 문법적으로 에러남
--order by sal desc;

-- between A and B 연산자 : 컬럼이름 between 값1 and 값2
 select ename, job, sal
 from emp 
 where sal between 2000 and 3000
 order by sal desc;
 
 -- 수당은 null이 아니고, 급여는 1500 미만인 직원들의 모든 정보를 출력
 select * from emp
 where comm is not null and sal < 1500;
 
 -- 10번 또는 20 번 부서에서 근무하는 직원들의 부서번호, 이름, 급여를 출력.
 -- 정렬 (1) 부서번호 (2) 급여 내림차순
 select  deptno, ename, sal 
 from emp
 where deptno =10 or deptno= 20
 order by deptno, sal desc;
 
  select deptno, ename, sal
 from emp 
 where deptno in (10,20)
 order by deptno, sal desc;
 
 -- 업무가 'CLERK' 인 직원들의 이름, 업무, 급여. 이름순으로 출력
 select ename, job, sal from emp
 where job='CLERK' --  컬럼이름은 작은따옴표를 써야함. 문자열 비교는 테이블에 있는 값에 있는 문자열대로. 구분해서.
 order by ename;
 --> SQL식별자(예약어, 테이블이름, 칼럼 이름, 등)를 제외한 문자열은 작은따옴표('') 를 사용함. 큰 따옴표("")는 별명만.
 --> 컬럼에 저장된 문자열의 비교에서는 대/소문자를 구별.
 
 -- 업무가 'CLERK' 또는 'MANAGER'인 직원들의 이름, 업무, 급여를 출력.
 -- 정렬 (1) 업무, (2) 급여
 select ename, job, sal from emp
 where job = 'CLERK' or job= 'MANAGER'
 order by job,sal;
 
 select ename, job, sal from emp
 where job in ( 'CLERK','MANAGER')
 order by job, sal;
 
 -- 업무가 영업사원, 관리자, 분석가 인 직원들의 모든 정보를 출력.
 select * from emp
 where job = 'SALESMAN' or job= 'ANALYST' or job= 'MANAGER';
 
 select * from emp
 where job in ('SALESMAN','ANALYST','MANAGER');
 
 --20번 부서에서 근무하는 'clerk'의 모든 레코드(모든컬럼)를 출력.
 select * from emp
 where deptno=20 and job ='CLERK' ;
 
 --clerk, analyst, manager 가 아닌 직원들의 사번, 이름, 업무, 급여를 사번순 출력.
 select empno, ename, job, sal from emp
 where job != 'CLERK' and job!= 'ANALYST'and job !='MANAGER'
 order by empno;
 
 select empno, ename, job, sal from emp
 where job not in ('CLERK','ANALYST','MANAGER')
 order by empno;
 
 --like 검색: 특정 문자열이 포함된 값들을 찾는 검색 방법. 
 --like 검색에서 사용하는 wildcard(특수문자)
 --(1) %: 글자수 상관없이 어떤 문자열이어도 상관없음.
 --(2) _: 밑줄(underscore)이 있는 위치에 한 글자가 어떤 문자이더라도 상관없음.
 
 select * from emp where job like 'C%'; 
 --> job(업무)가 'C'로 시작하는 ~
  
 select * from emp where job like 'C_';
--> job이 ca,cb,cc,...이런 패턴 2글자를 찾겠다~

select * from emp where job like '%R';

-- job이 'A'를 포함하는
select * from emp where job like '%A%';

 -- 직원이름이 A로 시작하는 직원들의 모든 컬럼.
 select * from emp
 where ename like 'A%';
 
  -- 직원이름에 A가 포함되는 직원들의 모든 컬럼.
  select * from emp
  where ename like'%A%';

 -- % vs _
 select * from emp where ename like 'KING%';
 select * from emp where ename like 'KING_';
 
 -- 날짜 타입의 크기 비교: 과거 < 현재 < 미래
 -- 1982/01/01 이후에 입사한 직원들의 모든 레코드의 정보.
 select * from emp
 where hiredate > '1982/01/01'; --hiredate는 날짜타입이고, '1982/01/01'이것은 문자열이라 위험한
 -->오라클 hiredate 칼럼값들을 문자열로 변환한 후 '1982/01/01' 문자열과 크기비교.

select * from emp
where hiredate > '82/01/01';
--> 위의 SQL 문장의 실행결과는 
-- 도구 > 환경설정 > 데이터베이스 > NLS > 날짜형식설정에 따라 다른 결과를 줌.
-- 날짜 형식이 'RR/MM/DD'로 설정된 경우에는 3개의 행이 검색 됨.
-- 날짜 형식이 'YYYY/MM/DD'로 설정된 경우에는 14개의 행이 검색 됨.

--1981~ 1982년에 입사한 직원들.
select * from emp
where hiredate >='1981/01/01' and hiredate <='1982/12/31';

select * from emp
where hiredate between '1981/01/01' and '1982/12/31';   



  
 