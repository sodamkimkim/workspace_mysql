drop database movieInfo;
create database movieInfo;
use movieInfo;
drop table movie;
drop table person;
drop table role;

create table movieINfo(
movieinfoNum int not null primary key,
영화이름 varchar(30) not null,
발매 int not null,
foreign key(releaseNum) references movieRelaseInfo(releaseNum),
movieplotNum int not null,
foreign key(movieplotNum) references moviePlot(movieplotNum),
reportNum int not null,
foreign key(reportNum) references moviereport(reportNum),


-- actorINfo, personInfo
감독이름 varchar(30), -- staffNum
-- staffINfo, personInfo
대표배우이름 varchar(30)-- actorNum

);
create table movieReleaseInfo(
releaseNum int not null primary key,
movieinfoNum int not null,
개봉연도 int not null,
개봉월 int not null
);

create table moviePlot(
movieplotNum int not null primary key,
movieinfoNum int not null,
줄거리 varchar(500)
);

create table movieReport(
reportNum int not null primary key,
movieinfoNum int not null,
매출액 int not null,
관객수 int not null,
평점 decimal(3,1) not null,
review1 varchar(500),
review2 varchar(500),
review3 varchar(500)
);

-- <용어 정의>
-- crew : 배우, staff포괄
-- actor : 배우
-- staff : 배우외 제작진(감독 포함)

create table actorRole(
actorroleNum int not null primary key,
movieinfoNum int not null,
역할이름 varchar(30),
-- actorINfo
actorNum int not null
);

create table actorINfo(
actorNum int not null primary key,
personNum int not null, 
대표작품 varchar(30), 
대표역할 int 
);
create table staffINfo(
staffNum int not null primary key,
personNum int not null,
대표작품 varchar(30)
);
create table personInfo(
personNum int not null primary key,
이름 varchar(30) not null,
주민등록성별 varchar(30) not null,
출생년도 int,
키 decimal(4,1),
몸무게 decimal(10,1),
배우자 varchar(30)
);

-- 배우/감독의 대표자, 대표역할 조회하려면?




-- alter table person modify 출생년도 int;
insert into person values(1,'이정재',1978,180.0,70.0,null);
insert into person values(2,'박소담',1995,165.2,45.0,null);
insert into person values(3,'최우식',1996,180.0,60.0,null);
insert into person values(4,'송광호',1972,180.0,80.0,null);

insert into person values(5,'조여정',1972,180.0,80.0,null);
insert into person values(6,'이선균',1972,180.0,80.0,null);
insert into person values(7,'이정은',1972,180.0,80.0,null);
insert into person values(8,'한지민',1972,180.0,80.0,null);
insert into person values(9,'공유',1972,180.0,80.0,null);
insert into person values(10,'전지현',1972,180.0,80.0,null);
insert into person values(11,'김혜수',1972,180.0,80.0,null);
insert into person values(12,'하정우',1972,180.0,80.0,null);

insert into person values(13,'봉준호',1972,180.0,80.0,null);
insert into person values(14,'김지운',1972,180.0,80.0,null);
insert into person values(15,'박대민',1972,180.0,80.0,null);
insert into person values(16,'최동훈',1972,180.0,80.0,null);
insert into person values(17,'류승완',1972,180.0,80.0,null);
insert into person values(18,'이용주',1972,180.0,80.0,null);

insert into movie values(1,'기생충',2019,300000000,30000000,10.0);
insert into movie values(2,'밀정',2010,300000000,30000000,10.0);
insert into movie values(3,'괴물',2005,300000000,30000000,10.0);
insert into movie values(4,'특송',2007,300000000,30000000,10.0);
insert into movie values(5,'도둑들',2007,300000000,30000000,10.0);
insert into movie values(6,'베를린',2020,300000000,30000000,10.0);
insert into movie values(7,'서복',2021,300000000,30000000,10.0);
-- insert into movie values(8,'test',2021,300000000,30000000,100.0); -- > 불가능


-- 구분의 값 예시) 감독, 주연, 조연, 보조출연자, 보조출연자 --> 정해놓자
insert into role values(1,1,'감독','감독',13);
insert into role values(2,1,'주연','기택',4);
insert into role values(3,1,'조연','동익',6);
insert into role values(4,1,'조연','기우',3);
insert into role values(5,1,'조연','기정',2);
insert into role values(6,1,'조연','문광',7);
insert into role values(7,1,'조연','연교',5);

insert into role values(8,2,'감독','감독',14);
insert into role values(9,2,'주연','이정출',4);
insert into role values(10,2,'조연','김우진',9);
insert into role values(11,2,'조연','연계순',8);


select * from movie;
select * from role;
select * from person;

-- role과 person을 join하자.
select * 
from role as a
inner join person as b
on a.사람번호 = b.등록번호;

-- movie랑 role을 join하자.
select *
from movie as a
inner join role as b
on a.영화번호 = b.영화번호;

-- person과 movie join
-- 송광호관련조회해보자
-- 송광호 개인정보를 출력하고, 출연한 영화를 조회해보자.
select a.*, b.영화이름
from person as a
inner join movie as b
on a.