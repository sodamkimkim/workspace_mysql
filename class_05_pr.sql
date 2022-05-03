select ABS(-2263.11);

-- 평균값
select sum(price) as price합계
from buytbl;

-- 서브쿼리
select *, (select sum(price) from buytbl) as 총합계
from buytbl;

-- 평균값
select * , (select avg(price) from buytbl) as 제품당price평균
from buytbl;

-- 서브쿼리 --> 단일행이 아니라 각 행별로 평균값이 나온다.
-- 쿼리가 복잡하기 때문에 수행속도가 느려질 수 있다.
select *, (select avg(price) from buytbl) as 평균값
from buytbl;

-- 올림
select ceil(25.12);
-- 반올림
select Round(134.524); -- 소숫점 0번째자리까지 나타냄
select Round(134.524,1); -- 소숫점 1번째자리까지 나타냄
-- 버림
select floor(25.81);

-- max
select max(price) from buytbl;
-- min
select min(price) from buytbl;

select *
from usertbl as u -- 애초에 usertbl에 없는 data는 안뽑힌다.
left join buytbl as b -- usertbl을 기준으로, 매칭되는 buytbl이 없으면 null 
on u.username = b.username;

select *
from buytbl as b -- 애초에 buytbl에 없는 data는 안뽑힌다.
left join usertbl as u 
on u.username = b.username;
-- buytbl을 기준으로, 매칭되는 usertbl이 없으면 null
-- 근데 그럴일 없지, 왜냐면 buytbl의 fk(username)가 usertbl의 pk를 참조하는데
-- buytbl에는 있고 usertbl엔 없는 경우가 있을 수 가 없지. 
-- => buytbl에 대한 매칭값이 usertbl에 무조건 있으므로 null안뜬다.

-- 근데 pk, fk개념 빼고 left join개념만으로 생각해보면
-- buytbl row기준으로 usertbl에 없으면 null나오는게 buytbl기준 left join usertbl의 개념


select *
from usertbl as u
right join buytbl as b
on u.username = b.username;

select *
from buytbl as b
right join usertbl as u 
on u.username = b.username;



