create database shop_db;
use shop_db;
CREATE TABLE shop_db.product (
    id TINYINT NOT NULL,
    p_name VARCHAR(30) NOT NULL,
    created DATE,
    company VARCHAR(30)
);


-- index
-- data searching할 때,,
-- full-scanning 보다는 <-> primary key나 색인 지정해서 사용하면 => 검색속도 빨라진다.
-- index는 create index해서 사용하고,, unique해야한다.!
create index idx_product_name
on product (p_name);


-- 가상 테이블(뷰 테이블)만들기
select * from product;

-- 데이터 생성
insert into product values(1,'세탁기','2020-12-12','삼성');
insert into product values(2,'냉장고',now(),'엘지');
insert into product values(3,'모니터',curdate(),'삼성');
insert into product values(4,'컴퓨터',curdate(),'삼성');

desc product;

-- 컬럼추가하기
alter table product add input_time timestamp;

-- 데이터베이스 권한 지정할 때 가상테이블 쓴다.
-- 새 테이블을 생성해서 보여주고싶은거만 보여주는 개념.
-- 가상 테이블 생성하기ㅜ
create view product_view
as select p_name, created, company
from product;


desc product_view;
select * from product_view; -- product table에서 view로 참조되는 부분만 보여주는 개념

-- view에서 delete --> 계정에 따라 삭제 권한 조절해주면 된다.
delete from product_view where p_name = '컴퓨터';
select * from product;

-- drop database shop_db;
show databases;

-- drop index --> 인덱스 잘못매겼을 때 삭제하기
-- 우선 index 조회먼저 해보자.
show index from product;
-- index 수정하는 방법
-- 
-- index 삭제하는 방법
alter table product
drop index idx_product_name;

-- 테이블 복사
select * from product;
-- 테이블 조작 테스트 할 때는 복사 먼저 하자!!
create table product_2 select * from product;
select * from product_2;

-- 집계함수
-- ㄴ Group by 사용
use shopdb;
select * from buytbl;
-- userName으로 그룹해서 결과출력해 보자
select *
from buytbl
group by userName;

select *
from buytbl
group by price;

select *
from buytbl
group by amount;

-- 이름으로 묶고, amount가 3이상인 사람들을 출력
select *
from buytbl
where amount >= 3 -- 조건문 먼저 적어서 필터해주고
group by userName; -- 그룹해주기

-- 집계 함수
select count(*) as 판매횟수
from buytbl; -- buytbl의 row가 6개 있다는 뜻임

select userName, sum(price) as '구매 금액'
from buytbl; -- 이렇게 하면 이승기 460 이렇게 찍히는데,, 460은 사람들 모두에 대한 구매 금액 총계이므로,, 이름과 sum불일치임

select userName, sum(price) as '구매 금액' -- group by 사용해서 username - sum 불일치 해결하자!
from buytbl
group by username;



