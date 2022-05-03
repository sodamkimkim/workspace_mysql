-- AND와 OR
SELECT 
    *
FROM
    membertbl;

insert into membertbl values('jsa','김주한','부산시 진구');

-- 이름 홍길동, 주소가 부산시 진구
SELECT 
    *
FROM
    membertbl
WHERE
    membername = '홍길동'
        AND memberaddress = '부산시 진구';
-- 아무것도 안나온다.

SELECT 
    *
FROM
    membertbl
WHERE
    memberaddress = '부산시 진구'
        OR memberaddress = '경기도 부천시';

-- 주소가 부산시 진구 or 경기도 부천시 and 이름이 김주한
SELECT 
    *
FROM
    membertbl
WHERE
    (memberaddress = '부산시 진구'
        OR memberaddress = '경기도 부천시')
        AND membername = '김주한';

-- 샘플 테이블 생성
CREATE TABLE memberCart (
    id INT NOT NULL AUTO_INCREMENT, -- **
    name VARCHAR(30) NOT NULL,
    amount INT NOT NULL,
    PRIMARY KEY (id)
);

desc memberCart;
select *
from memberCart;

-- 테이블에 컬럼 추가
alter table memberCart
add productname varchar(30) not null;

-- 테이블에 컬럼명을 수정해 보자
alter table membercart rename column name to name2;

-- 테이블에 컬럼명 삭제해 보자
alter table membercart
drop column name2;

-- 테이블 이름 변경하기
rename table memberCart to myCart; -- 이 두줄 결과는 똑같지만
alter table myCart rename shopCart; -- 되도록 이걸로 쓰자!

-- 데이터 입력
insert into shopCart values(1, 1, '청바지');
select * from shopCart;
insert into shopCart(amount, productName) values(2, '운동화'); -- pk인 id값 안넣었는데도 에러안남. 왜냐하면 auto_increment 때문이지!(자동 1씩 증가)
insert into shopCart(amount, productName) values(12, '점퍼');
insert into shopCart(amount, productName) values(3, '휴대폰');
insert into shopCart(amount, productName) values(5, '지갑');
desc shopCart;

drop table shopCart;
-- Bettween
select *
from shopCart
where amount between 2 and 5;

select * from membertbl;
select * from buytbl;
select * from producttbl;
