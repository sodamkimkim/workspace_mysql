-- userTBL, buyTBL 만들기

USE shopdb;
create table userTbl(
	userName char(3) not null,
    birthYear int not null,
    addr char(2) not null,
    mobile char(12),
    primary key(userName)
    );
    
-- 필드 수정, 컬럼 수정PRIMARYPRIMARYPRIMARY
alter table usertbl
modify mobile char(13);
desc usertbl;   

-- 구매 테이블 생성(fk)
CREATE TABLE buyTbl (
    userName CHAR(3) NOT NULL,
    prodName CHAR(3) NOT NULL,
    price INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (username)
        REFERENCES usertbl (username)
);
desc buytbl;

-- userTBL 데이터 입력하기
insert into usertbl values("이승기", 1987,"서울","010-1234-1234");
insert into usertbl values("홍길동", 1911,"부산","010-2222-2222");
insert into usertbl values("이순신", 1999,"대구","010-3333-3333");

select * from usertbl;
select * from buytbl;

-- 구매 테이블 데이터 입력
-- insert into buytbl values("이승기2","운동화",50,1); -- > 안된다!! pk랑 매치 된게 없다.!
insert into buytbl values("이승기",'운동화',50,1);
insert into buytbl values("이승기",'노트북',150,1);
insert into buytbl values("홍길동",'책',10,5);
insert into buytbl values("홍길동",'모니터',200,2);
insert into buytbl values("이순신",'청바지',40,1);
insert into buytbl values("이순신",'책',10,3);
--
select * from buytbl;

