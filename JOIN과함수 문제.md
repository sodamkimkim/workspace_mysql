# JOIN 과 문자열 내장함수 문제 - 1



```sql
-- usertbl기준으로 buytbl left join한다.
-- mobile에서 -빼고 조회
select a.username, a.birthYear, a.addr, replace(a.mobile,'-',''), b.prodname, b.price, b.amount
from usertbl as a
left join buytbl as b
on a.username = b.username;


```





```sql
-- 주소에있는 문자열 글자수 확인하기,
-- amount ascii 값 확인하기. as(별칭)
select u.userName, u.addr as 주소, b.prodName,b.amount, char_length(u.addr) as 주소글자_길이, ascii(b.amount) as amount_ascii
from usertbl as u
inner join buytbl as b
on u.userName = b.userName;
```





```sql
-- usertbl 기준으로 buytbl과 공통되는 userName 출력하고, 글자수 반환하기
select u.userName, char_length(u.userName)
from usertbl as u
left join buytbl as b
on u.userName = b.userName;
```





```sql
-- 전화번호에서 "-" 제거
select a.username, a.addr, replace(a.mobile, '-', ''), b.prodname, b.price, b.amount, char_length(a.username)
 from usertbl as a
 inner join buytbl as b
 on a.username = b.username;
```





```sql
-- '누가 구매한 상품명' 으로 리스트를 만들고, 가격과 수량 조회하기
select concat_ws('가 구매한 ', u.userName, b.prodName) as 'list', b.amount, b.price
from usertbl as u
inner join buytbl as b
on u.userName = b.userName;
```







```sql
-- inner join 3 userName이 홍길동이면 1출력 아니면 0
select *, find_in_set('홍길동', u.userName)
from usertbl as u
inner join buytbl as b
on u.userName = b.userName;
```







```sql
-- usertble을 기준으로 buytbl inner join. 
-- usertbl의 이름과 번호, buytbl의 가격과 수량 데이터를 가져오고, 번호의 문자길이 조회하기
select u.userName, u.mobile, b.price, b.amount, char_length(u.mobile)
from usertbl as u
inner join buytbl as b
on u.userName = b.userName;
```





```sql
-- inner join 1
select u.userName, u.addr, u.mobile, b.prodName, b.price, b.amount, char_length(b.prodName)
from usertbl as u
inner join buytbl as b
on u.userName = b.userName

-- inner join 2
select concat_ws('->',u.userName, u.addr, u.mobile, b.prodName, b.price, b.amount)
from usertbl as u
inner join buytbl as b
on u.userName = b.userName

-- inner join 3
select concat(u.userName, u.addr, u.mobile, b.prodName, b.price, b.amount)
from usertbl as u
inner join buytbl as b
on u.userName = b.userName


```

