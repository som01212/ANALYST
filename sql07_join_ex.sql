/*
* JOIN 연습문제
*/-- jake.oh.lecture@gmail.com

-- Ex1. 직원 이름, 근무 도시를 검색. 도시 이름으로 정렬.
--inner join과 outer join의 결과를 비교하세요.
select e.ename, d.loc from emp e, dept d
order by loc;

select e.ename, d.loc from emp e, dept d
where e.ename = d.loc(+)
order by loc;

--Ex2. 직원 이름, 매니저의 이름, 직원 급여, 직원 급여 등급 검색. inner join.
--정렬순서: (1) 매니저, (2) 급여 등급
select e.ename, e.sal, s.grade from emp e, salgrade s
where e.sal between s.losal and s.hisal
order by grade;

--Ex3. 직원 이름, 부서 이름, 급여, 급여 등급 검색. inner join.
--정렬순서: (1) 부서 이름, (2) 급여 등급
select * from (select e.ename, e.deptno, e.sal, s.grade from emp e, salgrade s
where e.sal between s.losal and s.hisal
order by deptno,grade) f;


--Ex4. 부서이름, 부서위치, 부서의 직원수 검색. 부서 번호 오름차순.

select d.dname, d.loc, e.empno, e.deptno
from emp e, dept  d
order by deptno;

--Ex5. 부서 번호, 부서 이름, 부서 직원수, 부서의 급여 최솟값/ 최댓값 검색.
--부서 번호 오름차순
select d.deptno, d.dname, s.grade
from emp e join salgreade s
on

select e.empno, e.ename, e.sal, s.grade
from emp e 
join salgrade s 
on e.sal between s.losal and s.hisal;


--Ex6. 부서 번호, 부서 이름, 사번, 직원 이름, 매니저 사번, 매니저 이름,
--직원 급여, 직원 급여 등급 검색.
--급여가 2000이상인 직원들만 검색.
--정렬 순서: (1) 부서 번호, (2) 사번
select d.deptno, d.deptno, e.empno, e.mgr
from emp e dept d
where sal >=2000
order by d.deptno,e.empno;
