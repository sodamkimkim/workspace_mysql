 ﻿-- 참고.. 10건만 출력하기
 select * from employees limit 10;
 
 -- 그룹함수, 그룹바이, having절
 
 -- Group by 절
 -- 그룹바이 절은 데이터들을 원하는 그룹으로 나눌 수 있다.
 -- 나누고자 하는 그룹의 컬럼명을 SELECT절과 GROUP BY 절 뒤에 추가하면 된다.
 -- ** 참고로 집계함수쓸 때는 굳이 그룹바이 안해도 된다.
 
 -- DISTINCT와 GROUP BY 절
 -- DISTINCT 는 주로,, 중복을 제거하기 위해서 사용한다.
 -- 그룹바이는 데이터를 그룹핑해서 그 결과를 가져오는데에 사용한다.
 -- 하지만 두 작업은 조금만 생각해 보면, 동일한 형태의 작업이라는 것을 쉽게 알 수 있고,
 -- 일부 작업의 경우 DISTINCT로 처리할 수도 있다.
 
 -- HAVING절 --> cf. where
 -- where 절에서는 집계함수를 사용할 수 없다.
 -- having 절은 집계함수를 가지고 조건을 비교할 때 사용한다.
 -- having 절은 group by절과 함께 사용된다.
 use employees;
 show tables;
SELECT 
    *
FROM
    departments;
SELECT 
    *
FROM
    dept_emp;

SELECT 
    *
FROM
    dept_emp AS a
        INNER JOIN
    departments AS b ON a.dept_no = b.dept_no;
 
SELECT 
    *
FROM
    dept_manager;
SELECT 
    *
FROM
    salaries;
SELECT 
    *
FROM
    titles;
 
 -- 합계함수 문제 풀어보기
SELECT 
    CONCAT(COUNT(*), '명') AS '전체 직원수',
    MIN(hire_date) AS '최초 고용일',
    MAX(hire_date) AS '가장 최근 고용일'
FROM
    employees;

 -- 문제 2 .gender로 그룹핑
SELECT 
    gender
FROM
    employees
GROUP BY gender;
 
 -- 문제 3. 남성과 여성 수, gender를 표시하세요.
SELECT 
    gender,
    CONCAT(COUNT(gender = 'M'), '명') AS male,
    CONCAT(COUNT(gender = 'F'), '명') AS female
FROM
    employees
GROUP BY gender;

-- 문제4. 고용일자로 그룹핑
SELECT 
    *
FROM
    employees
GROUP BY hire_date;

-- 문제5. hire_date가 같은 직원의 명수를 표시하시오.
SELECT 
    *, CONCAT(COUNT(*), '명') AS 동기
FROM
    employees
GROUP BY hire_date;

-- 문제6. 위 쿼리에서 남성과 여성을 구분해서 결과값을 구하시오. --> group by 기준 2개
SELECT 
    *, CONCAT(COUNT(*), '명') AS 동기
FROM
    employees
GROUP BY hire_date , gender
ORDER BY hire_date ASC;

SELECT 
    *
FROM
    salaries;
desc salaries;

-- 급여 테이블에서
-- 총 건수, 총 급여, 평균 급여, 최고 연봉자 금액, 최소 연봉자 금액 한 테이블에 표시@@
SELECT 
    CONCAT(COUNT(*), '건') AS '총 건수',
    SUM(salary) AS '총 급여',
    CONCAT(ROUND(AVG(salary), 2), '천원') AS '평균 급여',
    CONCAT(MAX(salary), '천원') AS maxSalary,
    CONCAT(MIN(salary), '천원') AS minSalary
FROM
    salaries;

-- 데이터 검증
-- 그룹핑 하다보면 잘못된 결과 얻을 수 있으니까
-- 하나씩 잘라서 검증해보는 습관 가지자.
SELECT 
    MAX(salary)
FROM
    salaries;

-- having절 연습
-- salary테이블에서 연봉을 10번이상 받은 직원들을 출력하시오.
SELECT 
    *, COUNT(emp_no) AS '횟수'
FROM
    salaries
GROUP BY emp_no
HAVING COUNT(emp_no) >= 10
ORDER BY emp_no ASC
LIMIT 30;

-- 문제
SELECT 
    *
FROM
    titles;
SELECT 
    COUNT(*)
FROM
    titles;
-- 10만명 이상 사용하고 있는 직함의 이름과 직원의 수를 출력하시오.
SELECT 
    title, CONCAT(COUNT(emp_no), '명') AS '직원 수'
FROM
    titles
GROUP BY title
HAVING COUNT(emp_no) >= 100000
ORDER BY title ASC;

-- 5만명 이상 근무하고 있는 부서의 부서 번호와 부서 소속 사원의 수를 출력하시오!!
SELECT 
    a.dept_no AS 부서번호,
    b.dept_name AS 부서이름,
    CONCAT(COUNT(a.emp_no), '명') AS '소속사원수'
FROM
    dept_emp AS a
        INNER JOIN
    departments AS b ON a.dept_no = b.dept_no
GROUP BY a.dept_no
HAVING COUNT(*) >= 50000
ORDER BY a.dept_no ASC;

SELECT 
    *
FROM
    dept_emp;
-- 현재 근무중인 사람들만 출력하시오
SELECT 
    *,
    CONCAT(COUNT(*), '명') AS '현재 근무중인 사람 수'
FROM
    dept_emp
WHERE
    to_date <> '9999-01-01';

-- 각 부서별 과거의 매니저 수를 구하시오(퇴사자)
-- 같지 않다 is <> in MySQL
SELECT 
    *
FROM
    dept_manager;

SELECT 
    CONCAT(COUNT(*), '명') AS 퇴사매니저수
FROM
    dept_manager
WHERE
    to_date <> '9999-01-01';

-- 그룹함수, 그룹바이, having절 + Join써서 문제 만들기
-- 연봉 높은 순 top5 부서와 그 연봉 조회하기
-- 과정1. dept_emp와 salaries 조인
SELECT 
    e.emp_no, e.dept_no, s.salary
FROM
    dept_emp AS e
        INNER JOIN
    salaries AS s ON e.emp_no = s.emp_no;

-- 과정 2. dept_emp랑 salaries 조인한거랑 departments 조인하기
SELECT 
    es.emp_no, es.dept_no, es.salary, d.dept_name
FROM
    (SELECT 
        e.emp_no, e.dept_no, s.salary
    FROM
        dept_emp AS e
    INNER JOIN salaries AS s ON e.emp_no = s.emp_no) AS es
        INNER JOIN
    departments AS d ON es.dept_no = d.dept_no;

-- 과정 3. 최종적으로 원하는 값 뽑아내기..
SELECT 
    ccc.dept_name, ccc.salary
FROM
    (SELECT 
        es.emp_no, es.dept_no, es.salary, d.dept_name
    FROM
        (SELECT 
        e.emp_no, e.dept_no, s.salary
    FROM
        dept_emp AS e
    INNER JOIN salaries AS s ON e.emp_no = s.emp_no
    LIMIT 50000) AS es
    INNER JOIN departments AS d ON es.dept_no = d.dept_no) AS ccc
GROUP BY ccc.dept_name
ORDER BY ccc.salary DESC
LIMIT 5;
--

-- 위 문제 view 만들어서 해보기..
-- 과정1. dept_emp와 salary 합친 view생성 -->(1)
drop view e_s_view;
CREATE VIEW e_s_view AS
    SELECT 
        e.emp_no, e.dept_no, s.salary
    FROM
        dept_emp AS e
            INNER JOIN
        salaries AS s ON e.emp_no = s.emp_no
    LIMIT 50000;

-- 과정2. (1)의 view와 departments 조인
drop view e_s_d_view;
CREATE VIEW e_s_d_view AS
    SELECT 
        es.emp_no, es.dept_no, es.salary, d.dept_name
    FROM
        e_s_view AS es
            INNER JOIN
        departments AS d ON es.dept_no = d.dept_no;

-- 과정3. 원하는 값 뽑아내기
SELECT 
    *
FROM
    e_s_d_view;

SELECT 
    dept_name, salary
FROM
    e_s_d_view
GROUP BY dept_name
ORDER BY salary DESC
LIMIT 5;



-- having.. 조건문 집계쓸때 많이 쓴다.
select * from salaries;

-- 연봉 높은 5명 부서 번호 출력하기
-- dept_emp 와 salaries 조인필요
select a.dept_no, s.salary
from dept_emp as a
inner join salaries as s
on a.emp_no = s.emp_no
having s.salary >=100000
order by a.dept_no desc
limit 5;


