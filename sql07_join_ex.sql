/*
* JOIN 연습문제
*/-- jake.oh.lecture@gmail.com

-- Ex1. 직원 이름, 근무 도시를 검색. 도시 이름으로 정렬.
-- inner join과 outer join의 결과를 비교하세요.
-- inner
-- ansi
select
    e.*, d.*
from emp e join dept d on e.deptno=d.deptno;

 select ename, loc --컬럼이름이 모호성이 없다면 생략해도 됨.
 from emp e join dept d on e.deptno=d.deptno
 order by d.loc;
-- oracle
select e.ename, d.loc
from emp e, dept d
where e.deptno=d.deptno
order by d.loc;

-- left join
-- ansi
select e.ename, d.loc
from emp e 
left join dept d 
on d.deptno=e.deptno
order by d.loc; --> 15개 행 (오쌤/null)

--oracle
select e.ename, e.deptno, d.loc
from emp e, dept d
where e.deptno=d.deptno(+) --> emp테이블이 기준, 널이 되는 쪽에 +
order by d.loc;

-- right ansi
select e.ename, d.loc
from emp e
right join dept d
on e.deptno=d.deptno
order by d.loc;

-- right oracle
select e.ename, e.deptno, d.loc
from emp e, dept d
where e.deptno(+)=d.deptno
order by loc;

-- full ansi
select e.*, d.*
from emp e 
full join dept d on e.deptno=d.deptno;
-- full ansi
select e.ename, d.loc
from emp e 
full join dept d on e.deptno=d.deptno
order by d.loc;

-- full oracle
select e.ename, d.loc
from emp e, dept d
where e.deptno=d.deptno(+)
union
select e.ename, d.loc
from emp e, dept d
where e.deptno(+)=d.deptno
order by loc;

--Ex2. 직원 이름, 매니저의 이름, 직원 급여, 직원 급여 등급 검색. inner join.
--정렬순서: (1) 매니저, (2) 급여 등급
-- 셀프조인 self join, salgrade
-- ansi
select 
    e1.ename as 직원이름, 
    e2.ename as 매니저이름,
    e1.sal as 직원급여,
    s.grade as 급여등급
from emp e1
join emp e2 on e1.mgr = e2.empno
join salgrade s on e1.sal between s.losal and s.hisal
order by e2.ename, s.grade;

select e1.*, e2.*, s.*
from emp e1 join emp e2 on e1.mgr= e2.empno
    join salgrade s on e1.sal between s.losal and hisal
    ;
    
-- oracle 
select e1.*, e2.*, s.*
from emp e1, emp e2, salgrade s
where e1.mgr=e2.empno and e1.sal between losal and hisal;
order by e2.ename, s.grade;

select e1.*, e2.*, s.*
from emp e1, emp e2, salgrade s
where e1.mgr=e2.empno(+) and e1.sal between losal(+) and hisal(+); --e2.emptno(+)여기는 레프트 조인, --non equi join은 둘다 레프트든 라이트든(+)해야함
order by e2.ename, s.grade;

select e1.*, e2.*, s.*
from emp e1, emp e2, salgrade s
where e1.mgr(+)=e2.empno and e1.sal between losal(+) and hisal(+) --e2.emptno(+)여기는 레프트 조인, --non equi join은 둘다 레프트든 라이트든(+)해야함
order by e2.ename, s.grade;

select
    e1.ename as 직원이름, 
    e2.ename as 매니저이름,
    e1.sal as 직원급여,
    s.grade as 급여등급
from emp e1, emp e2, salgrade s
where e1.mgr=e2.empno and e1.sal between losal and hisal;

-- Ex3. 직원 이름, 부서 이름, 급여, 급여 등급 검색. inner join.
-- 정렬순서: (1) 부서 이름, (2) 급여 등급

-- ansi
select e.*, d.*, s.*
from emp e join dept d on e.deptno=d.deptno
join salgrade s on e.sal between s.losal and s.hisal;

select e.ename, d.dname, e.sal, s.grade
from emp e join dept d on e.deptno=d.deptno
join salgrade s on e.sal between s.losal and s.hisal
order by d.dname, s.grade;

-- oracle
select e.ename, d.dname, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno and e.sal between s.losal and s.hisal
order by d.dname;


--Ex4. 부서이름, 부서위치, 부서의 직원수 검색. 부서 번호 오름차순.
-- ansi
select d.dname, d.loc, count(e.empno), 
from emp e join dept d on e.deptno=d.deptno
group by d.dname, d.loc, d.deptno
order by d.deptno; -- 출력을 안하더라도 그룹바이에 있어야 정렬이 가능함

select d.dname, d.loc
    from emp e left join dept d on e.deptno=d.deptno
    group by d.dname, d.loc, d.deptno
    order by d.deptno;
    
-- oracle    
select d.dname, d.loc, count(e.empno)
from emp e, dept  d
where d.deptno = e.deptno
group by d.dname, d.loc, d.deptno;
order by d.deptno;

--Ex5. 부서 번호, 부서 이름, 부서 직원수, 부서의 급여 최솟값/ 최댓값 검색.
--부서 번호 오름차순

--inner join, ansi
select d.deptno, d.dname, count(*),  min(e.sal), max(e.sal)
from emp e join dept d on e.deptno=d.deptno
group by d.deptno, d.dname-- 그룹바이에 있는 것만 셀선택이 가능함.
order by d.deptno;

--inner join, oracle
select d.deptno, d.dname, count(e.empno), min(e.sal), max(e.sal)
from emp e, dept  d
where d.deptno = e.deptno
group by d.deptno, d.dname
order by deptno;

--Ex6. 부서 번호, 부서 이름, 사번, 직원 이름, 매니저 사번, 매니저 이름,
--직원 급여, 직원 급여 등급 검색.
--급여가 2000이상인 직원들만 검색.
--정렬 순서: (1) 부서 번호, (2) 사번

--ansi
select d.deptno, d.dname, e1.empno, e1.ename, e1.mgr, e2.ename, e1.sal, s.grade
from emp e1 join emp e2 on e1.mgr=e2.empno --e1에 있는 매니저와 e2의 사번과 같다~
join dept d on e1.deptno=d.deptno
join salgrade s on e1.sal between s.losal and s.hisal
where e1.sal >= 2000
order by d.deptno, e1.empno;

select d.deptno, d.dname, e1.empno, e1.ename, e1.mgr, e2.ename, e1.sal, s.grade
from emp e1, emp e2, dept d, salgrade s
where e1.mgr=e2.empno and e1.deptno=d.deptno
and e1.sal between s.losal and s.hisal
and e1.sal>= 2000
order by d.deptno,e1.empno;



