use employees;
select * from employees;
select * from titles;
select * from dept_emp;
select * from salaries;
select * from departments;
select * from dept_manager;
desc employees;
desc salaries;
desc dept_emp;
desc departments;
desc titles;
-- 1. 중첩 서브쿼리(nested, where절에)
-- senior Engineer emp_no 뽑기
select a.emp_no as 'senior E'
from employees as a
where a.emp_no in (select emp_no from titles where title = 'Senior Engineer');


-- 2. 인라인 뷰(inline, from절에)
-- emp_no, first_name, title뽑기
select e.emp_no, e.first_name, t.title
from employees as e, (select title, emp_no from titles) as t
where e.emp_no = t.emp_no;


-- 3. 스칼라 서브쿼리(scalar, select절에)
-- emp_no, first_name, title, 부서번호 뽑기
select e.emp_no, e.first_name, t.title, (select d.dept_no from dept_emp as d where e.emp_no=d.emp_no group by emp_no) as 부서번호
from employees as e, (select title, emp_no from titles) as t
where e.emp_no = t.emp_no;

-- 4. 스칼라 서브쿼리(scalar, select절에)
-- emp_no, first_name, title, 부서번호 , 부서명 뽑기
select e.emp_no, e.first_name, t.title, (select d.dept_no from dept_emp as d where e.emp_no=d.emp_no group by emp_no) as 부서번호, (select dn.dept_name from departments as dn where dn.dept_no = d.dept_no group by dept_no) as 부서명
from employees as e, (select title, emp_no from titles) as t, (select dept_no, emp_no from dept_emp) as d
where e.emp_no = t.emp_no and e.emp_no = d.emp_no;

-- 5. -- staff생일 뽑기
select a.emp_no, a.birth_date
from employees as a
where a.emp_no in (select emp_no from titles where title = 'Staff');





select * from employees;
select * from titles;
select * from dept_emp;
select * from salaries;
select * from departments;
select * from dept_manager;
desc employees;
desc salaries;
desc dept_emp;
desc departments;
desc titles;
-- 6. employees inner join salary
-- 직원별 salary뽑기
select e.emp_no,e.first_name, s.salary
from employees as e
inner join salaries as s
on e.emp_no = s.emp_no limit 10;

-- 7. dept_emp left join departments
-- 재직중인 직원별 부서조회
select de.emp_no, de.to_date, de.dept_no, dep.dept_name
from dept_emp as de
left join departments as dep
on de.dept_no = dep.dept_no
where de.to_date<>'9999-01-01';

-- 8. dept_manager left join departments
-- 매니저별 부서이름 뽑기
select dm.emp_no as '매니저 직원번호', dep.dept_name
from dept_manager as dm
left join departments as dep
on dm.dept_no = dep.dept_no;

-- 9. dept_emp inner join departments
-- 직원별 입사일과 부서 조회
select de.emp_no, de.from_date as 입사일, dep.dept_name
from dept_emp as de
inner join departments as dep
on de.dept_no = dep.dept_no;

-- 10. dept_manager right join departments
-- 재직중인 매니저 뽑기
select dm.emp_no, dm.to_date, dep.dept_name
from dept_manager as dm
right join departments as dep
on dm.dept_no = dep.dept_no
where dm.to_date <> '9999-01-01';
