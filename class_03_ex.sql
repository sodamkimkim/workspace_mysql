 use shopdb_1;

-- 불필요한 컬럼 삭제하는 방법
-- alter table producttbl
-- drop makeDate;
-- desc producttbl;

-- 필드 수정, 컬럼 수정
-- alter table usertbl
-- modify mobile char(13);
-- desc usertbl;   

-- 테이블 생성
desc membertbl;
alter table membertbl
drop memberId;

drop table producttbl;
desc buytbl;

-- 연관관계 생성
CREATE TABLE usertbl (
    username CHAR(3) NOT NULL,
    birthyear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile CHAR(12),
    PRIMARY KEY (username)
);
drop table buytbl;
drop table membertbl;
CREATE TABLE buytbl (
    username CHAR(3) NOT NULL,
    prodname CHAR(3) NOT NULL,
    price INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (username)
        REFERENCES usertbl (username)
);

alter table usertbl
modify mobile char(14);

-- CRUD 연습
insert into usertbl values("이승기", 1987,"서울","010-1234-1234");
insert into usertbl values("홍길동", 1911,"부산","010-2222-2222");
insert into usertbl values("이순신", 1999,"대구","010-3333-3333");

insert into buytbl values("이승기",'운동화',50,1);
insert into buytbl values("이승기",'노트북',150,1);
insert into buytbl values("홍길동",'책',10,5);
insert into buytbl values("홍길동",'모니터',200,2);
insert into buytbl values("이순신",'청바지',40,1);
insert into buytbl values("이순신",'책',10,3);

select * from buytbl;
