-- 문제 1. shopdb_1 데이터 베이스 생성
-- 문제 2. membertbl 이라는 테이블 생성
-- 문제 3. productTbl 테이블 생성
-- 문제 4. 간단한 테이블 생성 --> 필드 2개 이상
-- 문제 5. 간단한 테이블 생성 --> 필드 3개 이상, primary key 지정

create database shopdb_1;
USE shopdb_1;
create table membertbl(
memberId int not null,
memberName char(8),
primary key(memberId)
);
desc membertbl;

create table producttbl(
productId int not null,
productName char(10) not null,
primary key(productid)
);
desc producttbl;

