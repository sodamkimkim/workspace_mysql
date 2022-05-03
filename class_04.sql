use shopdb;
select * from usertbl;
select * from buytbl;

-- inner join
select *
from userTbl
inner join buytbl
on usertbl.userName = buytbl.userName;

-- inner join 2 (a와 b 교집합만 추출)
select a.username, a.addr, a.mobile, b.prodName, b.price, b.amount
from usertbl as a
inner join buytbl as b
on a.userName = b.userName;

-- inner join 3
select *
from usertbl
inner join buytbl
on usertbl.userName = buytbl.username;

select a.userName, a.birthYear, a.addr, b.prodName
from usertbl as a
inner join buytbl as b
on a.userName = b.userName;

-- LEFT JOIN 1
select *
from usertbl as u
left join buytbl as b
on u.username = b.username;

-- userTbl 고객 등록 (usertbl기준으로 left join하면 야스오 구매이력쪽은 null 뜬다.)
select *
from usertbl;
insert into usertbl values('야스오', '2000', '여수','010-1234-1234');

-- LEFT JOIN 2 (b가 not null인 경우만 출력) --> 구매이력 있는 user만 조회하기
select *
from usertbl as u
left join buytbl as b
on u.username = b.userName
where b.username is not null;

-- LEFT JOIN 3 한번 더 복습 ( 구매이력 없는 user조회하기)
select *
from usertbl as u
left join buytbl as b
on u.userName = b.userName
where b.username is null;

select *
from usertbl as u
left join buytbl as b
on u.userName = b.userName
where b.username is null;

-- 구매 테이블 생성할 때, 외래키에 대한 제약을 생성했기 때문에
-- usertbl에 없는 이름으론 등록할 수 없음.
insert into buytbl values('티모', '컴퓨터',100,1);
select * from buytbl;
-- 하지만 구매 테이블을 생성할 때 외래키(FK)를 제약하지 않았다면,
-- insert는 가능하다.

-- left join 3 (buytbl기준 left join --> 구매이력 없는 야스오,, 조건문 안줘도 안나온다)
select *
from buytbl as b -- 기준
left join usertbl as u
on u.username = b.userName
where u.username is not null;

-- RIGHT JOIN 1 --> 
select u.username, b.prodname, b.price, b.amount
from usertbl as u
right join buytbl as b
on u.username = b.username;

select *
from usertbl as u
right join buytbl as b
on u.username = b.username;

-- 곱 집합 Cross join
select *
from usertbl as u
cross join buytbl as b
on u.username = b.username;

-- 곱 집합 cross join 2
select *
from usertbl
cross join buytbl
on usertbl.username = buytbl.username
where usertbl.username is null
or buytbl.username is null;
