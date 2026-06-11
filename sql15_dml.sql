/*
* DML(Date Manipulation Language): insert, update, delete
*
*
*/

-- INSERT INTO table_name [(column1, column2,... )] VALUES (value1, value2, ...); [컬럼이름] 생략가능
--> 1개의 행만 삽입.
-- INSERT INTO table_name [(column1, column2,... )] SELECT 문장;
--> select 문장의 결과에 따라서 여러개의 행들이 한 번에 삽입될 수 있음.

-- bonus테이블에 이름, 업무, 급여, 수당을 삽입
insert into bonus values('오쌤', '교육', 3000, 100);

-- bonus테이블에 이름, 업무, 급여를 삽입.
insert into bonus (ename, job, sal) values ('홍길동', '도둑', 10000);

select * from bonus;

-- emp테이블에서 comm이 null이 아닌 직원들의 정보를 bonus테이블에 삽입.
insert into bonus 
select ename, job, sal, comm from emp where comm is not null;

-- emp테이블에서 부서번호가 20인 직원들의 이름, 업무, 급여, 수당을 bonus테이블에 삽입
insert into bonus
select ename, job, sal, comm from emp where deptno=20;
commit;

-- update문장: 테이블에서 특정 컬럼의 값(들)을 수정(업데이트).
-- UPDATE table_name SET column1= value1, column2= value2, ... [where 조건식];  -- > =할당연산자 오른쪽에 있는 값을 왼쪽에 넣는다~ [ ] 생략가능
-- where 절은 생략가능. where 절이 없는 경우에는 테이블의 모든 행이 업데이트됨.
-- where 절이 있으면 조건을 만족하는 행들만 업데이트 됨.

update emp set job='clerk';
--> 조건절이 없는 경우에는 emp테이블의 모든 행 (15개 행)에서 job컬럼의 값이 업데이트됨.

rollback; --> 직전(마지막) commit된 상태로 되돌림.
select * from emp;

--업무가 null직원의 업무를 'CLERK'로 업데이트하세요.
update emp set job='CLERK'
where job is null;

-- sql에서 = 연산자의 의미:
-- (1) where/ having 조건절에서의 =연산자는 비교연산자. column = value : column의 값이 value와 같으면 true, 그렇지 않으면 false.
-- (2) 할당 연산자 set절에서 사용된 = 연산자. column = value: value를 column에 저장(할당).


-- 사번이 7369인 직원의 급여를 1000, 수당을 100으로 업데이트.
update emp set sal=1000, comm=100
where empno=7369;
--> 사번이 pk인 경우라면, 오직 1개의 행만 업데이트됨.

-- 업무가 'CLERK'인 직원들의 급여를 10% 인상.
update emp set sal=sal*1.1
where job='CLERK';
commit;

-- ACCOUNTING 부서에서 일하는 직원들의 급여를 10% 인상.
update emp set sal=sal*1.1
where deptno=( select deptno from dept where dname='ACCOUNTING');

select * from emp;

-- 급여 등급이 1인 직원들의 급여를 20% 인상.
update emp set sal=sal*1.2
where ename in(
select ename
from emp e join dept d on e.deptno=d.deptno
join salgrade s on e.sal between s.losal and s.hisal
where grade=1);


-- 급여 등급이 2인 직원들의 급여를 5% 인상.
update emp
set sal = sal*1.05
where empno in (
    select e.empno from emp e join salgrade s on e.sal between s.losal and s.hisal 
    where s. grade=2
    );

-- emp 테이블에서 부서번호가 dept 테이블에 없는 직원의 부서번호를 null로 업데이트. 
update emp set deptno = null --null is는 조건절에서만 사용됨.
where deptno not in ( select deptno from dept ) ; -- (dept테이블에서 부서번호)

commit;

-- 입사날짜가 널인 직원의 입사일을 현재시간으로 업데이트.
update emp set hiredate = sysdate --systimestamp 소수점이하 초까지 
where hiredate is null ;

--comm이 null인 직원들의 comm을 0으로 업데이트
update emp set comm=0
where comm is null;

-- update emp set nvl(comm,0); UPDATE 구문의 SET 바로 뒤(대입할 대상)에는 함수를 사용할 수 없습니다. 대입할 대상은 오직 실제 테이블의 컬럼명이어야 합니다.

-- delete 문장: 테이블에서 (조건을 만족하는) 행(들)을 삭제하는 DML
-- (문법) delete from 테이블_이름 [where 조건식];
-- where 조건절은 생략가능. 조건절이 없으면 테이블의 모든행들이 삭제됨. 커밋전이면 복구가능.
delete from emp; --> 테이블의 모든 행(15개)들이 삭제됨.
rollback; --> 이전 (가장 마지막) commit상태로 되돌림.

-- 사번이 1004인 직원 정보를 테이블에서 삭제
delete from emp
where empno=1004;
select * from emp;

commit;
-- 급여 등급이 5인 직원들의 정보를 테이블에서 삭제
-- (1)급여 등급이 5인 직원
delete from emp
where sal between (select losal from salgrade where grade= 5) and (select hisal from salgrade where grade =5 );

delete from emp
where empno in
    (select e.empno from emp e join salgrade s on e.sal between s.losal and s.hisal 
    where s. grade=5)