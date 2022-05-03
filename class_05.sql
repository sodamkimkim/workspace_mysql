-- MYSQL Numberic Function

select ABS(-252.2);
select * from buytbl;

-- 평균값
select *, sum(price) as 합계 -- 이렇게 하면 이승기에 대한 값처럼 합계(단일행)가 나온다. --> x, * 빼자
from buytbl;

-- 평균값
select sum(price) as 합계
from buytbl;

-- 서브쿼리-> 단일행이 아니라 각각 행별로 합계가 나오게 된다.
select *,(select sum(price) from buytbl) as 총합계 -- sub 쿼리,,
from buytbl;

-- 평균 값
select *, avg(price) as 평균값
from buytbl;

-- 서브 쿼리 -> 단일행이 아니라 각각 행별로 평균값이 나오게 된다.
-- 쿼리가 복잡하기 때문에 수행 속도가 느려질 수 있다.
select *,(select avg(price)from buytbl) as 평균값
from buytbl;

-- 절댓값
select ABS(-252.2);
select * from buytbl;
-- 올림
select ceil(25.12);
-- 반올림
SELECT ROUND(134.523); -- 소숫점 0번째
SELECT ROUND(134.523,1); -- 소수점 1번째 자리까지 처리하라.
-- 버림
select floor(25.81);
select ceil(round(10 - 5) + 5);
-- max
select max(price)
from buytbl;
-- min
select min(price)
from buytbl;

select *
from usertbl as u
left join buytbl as p
on u.username = p.username;

-- buytbl에서 가장 비싼 제품을 구매한 고객이름과 총 결제금액 조회
alter table buytbl
drop maxPay;

select *
from buytbl;

select max(b.price)*b.amount as 젤비싼품목판매액, (select b.username from buytbl where price = max(price))
from buytbl as b
left join usertbl as u
on u.username = b.username;
