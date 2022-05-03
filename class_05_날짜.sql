-- MYSQL DATE FUNCTION
-- 현재 날짜를 출력하는 함수(년 월 일)
select curdate();
select current_date();


-- 현재 시간을 출력하는 함수(시 분 초)
select curtime();
select current_time();

select day("2017-06-15"); -- 15출력. day는 일자를 반환하는 함수이다.
select day(current_date()); -- 오늘의 day를 알려줌


select week("2017-06-15");
select week(current_date()); -- ? 18출력됨 확인필요!!!!!!!!!!!!!!!
-- 요일 (월 : 0)
select weekday("2017-06-15");
select weekday(curdate()); -- 오늘 화요일이라서 1나옴.




-- 날짜 시간 다 뽑음
select now();
select sysdate();

-- 인수에 따라서 datetime 값을 반환
select timestamp("2019-06-15","13:10:11"); -- 문자열을 timestamp라는 타입으로 반환하는 거임.

select timediff("13:10:11","13:10:10"); -- 00:00:01 출력됨. 시간 차이 반환해주는 거임.
select timediff("2022-05-03 13:10:11","2022-01-03 13:10:10");
select timediff(now(),"2021-01-03 13:10:10"); -- 최대범위확인필요!!!!! 

select now();
-- 오늘날짜에서 10일 빼고 더하기
select subdate(now(),interval 10 day ); -- 날짜빼기
select date_add(sysdate(), interval 10 day); -- 날짜더하기

select system_user();
select session_user();
select current_user();
select version();

-- null이면 "Hello"또는 "x"넣기
select nullif("Hello",null);
select nullif("x",null);


-- 공휴일로부터 남은 날짜 계산하기
select concat('어린이날', 'D-',day("2022-05-05") - day(now()));