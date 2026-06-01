/*
* join: 관계형 데이터베이스(RDBMS, Relational Database Management System)에서 1개 이상의 테이블에서 필요한 정보들을 조합해서 검색하는 방법.
* join의 종류:
* 1. inner join
* 2. outer join
*       (1) left outer join
*       (2) right outer join
*       (3) full outer join
* join 문장 문법
* 1. ANSI 표준 문법
*       select ...
*       from 테이블1 join_방법 테이블2 on join_조건식;
* 2. Oracle 문법
*       select .../
*       from 테이블1, 테이블2, ...
*       where join_조건식;
*/

-- inner join과 outer join의 차이점을 비교하기 위한 데이터 삽입(insert)
 insert into emp(empno, ename, sal, deptno)
 values(1004, '오쌤', 4000, 50);
    
    commit; --테이블의 변경 내용을 영구히 저장.
 select * from emp;
 select * from dept;

-- 직원 이름, 부서번호, 부서이름 검색

 -- INNER JOIN
 -- (1) ANSI 표준문법
 select emp.ename, emp.deptno, dept.dname
 from emp inner join dept  on emp.deptno=dept.deptno;
--> inner join에서 inner는 생략가능.

 select e.ename, e.deptno, d.dname
 from emp e inner join dept d on e.deptno=d.deptno;
 
 --(2) Oracle 문법
 select e.ename, e.deptno, d.dname
 from emp e, dept d
 where e.deptno = d.deptno;
 
 -- LEFT OUTER JOIN
 -- (1) 표준 문법
 select 
    e. ename, e.deptno, d.deptno, d.dname
 from emp e left outer join dept d on e.deptno=d.deptno; 
 --> 결과: 15행(오쌤 포함, operation부서 미포함)
 -- emp LEFT 쪽에 있는 행은 다 나와야함. 
 --> LEFT OUTER JOIN에서는 outer는 생략 가능.
 
 -- (2) Oracle 문법
 select
    e.ename, e.depton, d.depton, d.dname
 from emp e, dept d
 where d.deptno = d.deptno(+);
 
 -- RIGHT OUTER JOIN
 -- (1) 표준 문법 
 select 
    e.ename, e.deptno, d.deptno, d.dname
 from emp e right join dept d on e. deptno = d.deptno;
 --> 결과: 15행(오쌤 미포함, operation 미포함)
 --> right outer join에서 outer는 생략가능.
 
 --(2) Oracle 문법
 select
    e.ename, e.deptno, d.deptno, d.dname
from emp e, dept d
where e.deptno(+)= d.deptno;

-- FULL OUTER JOIN
-- (1) 표준 문법
select
    e.ename, e.deptno, d.deptno, d.dname
from emp e full join dept d on e.deptno=d.deptno;
--> 결과 16행(50번 부서 오쌤, 40번 부서 OPERATION 모두 포함).
--> full outer join에서 outer는 생략가능.

-- (2) Oracle 문법
-- oracle에서는 full outer join 문법을 제공하지 않음.
-- oracle에서는 left join과 right join의 결과를 "합집합(UNION)"으로 FULL OUTER JOIN을 할 수 있음.
 select
    e.ename, e.deptno, d.deptno, d.dname
from emp e, dept d
where e.deptno= d.deptno(+)
union
 select
    e.ename, e.deptno, d.deptno, d.dname
from emp e, dept d
where e.deptno(+)= d.deptno
;
-- equi-join: join 조건식이 등호(=)로 작성된 경우.
-- non-equi join: join이 부등호(>, >=, <, <=, ...)로 작성된 경우.
-- emp와 salgrade 테이블에서 사번, 이름, 급여, 급여등급을 검색(inner join)
-- (1) 표준 문법
select e.empno, e.ename, e.sal, s.grade
from emp e inner join salgrade s on e.sal >= s.losal and e.sal<=s.hisal;

select e.empno, e.ename, e.sal, s.grade
from emp e 
join salgrade s 
on e.sal between s.losal and s.hisal;

--(2) Oracle 문법
select
    e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal;
    
    
