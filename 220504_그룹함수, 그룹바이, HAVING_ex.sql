# 그룹함수, 그룹바이, having 절 + JOIN  - 5



```sql

-- 재직자 중에서 가장 연봉이 높은 10명의 직원이름과 연봉을 출력해주세요
select e.emp_no , concat(first_name,"  " ,last_name) as 'name', salary
from employees as e
inner join salaries as s
on e.emp_no = s.emp_no
where to_date = '9999-01-01'
order by salary desc
limit 10;

```





```sql
-- 부서별로 입사 날짜가 가장 빠른 직원번호 출력
select a.emp_no, b.dept_no, a.hire_date
from employees a
inner join dept_emp b
on a.emp_no = b.emp_no
group by b.dept_no
having min(a.hire_date);
```





```sql
-- titles 와 employees를 inner join하고 같은부서의 사람들 수 출력
select t.emp_no, t.title, e.first_name, e.last_name, e.gender,count(t.title) as '같은 부서 사람들 수'
from titles as t
inner join employees as e
on t.emp_no = e.emp_no
group by t.title
having count(t.title);
```





```sql
-- 사원번호가 같고 고용일이 1990-01-01이후인 직원들 출력
select s.emp_no, s.salary, s.to_date, e.hire_date
from salaries as s
left join employees as e
on s.emp_no = e.emp_no
group by s.emp_no
having e.hire_date > '1990-01-01';
```





```sql
-- 연봉 130000 이상 받은 직원
select *
from dept_emp as d
right join salaries as s
on d.emp_no = s.emp_no
where s.salary >= 130000;
```







```sql
-- 2000년도 이전에 입사한사람들의 성별, 최저연봉과 최대 연봉을 구하시오
select e.emp_no , e.gender as 성별 , min(salary) as 최저연봉 , max(salary) as 최대연봉 , s.to_date as 입사일
from employees as e 
inner join salaries as s
on e.emp_no = s.emp_no
group by emp_no 
having to_date <= '2000-01-01'
```


