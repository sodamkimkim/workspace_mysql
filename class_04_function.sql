-- mysql function

-- MYSQL String Function
select ascii('b');

select char_length('My SQL TEST') as 문자길이;
select char_length('홍길동') as 이름;
select concat('boot', 'class', '100%') as class_name;
select concat_ws('->', 'boot', 'class', '100%') as class_name;
-- 문자열 목록 내에서 q 를 검색할 수 있다.
select find_in_set('s', 's,q,l');


select format(250500.5634, 60);
-- 숫자 형식은 "#.##.##.##"(소수점 2자리 반올림)으로 지정한다.

select lcase('HELLO JAVA');
select ucase('hello java');


select trim('    M Y S Q L         ');
select replace('   aaa 11      ', ' ', '');


-- inner join 2
 select a.username, a.addr, a.mobile, b.prodname, b.price, b.amount, char_length(a.username)
 from usertbl as a
 inner join buytbl as b
 on a.username = b.username;