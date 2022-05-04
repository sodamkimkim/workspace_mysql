-- MY SQL 계정 생성 및 권한 관리

-- 사용자 계정 확인
show databases;
use mysql;

select host, user from user;

-- 1. 사용자 추가 및 권한 세팅(첫번째 방법)
-- localhost하면 이 컴터에서만 접근가능
create user tester1@localhost identified by 'asd123';
-- 권한부여하기
grant select, insert, update, delete on shop_db.* to 'tester1'@'localhost';
-- 이 user는 shop_db말고는 접근 권한 없다.
-- MYSQL 8에서 계정 생성 할 때 주의 (8에서는 계정생성 후-> 모든 권한을 할당 *한번에 안됨*)

-- 2. 모든 DB에 권한 할당, localhost만 접근 허용
create user tester2@localhost identified by 'asd123';
grant all privileges on *.* to tester2@localhost with grant option;
flush privileges;
-- CRUD 모든 권한 줌.
-- *.*모든 DB의 모든 table에 접근 권한줌.

-- 3. ﻿외부에서도 접속할 수 있게 허용된 계정생성하기
create user tester3@'%' identified by 'asd123';
grant all privileges on *.* to tester3@'%' with grant option;
-- localhost대신 '%'

-- 4. 계정 삭제 방법
drop user 'tester3'@'%';
drop user 'tester2'@localhost;

-- ** 참고
-- db connection객체는 여러개 만들 필요가 없다.
-- 보통 여러사람이 공유할 수 있는 싱글톤 패턴으로 설계된다.

-- DB에 만들어진 모든 테이블 확인
use shopdb;
show full tables;

-- 뷰 생성
create view usertbl_view as select username, birthYear, addr from usertbl;
select * from usertbl_view;

use mysql;
select * from user;
create user tendcoding@'%' identified by 'asd123';
grant select on shopdb.usertbl_view to 'tendcoding'@'%';

-- <문제내기>
-- shopdb에서 usertbl이랑 buytbl이랑 inner join후
-- 일정 price이상 구매 고객에 대한 개인 정보 + 구매 정보 출력할 거임.
-- username으로 group하고
-- view로 생성해서
-- employee1에게 권한주기 (외부접근 가능, select만)
use shopdb;
select * from usertbl;
select * from buytbl;
drop view vip_view;
create view vip_view as select a.*, b.prodName, b.price, b.amount from usertbl as a
inner join buytbl as b
on a.username = b.username
where price >=50
group by a.username;

select * from vip_view;

use mysql;
select * from user;
create user employee1@'%' identified by 'asd123';
grant select on shopdb.vip_view to employee1;
-- 문제 끝



