SELECT * FROM practice.bonus;
SELECT * FROM practice.worker;
SELECT * FROM practice.title;

-- Write an SQL query to fetch “FIRST_NAME” from the Worker table using the alias name <WORKER_NAME>
select first_name as worker_name from worker;
-- Write an SQL query to fetch “FIRST_NAME” from the Worker table in upper case.
select upper(first_name) from worker;
-- Write an SQL query to fetch unique values of DEPARTMENT from the Worker table.
select distinct department from worker;
-- Write an SQL query to print the first three characters of  FIRST_NAME from the Worker table.
select substring(first_name,1,3) from worker;
-- Write an SQL query to find the position of the alphabet (‘a’) in the first name 
-- column ‘Amitabh’ from the Worker table.
select instr(first_name,'a') from worker
where FIRST_NAME='Amitabh';

select sum(length(first_name)-length(replace(lower(first_name),'a',''))) as len_of_a
FROM worker
where FIRST_NAME='Amitabh';
-- Write an SQL query to print the FIRST_NAME from the Worker table after removing 
-- white spaces from the right side.
select rtrim(first_name) from worker;
-- Write an SQL query to print the DEPARTMENT from the Worker table after removing 
-- white spaces from the left side.
select ltrim(department) from worker;
--  Write an SQL query that fetches the unique values of DEPARTMENT from the Worker 
-- table and prints its length.
select distinct length(department) from worker;
-- Write an SQL query to print the FIRST_NAME from the Worker table after 
-- replacing ‘a’ with ‘A’.
select replace(first_name,'A','a') from worker where FIRST_NAME='Amitabh';
-- Write an SQL query to print the FIRST_NAME and LAST_NAME from the Worker table 
-- into a single column COMPLETE_NAME. A space char should separate them.
select concat(first_name,' ',last_name) as complete_name from worker;
-- SELECT FIRST_NAME || ' ' || LAST_NAME AS COMPLETE_NAME FROM Worker;
-- Write an SQL query to print all Worker details from the Worker table 
-- order by FIRST_NAME Ascending.
select * from worker order by FIRST_NAME;
-- Write an SQL query to print all Worker details from the Worker table 
-- order by FIRST_NAME Ascending and DEPARTMENT Descending.
select * from worker order by FIRST_NAME asc, department desc;
-- Write an SQL query to print details for Workers with the first names “Vipul” and “Satish” 
-- from the Worker table
select * from worker where FIRST_NAME = 'Vipul' or FIRST_NAME = 'Satish';
-- Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” 
-- from the Worker table.
select * from worker where FIRST_NAME != 'Vipul' or FIRST_NAME != 'Satish';
-- Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.
select * from worker where DEPARTMENT = 'Admin';
-- Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
select * from worker where FIRST_NAME like '%a%';
-- Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
select * from worker where FIRST_NAME like '%a';
-- Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and 
-- contains six alphabets.
select * from worker where FIRST_NAME like '%h' and FIRST_NAME like '______';
-- Write an SQL query to print details of the Workers whose SALARY 
-- lies between 100000 and 500000.
select * from worker where SALARY between 100000 and 500000;
-- Write an SQL query to print details of the Workers who joined in Feb 2021.
select * from worker where month(JOINING_DATE) = 2 and year(JOINING_DATE)=2021;
-- Write an SQL query to fetch the count of employees working in the department ‘Admin’.
select count(worker_id) as Num_of_emp from worker where department = 'Admin';
-- Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.
select concat(first_name,' ',last_name) as Full_Name, salary from worker
where salary >= 50000 and salary <= 100000;
-- Write an SQL query to fetch the number of workers for each department in descending order
select department,count(worker_id) as Total_Workers from worker
group by department
order by Total_Workers desc;
-- Write an SQL query to print details of the Workers who are also Managers.
 select distinct * from worker w
 join title t
 on w.WORKER_ID = t.worker_ref_id
 where t.WORKER_TITLE = 'Manager';
 -- Write an SQL query to fetch duplicate records having matching data in some 
 -- fields of a table.
SELECT WORKER_TITLE, AFFECTED_FROM, COUNT(*) FROM Title 
GROUP BY WORKER_TITLE, AFFECTED_FROM  HAVING COUNT(*) > 1;
-- Write an SQL query to show only odd rows from a table.
select * from 
(
	select *, row_number() over(order by (select null)) as rows_cnt
    from title
) as q1
where rows_cnt % 2 <> 0 ;

SELECT * FROM Worker WHERE WORKER_ID % 2 <> 0;

-- Write an SQL query to show only even rows from a table.
select * from
(
	select *, row_number() over(order by (select null)) as row_cnt
    from title
)as t2
where row_cnt % 2 = 0 ;
select * from worker where WORKER_ID % 2 = 0;

-- Write an SQL query to clone a new table from another table.
create table newtable as select * from title;
-- select *
-- into newtable
-- from title;

-- Write an SQL query to fetch intersecting records of two tables.
-- select * from title intersect select * from newtable;
select * from title union all select * from newtable;
SELECT * FROM (
    SELECT * FROM title
    UNION ALL
    SELECT * FROM newtable
) AS combined
GROUP BY WORKER_REF_ID,WORKER_TITLE,AFFECTED_FROM
HAVING COUNT(*) > 1;

-- Write an SQL query to show records from one table that another table does not have.
select t.* from title t
left join newtable n on t.WORKER_REF_ID = n.WORKER_REF_ID
where n.WORKER_REF_ID is not null;

-- SELECT * FROM title EXCEPT SELECT * FROM newtable;

-- Write an SQL query to show the current date and time.
select now();

-- Write an SQL query to show the top n (say 10) records of a table.
select * from worker limit 5;

select * from worker order by SALARY desc;

-- Write an SQL query to determine the nth (say n=5) highest salary from a table.
select * from worker
order by SALARY desc
limit 1 offset 4;

--  Write an SQL query to determine the 5th highest salary without 
-- using the TOP or limit method.

-- Write an SQL query to fetch the list of employees with the same salary.

SELECT distinct W.WORKER_ID, W.FIRST_NAME, W.Salary from Worker W, Worker W1 
where W.Salary = W1.Salary and W.WORKER_ID != W1.WORKER_ID;

-- SELECT COUNT(*) FROM fooTable;
select count(*) from employees;
select count(*) from salaries;

-- mysql safe mode

set sql_safe_updates = 0;

-- delete duplicates 
with cte as (
    select worker_ref_id
    from (
        select worker_ref_id, worker_title, affected_from, 
               row_number() over(partition by worker_title order by worker_ref_id) as cnt
        from newtable
    ) subquery
    where cnt > 3
)
delete from newtable
where worker_ref_id in (select worker_ref_id from cte);

set sql_safe_updates = 1;







