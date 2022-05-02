-- C R U D

-- 데이터 생성 --> 우리가 만든 db안에, table안에,, 데이터 넣는다.
-- insert
desc memberTBl;

-- <c>
insert into membertbl values("Dang","탕탕이","경기도 부천시");
insert into membertbl values('Han','한주연','부산시 해운대구');
insert into membertbl(memberAddress, memberName, memberId) values('서울시 상암동', '지운이', 'jee');
select * from membertbl;
desc membertbl;
-- 오류 구문(memberid, membername 필드 설계할 때, not null로 설계했기 때문에, id만 넣으면 name값 필요해서 에러뜬다.)
insert into membertbl(memberid) values("1"); --> (x)
insert into membertbl(memberId, memberName) values("kee2", "홍길삼");
select * from membertbl;

-- <R>
-- 한 건에 대한 데이터 조회를 어떻게 할까?
select * from membertbl where memberId = "jee";

-- 한 건에 대한 조회 + 조건절
select memberName
from membertbl
where memberId = "jee";

-- <D>
-- 한 건에 대한 데이터 삭제
delete 
from membertbl
where memberId = "kee2";

select * from membertbl;

-- 전체에 대한 데이터 삭제
delete
from membertbl;

select * from membertbl;
truncate membertbl;

-- <U>
-- 한 건에 대한 데이터 수정
update memberTbl 
set memberName = "홍길동"
where memberid = "jee"; -- primary key로 조건절 작성
select * from membertbl;

-- 전체 데이터에 대한 값 수정
update memberTbl
set memberAddress = '';
-- 조건문을 적지 않으면 모두 수정된다.
select * from membertbl;

desc producttbl;
-- 문제 1 producttbl에 데이터를 3건 입력해 주세요.

insert into producttbl(productId,productName,cost) values("1","입력1",3000);
insert into producttbl values("2","입력2",3000,"220502","네이버",5);
select * from producttbl;
-- 문제 2 producttbl에 데이터를 수정해 주세요.
-- 문제 3 producttbl에 데이터를 삭제해 주세요.
delete from producttbl;

-- 불필요한 컬럼 삭제하는 방법
alter table producttbl
drop makeDate;
desc producttbl;

insert into producttbl values(1,"세탁기",10,"엘지",10);
insert into producttbl values(2,"컴퓨터",90,"삼성",2);
insert into producttbl values(3,"세탁기",80,"엘지",100);

-- 검색
select *
from producttbl
where productId = 2;

select cost
from producttbl
where productId = 1;

select *
from producttbl
where productId = 1;
-- 수정
update producttbl
set productName = "세탁기1"
where productId = 1;
select * from producttbl;

desc producttbl;
-- 삭제
delete
from producttbl
where productId = 1;
select * from producttbl;

