USE shopdb;

-- 데이터 베이스를 생성하는 구문
create database shopdb_1;

-- 데이터 베이스를 삭제하는 구문
-- drop database shopdb_1;
-- 포커스해서 ctrol + shift + enter하면 그거만 실행

-- 테이블을 생성하는 구문
create table 테이블명(
	필드명 필드타입,
    필드명 필드타입,
    primary key(필드명)
);

-- 테이블 삭제 방법
-- drop table membertbl_1;


-- mamberTBl 테이블 생성
CREATE TABLE memberTBL (
    memberId CHAR(8) NOT NULL,
    memberName CHAR(5) NOT NULL,
    memberAddress CHAR(20),
    PRIMARY KEY (memberId)
    -- primary key는 유일해야한다.
);

-- select 구문
select * from membertbl;

-- 테이블 구조 확인 방법
desc membertbl;

-- 테이블 만들기 2
CREATE TABLE productTBL (
    productId INT not null,
    productName char(4) not null,
    cost int not null,
    makeDate date,
    company char(5),
    amount int,
    primary key(productId)
);
select * from productTbl;
desc productTbl;

insert into membertbl values("Dang","탕탕이","경기도 부천시");
insert into membertbl values('Han','한주연','부산시 해운대구');
insert into membertbl(memberAddress, memberName, memberId) values('서울시 상암동', '지운이', 'jee');
select * from membertbl;
select *
from membertbl
where memberId="Dang";

update membertbl
set membername = "홍길동"
where memberid = "jee";

alter table producttbl
drop makedate;
desc producttbl;
