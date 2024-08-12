-- 2nd Highest Salary

select * 
from employee_salary
order by salary desc
limit 1
offset 1;


-- 3rd Highest Salary
select * 
from employee_salary
order by salary desc
limit 1
offset 2;

-- last name starts with M
select *
from employee_demographics
where last_name like 'm%';

-- Total Salary Expenditure of a Company

select sum(salary) Toatal_Salary
from employee_salary;

-- More than 10 Employee in the Department

select count(*) from parks_departments;

select * from employee_salary es
join parks_departments pd
on es.dept_id = pd.department_id
where es.dept_id = 6;

-- This query effectively counts the number of employees in each department and filters the results to display only those departments 
-- with fewer than 6 employees. The combination of the JOIN, GROUP BY, and HAVING clauses allows the query to perform this operation efficiently.

select pd.department_name, count(es.employee_id) as Total_Employee  
from parks_departments as pd
join employee_salary as es
on es.dept_id = pd.department_id
group by pd.department_id
having Total_Employee < 6 ;

-- Highest Salary person and Lowest Salary person

select  max(es.salary) 
from employee_salary es
join parks_departments pd
on es.dept_id = pd.department_id
order by es.salary desc;
 -- desc limit 1;

select Min(salary) from employee_salary order by salary asc; 

select  min(es.salary) 
from employee_salary es
join parks_departments pd
on es.dept_id = pd.department_id
order by es.salary desc;


-- Difference of Highest Salary and Lowest Salary in each department

select pd.department_name, max(es.salary)-min(salary) as Salary_Difference  
from parks_departments as pd
join employee_salary as es
on es.dept_id = pd.department_id
group by pd.department_id;

select pd.department_name, max(es.salary) as Max_Salary  
from parks_departments as pd
join employee_salary as es
on es.dept_id = pd.department_id
where pd.department_name = 'Parks and Recreation'
group by pd.department_id;

select pd.department_name, min(es.salary) as Min_Salary  
from parks_departments as pd
join employee_salary as es
on es.dept_id = pd.department_id
where pd.department_name = 'Parks and Recreation'
group by pd.department_id;


with a  as (
select *
from employee_salary es
join parks_departments pd
on es.dept_id = pd.department_id
where pd.department_name = 'Parks and Recreation'
-- group by pd.department_id
)
select *
from a;

-- wrong use all non-aggregated fields in group by statemen

WITH a AS (
    SELECT es.first_name, es.last_name, max(es.salary), pd.department_name
    FROM employee_salary es
    JOIN parks_departments pd
    ON es.dept_id = pd.department_id
   -- WHERE pd.department_name = 'Parks and Recreation'
    group by es.first_name
)
SELECT *
FROM a;

-- or

WITH a AS (
    SELECT es.first_name, es.last_name, max(es.salary) OVER (PARTITION BY es.last_name) as max_salary, pd.department_name
    FROM employee_salary es
    JOIN parks_departments pd
    ON es.dept_id = pd.department_id
)
SELECT *
FROM a
order by 3 desc;


