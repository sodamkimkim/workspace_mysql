-- ﻿
-- 서브쿼리(내부쿼리) -1
-- 꼭 괄호를 사용해서 감싸야 한다.

-- 서브쿼리 종류
-- 서브쿼리는 쿼리의 위치가 어디에 있느냐에 따라서 총 세 가지 종류로 나눌 수 있다.
-- 중첩 서브쿼리(nested subquery) : WHERE 절에 사용하는 서브 쿼리
-- 인라인 뷰(inline view) : FROM절에 사용하는 서브 쿼리
-- 스칼라 서브쿼리(scalar subquery) : SELECT 절에 사용하는 서브 쿼리

-- 서브쿼리 특징
-- 장점)
-- 서브쿼리는 쿼리를 구조화 시킴 => 쿼리의 각 부분을 명확히 구분할 수 있게 해 준다.
-- 서브쿼리는 복잡한 Join이나 union과 같은 동작을 수행할 수 있는 또 다른 방법을 제공한다.
-- 서브쿼리는 복잡한 Join이나 union보다 좀 더 읽기 편하다.


-- DB 생성
CREATE DATABASE reservationdb;
use reservationdb;

-- 테이블 생성 (예약정보 관리)
CREATE TABLE reservation (
    id INT AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    reserveDate DATE NOT NULL,
    roomNum VARCHAR(5) NOT NULL,
    PRIMARY KEY (id)
);

-- 고객 테이블 
CREATE TABLE customer (
    id INT AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    age INT NOT NULL,
    address VARCHAR(10),
    PRIMARY KEY (id)
);

-- 데이터 입력
insert into reservation values(1, '홍길동', '2020-05-01 00:00:00',1);
insert into reservation values(2, '임꺽정', '2020-05-02 00:00:00',2);
insert into reservation values(3, '장길산', '2020-05-03 00:00:00',3);
insert into reservation values(4, '홍길동', '2020-05-04 00:00:00',4);

select * from reservation;

-- 데이터 수정
-- 1 = roomNum 을 1001으로 변경
update reservation set roomNum = '1001' where id=1;
-- 1 = roomNum 을 1002으로 변경
update reservation set roomNum = '1002' where id = 2;
-- 1 = roomNum 을 1003으로 변경
update reservation set roomNum = '1003' where id = 3;
-- 1 = roomNum 을 1004으로 변경
update reservation set roomNum = '1004' where id = 4;

select * from reservation;

-- 고객 테이블 데이터 생성
insert into customer values(1, '홍길동', 20, '서울');
insert into customer values(2, '임꺽정', 30,'서울');
insert into customer values(3, '장길산', 24,'서울');
insert into customer values(4, '전우치', 33,'서울');

select * from customer;
-- 2. --> 인천, 3 --> 서울, 4 --> 수원
update customer set address = '인천' where id = 2;
update customer set address = '서울' where id = 3;
update customer set address = '수원' where id = 4;

select * from customer where address in('서울');

-- where절 서브쿼리(중첩 서브쿼리)
-- 주소가 서울인 고객들의 예약 정보를 확인하는 쿼리
select id, reserveDate, roomNum, name
from reservation
where name in(
			select name
            from customer
            where address = '서울'
            );
-- ㄴ 서브쿼리 괄호안에 뽑히는 거도 name 이어야함

-- join 문으로 변경해서 같은 결과를 출력해 주세요
select r.id, r.reserveDate, r.roomNum, r.name
from reservation as r
left join customer as c
on r.name = c.name
where c.address = '서울';

-- from 절 서브쿼리 (인라인 뷰)
-- 인라인 뷰에서는 서브쿼리가 먼저 실행 됨.
SELECT 
    name, reservedRoom
FROM
    (SELECT 
        name, reserveDate, (roomNum) as reservedRoom
    FROM
        reservation
    WHERE
        roomNum > 1001) as reservationInfo;

-- /*
-- 쿼리 실행 순서
-- 1. reservation 테이블에서 roomNum > 1001보다 큰 레코드를 먼저 찾은 후 rommNum 필드값 1씩 증가.
-- 해당 쿼리에 결과 집합 reservationInfo 임시 테이블로 만들어 진다.(내부쿼리, 서브쿼리)
-- 외부 쿼리에서는 이렇게 만들어진 임시 테이블에서 name, reservedRoom 필드만을 선택해서 결과 집합을 보여주게 된다.
-- */

select * from reservation;
select * from customer;



select id, reserveDate, roomNum, name
from reservation
where name in(
			select name
            from customer
            where address = '서울'
            );
            


-- 지역이 인천과 서울인 예약고객 뽑아내기
select * from reservation
where name in(select name from customer where address ='서울' or '인천');



-- 연습문제------------------------------------------------------------------------------

-- 주소가 서울인 고객들에 예약 정보를 확인하는 쿼리 
select id, reserveDate, roomNum, name 
from reservation
where name in(
				select name 
                from customer 
                where address = '서울'
			); 

-- JOIN 문으로 변경해서 같은 결과를 출력해주세요 
select r.id, r.reserveDate, r.roomNum, r.name, c.address
from reservation as r 
left join customer as c 
on r.name = c.name 
where c.address = '서울';

select r.id, r.name, reserveDate, roomNum, address
from reservation as r
inner join customer as c
on r.name = c.name
where address = '서울';


-- FROM 절 서브쿼리 
select name, reservedRoom
from ( select name , reserveDate, (roomNum) as  reservedRoom
		from reservation 
        where roomNum > 1001) as reservationInfo;

-- 2020-05-02 예약정보 확인
select id, name, roomNum, reserveDate
from reservation
where name in (
                select name
                from customer
                where reserveDate = '2020-05-02');

-- pr
select id, name, roomNum, reserveDate
from reservation
where name in (
	select name
	from customer
	where reserveDate = '2020-05-02');




-- 2020-05-02 일자로 예약한 고객의 id와 이름 조회하기
select id, name
from customer
where name in (select name
            from reservation
            where reserveDate = '2020-05-02'
            );


-- 고객테이블에서 실제 예약한 고객중 30살 이상인 고객 id, 이름, 나이, 주소, 예약일, 예약한 방 정보 출력
select c.id, c.name, c.age, c.address, r.reserveDate, r.roomNum
from customer as c
inner join reservation as r
on c.name = r.name
where c.age >= 30;


-- 나이가 30보다 어린 사람의 예약 정보를 확인하는 쿼리
 select *
 from reservation
 where name in (select name from customer where age < 30);
 
-- 5/2 이후에 예약한 예약자 정보 확인
select *
from (select * from reservation where reserveDate > '2020-05-02 00:00:00') as reservationInfo;


-- 나이가 30대인 사람들의 예약 정보 출력
select name as 이름, 나이
from (select name, age as 나이
        from customer as c
        where c.age >= 30 and c.age < 40) as a;


-- where절에 사용하는 서브 쿼리를 사용해서 나이가 21살 이상의 고객들만 출력
select id, name, reserveDate, roomNum
from reservation
where name in(select name
       from customer
       where age > 20);



-- 나이가 30살 미만인 예약자의 예약정보 출력하기
select *
from reservation 
where name in(select name 
            from customer
            where age < 30
);


-- 지역이 인천과 서울인 예약고객 뽑아내기
select * from reservation
where name in(select name from customer where address ='서울' or '인천');




-- 서브쿼리 2
use employees;
select * from employees;
select * from dept_emp; -- employees vs dept_emp (1:N)관계
desc dept_emp;

select * from departments order by dept_no; -- departments vs dept_emp(1:N)
select * from dept_manager;
select * from titles;
desc dept_emp;
desc departments;

select*, dept_no as '뽑아야 되는 값'
from departments as A
where a.dept_name = 'developement';

-- 문제 1 (중첩 서브 쿼리)
-- dept_emp 테이블에서 development인 emp_no 와 dept_no를 출력하세요.
select*
from dept_emp
where dept_no = 'd005';

select emp_no, dept_no
from dept_emp
where dept_no = (select dept_no from departments where dept_name = 'development');

-- 문제 2(중첩 서브 쿼리)
-- employees 테이블에서 현재 development 매니저인 직원만 출력하시오
select * from employees;
select *
from employees
where emp_no in (select emp_no from dept_manager where to_date = '9999-01-01' and dept_no = 'd005');
-- 단일행 결과 집합 나와서 외부 커리인  emp_no  조건식으로 처리가 된다.

select * from employees;
select *
from employees
where emp_no in (select emp_no from dept_manager where to_date = '9999-01-01' and dept_no = 'd005');
-- d005 --> development(값으로 변경해서 쿼리문을 완성해 주세요)

select *
from employees as a
where a.emp_no in (select emp_no from dept_manager where to_date = '9999-01-01' and dept_no= (select dept_no
																							from departments
                                                                                            where dept_name = 'development'));
-- 단일행으로 만들어서 서브쿼리 where 하는게 좋다.

/*
다중 행 서브쿼리
결과값이 2건이상 출력되는 것을 말한다.
다중행 서브쿼리는 쿼리에 결과가 여러건 출력되기 때문에 
단일행 연산자를 사용할 수 없다.
별도의 연산자를 사용해야 한다 ex) in
*/

select * from employees;
select * from titles;

-- join
select a.emp_no, a.first_name, b.title
from employees as a
inner join titles as b
on a.emp_no = b.emp_no;

-- ㄴ 위 내용을 인라인 뷰로 결과를 출력해 주세요(from 서브쿼리)
select a.emp_no, a.first_name, b.title
from employees as a, (select * from titles) as b
where a.emp_no = b.emp_no;

-- 문제 1
-- 직원 테이블에서 부서 팀장만 출력 하시오.
-- join사용, 단 현재 근무중인 사람만 출력

select * from dept_manager;
select e.*, dm.dept_no as 부서번호
from employees as e
inner join dept_manager as dm
on e.emp_no = dm.emp_no
where dm.to_date = '9999-01-01';

-- 문제 2
-- 문제 1을 인라인뷰로 출력하시오.
select *
from employees as a, (select *
						from dept_manager
							where to_date = '9999-01-01') as b
where a.emp_no = b.emp_no;

-- 스칼라 서브쿼리(select 절에 사용하는 서브쿼리)
-- select 절에 서브쿼리를 사용하여 하나의 컬럼처럼 사용하기 위한 목적
-- join의 대체 표현식으로 자주 사용하지만, 성능 면에서 좋은 편이 아니다.
-- 스칼라 서브쿼리 쓸 때도 단일 행으로 변경해야 한다.
select*, (select dept_name 
		from departments as b 
		where a.dept_no = b.dept_no) as '부서명'
from dept_manager as a
where to_date ='9999_01_01';

-- 스칼라 서브쿼리 사용해서 결과를 뽑아주세요.
-- 문제, employees 테이블에서 emp_no, first_name, (타이틀명)
select * from employees;
select * from dept_emp;
select * from titles;
-- 서브쿼리는 단일행으로 변경해야 한다. (title)
select a.emp_no, a.first_name, (select b.title 
								from titles 
								as b
                                where a.emp_no = b.emp_no
                                group by emp_no) as 직함
from employees as a;

-- 단일행인지 검증해보기
-- 중복된 값이 나오면 안된다.
select title from titles group by title;

-- 문제내기
-- 1. 중첩 서브쿼리(nested, where절에)
-- 예
select emp_no, dept_no
from dept_emp
where dept_no = (select dept_no from departments where dept_name = 'development');

select * from employees;
select * from dept_emp;
select * from titles;
select * from departments;
-- senior Engineer 뽑기
select *
from employees as a
where a.emp_no in (select emp_no from titles where title = 'Senior Engineer');

-- 2. 인라인 뷰(inline, from절에)
-- 예
select *
from employees as a, (select *
						from dept_manager
							where to_date = '9999-01-01') as b
where a.emp_no = b.emp_no;
-- emp_no, first_name, title뽑기
select e.emp_no, e.first_name, t.title
from employees as e, (select title, emp_no from titles) as t
where e.emp_no = t.emp_no;

-- 3. 스칼라 서브쿼리(scalar, select절에)
-- 예
select a.emp_no, a.first_name, (select b.title 
								from titles 
								as b
                                where a.emp_no = b.emp_no
                                group by emp_no) as 직함
from employees as a;

-- emp_no, first_name, title, 부서번호 뽑기
select e.emp_no, e.first_name, t.title, (select d.dept_no from dept_emp as d where e.emp_no=d.emp_no group by emp_no) as 부서번호
from employees as e, (select title, emp_no from titles) as t
where e.emp_no = t.emp_no;

-- emp_no, first_name, title, 부서번호 , 부서명 뽑기
select e.emp_no, e.first_name, t.title, (select d.dept_no from dept_emp as d where e.emp_no=d.emp_no group by emp_no) as 부서번호, (select dn.dept_name from departments as dn where dn.dept_no = d.dept_no group by dept_no) as 부서명
from employees as e, (select title, emp_no from titles) as t, (select dept_no, emp_no from dept_emp) as d
where e.emp_no = t.emp_no and e.emp_no = d.emp_no;

-- pr
select e.emp_no, e.first_name, t.title, (select d.dept_no from dept_emp as d where e.emp_no=d.emp_no group by emp_no) as 부서번호, (select dn.dept_name from departments as dn where dn.dept_no = d.dept_no group by dept_no) as  부서명
from employees as e, (select title, emp_no from titles) as t, (select dept_no, emp_no from dept_emp) as d
where e.emp_no = t.emp_no and e.emp_no = d.emp_no;



-- 연습문제
# 서브쿼리 문제 - 6

-- 중첩 
-- 직급이 Senior Engineer 인 직원의 정보만 출력하기
select *
from employees
where emp_no in (select emp_no
                    from titles
                    where title = 'Senior Engineer');

--
select *
from employees
where emp_no in (select emp_no
					from titles
					where title = 'Senior Engineer');



-- 인라인뷰
-- 연봉이 80_000이상인 사람의 정보만 출력하시오 ( employees 테이블 사용하기 )
select e.emp_no, e.last_name, e.gender, s.salary
from employees as e, (select *
                        from salaries
                        where salary >= 80000
                        group by emp_no) as s
where e.emp_no = s.emp_no;

-- 추가 문제 
-- 위 쿼리를 JOIN 문으로 변경해서 출력해보세요 (query cost 값 비교 해보기 !!! )



-- 스칼라 
-- 직원의 사번과 last_name, 연봉을 출력하라 
select e.emp_no, e.last_name, (select s.salary
                                from salaries as s
                                where e.emp_no = s.emp_no
                                and to_date = '9999-01-01'
                                group by emp_no) as '연봉'
from employees as e;


-- 중첩 서브쿼리
-- 개발팀 manager 중 2000년 1월 1일 이전 퇴사자
select *
from employees as e
where e.emp_no = (select emp_no
                    from dept_manager
                    where to_date < '2000-01-01' and dept_no = (select dept_no
                                                                from departments
                                                                where dept_name = 'development'));

-- 인라인 뷰
-- 직원 테이블에서 2000년 1월 1일 이전 퇴사한 부서 팀장만 출력
select *
from employees as e, (select *
                        from dept_manager
                        where to_date < '2000-01-01') as b
where e.emp_no = b.emp_no;






-- 스칼라 서브쿼리
-- 직원 테이블에서 emp_no, first_name 출력하고 알맞은 부서번호 dept_emp 테이블에서 출력
select e.emp_no, e.first_name, (select d.dept_no
                                from dept_emp as d
                                where e.emp_no = d.emp_no
                                group by emp_no) as 부서번호
from employees as e; 

-- 중첩 서브쿼리
-- 직함이 Senior Enginner인 직원 정보 출력
select *
from employees as a
where emp_no in (select emp_no
                from titles as b
                where title = 'Senior Engineer');

-- 인라인 뷰
-- d001 부서의 역대 매니저 출력
select a.emp_no, a.first_name, b.dept_no
from employees as a, (select *
                        from dept_manager
                        where dept_no = 'd001') as b
where a.emp_no = b.emp_no;

-- 스칼라 서브 쿼리
-- 각 직원들의 최고 연봉을 출력
select a.emp_no, a.first_name, (select b.salary
                                from salaries as b
                                where a.emp_no = b.emp_no
                                group by emp_no
                                having max(salary)) as '최고 연봉'
from employees as a;

-- 중첩
-- employees 테이블에서 title이 Staff이고 사원번호가 1002인 직원 출력
select *
from employees as e
where e.emp_no = (select emp_no
                    from titles
                    where title = 'staff'
                    and emp_no = 10002);




-- 인라인 뷰
-- 직원 테이블에서 퇴사한 직원 출력
select *
from employees as a, (select *
                        from dept_emp
                        where to_date <> '9999-01-01') as b
where a.emp_no = b.emp_no;


-- 스칼라 서브 쿼리
-- employees 테이블에서 퇴사한 직원들의 퇴사일을 출력 
select e.emp_no, (select t.to_date
                from titles as t 
                where t.emp_no = e.emp_no
                and t.to_date <> '9999-01-01'
                group by emp_no
                ) as '퇴사일'
from employees as e;



-- 스칼라 ( 현재 근무중인 사람만 emp_no , first_name , gender 출력
select e.emp_no, e.first_name, e.gender,(select d.to_date
                                        from dept_emp as d
                                        where e.emp_no = d.emp_no 
                                        and d.to_date = '9999-01-01'
                                        group by d.emp_no) as 현재근무중인사람
from employees as e;

-- 인라인 dept_emp 테이블에서 현재 근무중인 사람의 last_name과 gerder 출력
select d.emp_no, d.dept_no,d.from_date,d.to_date , e.last_name, e.gender
from dept_emp as d, (select *
                     from employees) as e
where d.emp_no = e.emp_no
and d.to_date = '9999-01-01';

-- 중접 emp_no 11111번의 타이틀 정보 출력
select *
from titles as t
where t.emp_no = (select emp_no
                 from employees as e
                 where emp_no = 11111);







-- 문제 1 중첩 where
--  최고연봉을 받는 사람의 정보를 출력해주세요
-- employees , departments
select * 
from employees as e
where e.emp_no in (
                    select emp_no
                    from salaries as s
                    where salary = (select max(salary) from salaries)

);

-- 문제 2 인라인뷰 from
-- 위의 문제를 인라인뷰로 만들기
select *
from employees as e,(select *
                        from salaries 
                            where salary = (select max(salary) from salaries)) as s
where e.emp_no = s.emp_no;

-- 문제 3 스칼라 select
-- 각 사원의 정보에 초봉정보까지 포함
select *,(select s.salary
                from salaries as s
                    where e.emp_no = s.emp_no
                     group by emp_no) as 연봉
from employees as e;








-- 1. 중첩 서브쿼리(nested, where절에)
-- senior Engineer 뽑기
select *
from employees as a
where a.emp_no in (select emp_no from titles where title = 'Senior Engineer');
-- 2. 인라인 뷰(inline, from절에)
-- emp_no, first_name, title뽑기
select e.emp_no, e.first_name, t.title
from employees as e, (select title, emp_no from titles) as t
where e.emp_no = t.emp_no;
-- 3. 스칼라 서브쿼리(scalar, select절에)
-- emp_no, first_name, title, 부서번호 뽑기
select e.emp_no, e.first_name, t.title, (select d.dept_no from dept_emp as d where e.emp_no=d.emp_no group by emp_no) as 부서번호
from employees as e, (select title, emp_no from titles) as t
where e.emp_no = t.emp_no;

-- emp_no, first_name, title, 부서번호 , 부서명 뽑기
select e.emp_no, e.first_name, t.title, (select d.dept_no from dept_emp as d where e.emp_no=d.emp_no group by emp_no) as 부서번호, (select dn.dept_name from departments as dn where dn.dept_no = d.dept_no group by dept_no) as 부서명
from employees as e, (select title, emp_no from titles) as t, (select dept_no, emp_no from dept_emp) as d
where e.emp_no = t.emp_no and e.emp_no = d.emp_no;








-- 문제 1 (중첩쿼리 사용)
-- 현재 Human Resources부서에서 근무중인 직원 조회
select *
from employees 
where emp_no in (select emp_no
                from dept_emp
                where dept_no = 'd003'
                and to_date = '9999-01-01');


-- 문제 3 (스칼라 서브쿼리)
-- 부서 매니저의 생년월일 조회
select d.dept_no, d.emp_no, (select e.birth_date
                                from employees as e
                                where d.emp_no = e.emp_no) as '생년월일'
from dept_manager as d;


use shopdb;
select * from membertbl;
select * from usertbl;
select * from buytbl;
desc usertbl;
desc buytbl;
SELECT * FROM membertbl WHERE memberId IN('jsa', 'Dang');

select *
from usertbl as a
inner join buytbl as b
on a.username = b.username
where a.addr = '대구';


