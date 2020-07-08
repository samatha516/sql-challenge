-- List the following details of each employee: employee number, last name, first name, sex, and salary.
select e.emp_no, e.first_name, e.last_name, e.sex, s.salary
  from employees e, salaries s
 where e.emp_no = s.emp_no;

-- List first name, last name, and hire date for employees who were hired in 1986.
-- there are 36150 employees who got hired in 1986
select count(*) from employees
where extract(year from (hire_date)) = '1986'; 

--there are different ways to retrieve the employees who got hired in 1986.
-- using extract
select first_name, last_name, hire_date 
  from employees
 where extract(year from (hire_date)) = '1986';

-- using between
select first_name, last_name, hire_date 
  from employees
 where hire_date between '1986-01-1' and '1986-12-31';
 
-- using >= and <=
select first_name, last_name, hire_date 
  from employees
 where (hire_date >= '1986-01-1' 
   and hire_date <= '1986-12-31');
 
-- List the manager of each department with the following information: department number, department name, 
-- the manager's employee number, last name, first name.
-- there are 2 ways to get the results. 
-- solution 1
select d.dept_no, d.dept_name, e.emp_no, e.first_name, e.last_name
  from departments d,
  	   dept_manager dm,
       employees e
 where d.dept_no = dm.dept_no
   and e.emp_no = dm.emp_no;

-- we actually don't need dept_mgr table as dept_emp table has manager information too. dept_mgr is redundant.
-- solution 2
select d.dept_no, d.dept_name, e.emp_no, e.first_name, e.last_name
  from departments d,
  	   dept_emp de,
       employees e
 where d.dept_no = de.dept_no
   and e.emp_no = de.emp_no
   and e.emp_title = 'm0001';

-- 331,603
select count(*) from dept_emp;
-- 300,024
select count(*) from employees;

-- there are 31,579 employees who work in 2 depratments. That's why dept_emp has 331,603 records.
select emp_no
from dept_emp
group by emp_no
having count(dept_no) > 1;

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
select e.emp_no, e.first_name, e.last_name, d.dept_name
  from departments d,
   	   employees e,
	   dept_emp de
 where d.dept_no = de.dept_no
   and e.emp_no = de.emp_no;
 
-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex 
  from employees
 where first_name = 'Hercules' 
   and last_name like 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, 
-- and department name.
-- 52,245 employees are in sales department
select d.dept_name, e.emp_no, e.first_name, e.last_name
  from departments d,
       employees e,
	   dept_emp de
 where d.dept_no = de.dept_no
   and e.emp_no = de.emp_no
   and d.dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, last name, 
-- first name, and department name.
-- 137,952 employees are working sales and development
select d.dept_name, e.emp_no, e.first_name, e.last_name
  from departments d,
       employees e,
	   dept_emp de
 where d.dept_no = de.dept_no
   and e.emp_no = de.emp_no
   and d.dept_name in ('Sales', 'Development');

-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.
select last_name, count(*) as last_name_cnt
  from employees
 group by last_name
 order by last_name_cnt desc;