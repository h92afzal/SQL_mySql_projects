SELECT TOP (1000) [employee_id]
      ,[first_name]
      ,[last_name]
      ,[age]
      ,[gender]
      ,[birth_date]
  FROM [parks_and_recreation].[dbo].[employee_demographics]

  ALTER TABLE [dbo].[employee_demographics]
ALTER COLUMN [employee_id] [int] NOT NULL;

  ALTER TABLE [dbo].[employee_demographics]
ADD CONSTRAINT emp_id PRIMARY KEY ([employee_id]);

select * from employee_salary;

alter table employee_salary
alter column employee_id int not null;

alter table employee_salary
add constraint empId primary key (employee_id);

alter table parks_departments
alter column department_id int not null;


alter table parks_departments
add constraint depId primary key (department_id);

alter table employee_demographics
alter column age int null;

alter table employee_salary
alter column dept_id int null;
