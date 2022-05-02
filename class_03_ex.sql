create database shopdb_1;
drop database shpdb_1;
use shopdb_1;
drop database shopdb_1;
create database shopdb;

use shopdb;
CREATE TABLE userTbl (
    userName CHAR(3) NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile CHAR(12),
    PRIMARY KEY (userName)
);

alter table userTbl
modify mobile char(13);
desc userTbl;

CREATE TABLE buytbl (
    userName CHAR(3) NOT NULL,
    prodName CHAR(3) NOT NULL,
    price INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (username)
        REFERENCES usertbl (username)
);

desc buytbl;

-- usertbl 데이터 입력하기
insert into usertbl values("이승기", 1987,"서울","010-1234-1234");
insert into usertbl values("홍길동", 1911,"부산","010-2222-2222");
insert into usertbl values("이순신", 1999,"대구","010-3333-3333");

-- buytbl 데이터 입력하기
insert into buytbl values("이승기",'운동화',50,1);
insert into buytbl values("이승기",'노트북',150,1);
insert into buytbl values("홍길동",'책',10,5);
insert into buytbl values("홍길동",'모니터',200,2);
insert into buytbl values("이순신",'청바지',40,1);
insert into buytbl values("이순신",'책',10,3);