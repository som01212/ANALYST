/*
* SQL 문장의 종류
* 1.DDL(Date Definition Language 데이터를 정의하는 언어): create, alter변경하다, truncate, drop
* 2.DQL(Date Query Language): select 
* 3.DML(Date Manipulpation Language조작하다): insert, update, delete
* 4.TCL(Transaction Contral Language): commit, rollback 
*
* 테이블 생성 SQL
* create table 테이블_이름 (
*          컬럼_이름 데이터타입[[기본값] [제약조건]],
*          ...);
*
* ANSI SQL 국제 표준에 데이터베이스 가느이 호환성을 유지하기 위해서 데이터 타입 이름들을 정의하고 있음.
* 데이터 타입으로 사용되는 키워드(예약어)들은 데이터베이스 종류에 따라서 다름.
* ANSI SQL 표준 데이터 타입 이름
* 1. 숫자
*       (1) integer/int: 4바이트 정수. 
*       (2) numeric(p,s): 전체 자릿수(p) 중에서 소숫점 이하 자릿수(s)인 실수.
* 2. 문자열
*       (1) char(n), character(n): 고정길이(n바이트) 문자열.
*       (2) vahchar(n): varying character. 가변길이(n바이트) 문자열.    
* 3. 날짜/시간
*       (1) date: 날짜(년/월/일) - Oracle에서는 날짜와 시간을 동일하게 저장됨
*       (2) time: 시간(시/분/초)
*       (3) timestamp: 날짜와 시간을 포함한 세부적인 시간. 주로 100만분의 1초. milli-second, micro-second, nano-second.
* 4. 대용량 데이터
*       (1) clob: character large object. 매우 큰 용량이 큰 문자열 데이터.
*       (2) blob: binary large object. 매우 용량이 큰 이진 데이터.
* Oracle에서 사용되는 데이터 타입 이름
* 1. 숫자: number(p, s) - 전체 자릿수(p) 중에서 소숫점 이하 자릿수(s)인 숫자.
* 2. 문자열:
*       (1) 고정길이 문자열: char(n)
*       (2) 가변길이 문자열: varchar2(n)
* 3. 날짜: 표준 이름과 동일.
*       (1) date: 날짜와 시간(년/월/일/시/분/초)
*       (2) timestamp: 최대 nano-second(1/1000000000)까지 저장할 수 있는 시간 단위.
* 4. 대용량 데이터: 표준과 동일.
* /

/* 
* 테이블 이름: ex_students
* 컬럼: 
*     (1) student_id: 학생 아이디. 숫자타입(최대4자리 정수) -9999~9999
*     (2) student_name: 학생 이름. 문자열(가변길이 최대10글자) varchar2(10cahr)
*     (3) birthday: 학생 생일. 날짜 타입.
*/ 

create table ex_students(
        student_id      number(4, 0),
        student_name varchar2(10 char), 
        birthday         date 
);
 
/*
* 테이블에 행(row)을 삽입(저장):
* insert into 테이블_이름( 컬럼1, 컬럼2, ...) values( 값1, 값2, ...)
*
* 테이블에 삽입하는 값들의 개수가 컬럼 개수와 같고, 그 순서가 테이블의 컬럼 순서와 동일한 경우, 
* insert into 테이블_이름 values( 값1, 값2, ...);
*/

insert into ex_students( student_id, student_name, birthday)
values (1001, '홍길동', '2026-06-05');
--> 오라클은 '2026/06/05' 문자열을 날짜타입으로 변환해서 birthday 컬럼에 값을 삽입.
insert into ex_students ( birthday, student_id, student_name) --컬럼의 순서는 상관없음.
values ('2000/06/05', 1002, '김길동'); --값만 컬럼에 맞는 값을 작성하면 됨.

insert into ex_students( student_id, student_name)
values ( 1003,'이길동');


insert into ex_students
values (1004, '오쌤', '2000/01/01');

commit; -- 테이블의 변경 내용을 영구히 저장.
-- 커밋하기전 나에게만 보여짐 커밋후는 다른사람에게도 영향 저장이 된 상태를 보여지게 됨.

select * from ex_students;

/*insert into ex_students ( student_id)
values (12345);
--> 숫자 전체 자릿수(4)를 초과하느 값은 insert가 되지 않음.

insert into ex_students (student_id) 
values ('abcd');
--> 수치가 부적합. 아이디는 숫자, abcd는 숫자로 변환할 수 없는 문자열
*/

insert into ex_students (student_id)
values('1010');
--> 오라클은 '1010'문자열을  to_number() 함수를 사용해서 정수1010으로 변환 후 삽입.

insert into ex_students ( student_name)
values ('aaaaaaaaaaaa');
--> 최대 10글자(character)까지 저장할 수 있는 컬럼에 11글자를 삽입하려고 하기 때문에 에러. 한글도 10글자 영어도10글자임.

commit;
select * from ex_students;

-- 오라클에서 문자열 타입 컬럼을 선언할 때 char(n byte)/ char(n cahr) 또는 varchar2(n byte)/ varchar2(n char).
-- byte/char 단위를 생략하면 기본값으로 byte단위
-- 오라클에서 문자를 저장할 때 UTF-8 인코딩을 사용하는 경우,
-- 영문자, 숫자, 특수기호 -> 한글자를 저장할 때 1byte를 사용
-- 한글, 일본어, 중국어, ... -> 한글자를 저장할 때 3byte를 사용
--

create table ex_byte (
    col_str varchar2(5) 
    );
    
insert into ex_byte values ('abc12');
insert into ex_byte values('abc123');--> 에러 6byte
insert into ex_byte values('홍길동');--> 에러 9byte
insert into ex_byte values('홍12');--> 5byte

-- create table 연습: emp테이블과 같은 이름과 같은 타입의 컬럼들을 갖는 테이블을 만들기.
-- 테이블이름은(ex_emp)
create table ex_emp (
        empno         number(4,0), --4자리, 소숫점이하숫자는 0. number(4) 와 동일함
        ename          varchar2(10 byte), -- varchar2(10) 과 동일함
        job              varchar2(9 byte),
        mgr             number(4,0),
        hiredate       date,
        sal               number(7,2), -- 전체 7자리 중 소숫점이하는 2자리까지.12345.67
        comm         number(7,2),
        deptno        number(2,0)
        );
        
drop table ex_emp; -- 테이블 삭제

-- ROLLBACK: 이전 commit 된 이후에 테이블에서 변경된 내용( insert, update,delete)을 
-- 이전 commit 상태로 되돌림. create table로 생성된 테이블을 삭제하지 않음.
-- commit: 마지막에 commit된 이후에 테이블에서 변경된 내용(insert, update, delate)들을 영구히 저장.

-- create table 테이블 이름 as select 구문: 테이블을 생성하면서 select한 내용들을 복사. 
-- dept 테이블의 구조(컬럼/ 데이터 타입)과 내용(행) ex_dept1 테이블로 복사. 
create table ex_dept1 
as select * from dept;
-- dept 테이블의 구조만(컬럼/ 데이터타입)만 복사, 데이터는 복사하지 않기.
SELECT * FROM EX_DEPT2;

create table ex_dept2
as select * from dept where deptno= -1;

-- ex_emp_dept: emp테이블과 dept 테이블을 사용해서 
-- 사번, 이름, 업무, 입사일, 급여, 부서번호, 부서이름, 위치 컬럼을 갖는 테이블.

create table ex_emp_dept
as 
select e.empno, e.ename, e.hiredate, e.sal, e.deptno, d.dname, d.loc 
from emp e, dept d 
where e.deptno=d.deptno
order by e.empno;

