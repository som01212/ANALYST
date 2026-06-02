/*
* 서브쿼리(sub query): SQL문장의 일부로 다른 SQL문장이 포함되는 것. 
* (1) selet 절에서의 서브 쿼리
* (2) from 절에서의 서브 쿼리
* (3) having 절에서의 서브 쿼리
*
* (주의) 서브 쿼리는 () 안에 작성. 서브 쿼리에서는 세미콜론(;)을 쓰면 안됨.
*/

-- allen 의 급여보다 더 많은 급여를 받는 직원들은?
-- step(1) alle의 급여
select sal from emp where ename='ALLEN';
-- step(2) 급여가 1600보다 많은 직원들
select * from emp where sal>=1600;

select ename, sal
from emp
where sal>( select sal from emp where ename='ALLEN');

-- 전체 사원의 급여 평균보다 더 많은 급여를 받는 직원들?
-- step(1) 급여 평균
select avg(sal) from emp;
-- step(2) 평균보다 급여가 많은 직원
-- select * from emp where sal> (평균)
select * from emp where sal> 2201.6;
select * from emp 
where sal > (
select  avg(sal) from emp 
);

-- 1. allen보다 적은 급여를 받는 직원들의 사번, 이름, 급여를 출력.
---(1) allen의 급여 (2) 직원들의 사번, 이름, 급여. 
select ename, empno, sal from emp 
where sal <(select sal from emp where ename='ALLEN');

-- 2. allen과 같은 업무를 담당하는 직원들의 사번, 이름, 부서번호, 업무, 급여를 출력
-- (1) allen의 업무 (2) 직원들의~
select job from emp where ename='ALLEN';
select empno, ename, deptno, job, sal from emp where job=(
select job from emp where ename='ALLEN');

-- 3. salesman의 급여 최댓값보다 더 많은 급여를 받는 직원들의 사번, 이름, 급여, 업무들을 출력.
--(1) salesman의 급여 최댓값 (2) 직원들의 사번, 이름, 급여, 업무들을 출력 ()
select max(sal) from emp where job='SALESMAN';
select empno, ename, sal, job from emp where sal >( select max(sal) from emp where job='SALESMAN');

-- 4. ward의 연봉보다 더 많은 연봉을 받는 직원들의 이름, 급여, 수당, 연봉을 출력
-- 연봉 = SAL* 12+ comm. comm(수당)이 null인 경우에는  0으로 계산
-- 연봉은 내림차순.
select sal*(12+comm) from emp where ename='WARD';

select ename, sal, comm, sal*12+nvl(comm,0) from emp where sal*12+nvl(comm,0) >(
select sal*12+nvl(comm,0) from emp where ename='WARD')
order by sal*(12+comm);


-- 5.sccott과 같은 급여를 받는 직원들의 이름과 급여를 출력. 단, scott 제외
select sal from emp where ename='SCOTT';
select ename, sal from emp where sal =(
select sal from emp where ename='SCOTT'
)and ename !='SCOTT';


-- 6. allen보다 늦게 입사한 직원들의 이름, 입사날짜를 최근입사일부터 출력.
select hiredate from emp where ename='ALLEN';
select ename, hiredate from emp where hiredate > (
select hiredate from emp where ename='ALLEN'
)
order by hiredate desc
;

-- 7. 매니저가 king인 직원들의 사번, 이름, 매니저 사번을 검색.
select ename from emp where mgr='7839';
select empno from emp where mgr='KING';
select empno, ename, mgr from emp where mgr= (
select empno from emp where ename='KING');

-- 8. accpunting부서에서 일하는 직원들의 이름, 급여, 부서 번호를 검색.
select empno from emp; where job='ACCOUNTING';
select ename, sal, deptno from emp where deptno=(
select deptno from dept where dname='ACCOUNTING');

-- 9. chicago에서 근무하는 직원들의 이름, 급여, 부서번호를 검색.
select deptno from dept where loc='CHICAGO';
select ename, sal, deptno from emp where deptno=(
select deptno from dept where loc='CHICAGO'
);

select e.ename, e.sal, e.deptno 
from emp e join dept d on e.deptno =d.deptno
where d.loc='CHICAGO' ;

-- 단일 행 서브 쿼리: 서브 쿼리의 결과 행의 개수가 1개인 서브 쿼리.
-- 단일 행 서브 쿼리는 동등 비교(=)를 할 수 있음.

-- 다중 행 서브 쿼리: 서브 쿼리의 결과 행의 개수가 2개 이상인 서브 쿼리.
-- 다중 행 서브 쿼리는 동등 비교(=)를 할 수 없음! in 연산자는 사용가능!

-- salesman들의 급여와 같은 급여를 받는 직원들은?
-- (1) salesman들의 급여
select sal from emp where job='SALESMAN';
-- (2) 급여가 1600또는 1250또는 1500인 직원들
select * from emp where sal = 1600 or sal=1250 or sal=1500;
select * from emp where sal in (1600,1250,1500);

--sub query
select * from emp
where sal in ( select sal from emp where job ='SALESMAN');
/*
select ename from emp where sal=(
select sal from emp where job='SALESMAN'
);
*/

-- 매니저인 직원들?
select * from emp
where empno in (select distinct mgr from emp);
-- 매니저가 아닌 직원들?
select * from emp
where empno not in (select distinct mgr from emp); --> 결과 행의 개수는 0개.
-- empno in(a,b) 조건식이 empno= a or empno = null 조건식과 동일.
-- empno no in (a,b) 조건식이 empno!= a and empno!=b 조건식과 동일.
-- in 과 not in값을 비교할 때 동등 비교 연산자(=,!=)를 사용, is로 비교하지 않음.
-- empno=null 조건식은 항상 false. empno!=null 조건식도 항상 false.
select * from emp
where empno not in (select distinct mgr from emp where mgr is not null);

select * from emp where mgr!=null;
select * from emp where mgr is not null;

-- 다중 행 서브 쿼리와 where exists, not exists 구문.
-- 매니저인 직원들?
select e1.* from emp e1
where exists(select e2.* from emp e2 where e2.mgr =e1.empno);

-- 매니저가 아닌 직원들
select e1.* from emp e1
where not exists(select e2.* from emp e2 where e2.mgr =e1.empno);

-- 부서테이블에서 부서정보(번호,이름,위치)를 출력. 
-- 단, 직원 테이블에 존재하는 부서들만 출력
select d.* from dept d
where exists ( select * from emp e where e.deptno=d.deptno);

-- 부서테이블에서 부서정보(번호,이름,위치)를 출력. 
-- 단, 직원 테이블에 존재하지 않는 부서들만 출력
select d.* from dept d
where not exists ( select * from emp e where e.deptno=d.deptno);

-- 다중 행 서브 쿼리에서의 any vs all
-- 다중 행 부등호와 함께 
select * from emp
where sal >any(
select sal from emp where job='SALESMAN' 
);
--> sal> 1600 or sal>1250 or sal>1500 과 같은 문장
--> sal> 1250
--> 영업사원 급여의 최솟값(1250)보다 더 많은 급여를 받는 직원들. 
/* 
* column =(단일 행서브쿼리)
* column in(다중행 서브 쿼리)
* column>(단일행 서브쿼리)
* column>any/all(다중행 서브 쿼리)
*/

select * from emp
where sal >all(
select sal from emp where job='SALESMAN' 
);
--> sal>1600 and sal>1250 and sal>1500
--> sal>1600
--> 영업사원 급여 최댓값(1600)보다 더 많은 급여를 받는 직원들.

-- having 절에서 사용되는 서브 쿼리
-- 업무별 급여의 합계를 출력. 단, 영업사원들의 급여합계보다 큰 업무들만 출력.
select job, sum(sal) from emp 
group by job
having sum(sal)> (
select sum(sal) from emp where job='SALESMAN'
); 

-- select 절에서 사용되는 서브 쿼리
select empno, ename, 'ACCOUNTING' as dept_name
from emp
where deptno =10;
/*
select empno, ename
(10번부서의 이름) as dept_name
from emp
where deptno =10;
*/

select empno, ename,
(select dname from dept where deptno=10) as dept_name
from emp
where deptno =10;

-- clerk들의 사번, 이름, 급여, clerk급여의 최솟값/최댓값을 출력.
select empno, ename, sal,
(select min(sal) from emp where job='CLERK') as min_sal,
(select max(sal) from emp where job='CLERK') as max_sal
from emp where job='CLERK';

