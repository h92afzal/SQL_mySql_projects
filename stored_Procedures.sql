DELIMITER $$
CREATE PROCEDURE New_proc()
BEGIN
	SELECT * FROM employee_demographics;
    select * from employee_salary
		where salary > 50000;
END $$
DELIMITER ;

call New_proc();

DELIMITER $$
CREATE PROCEDURE New_proc1(p_employee_id int)
BEGIN
	 select * from employee_salary
		where employee_id = p_employee_id;
END $$
DELIMITER ;


call New_proc1(2);

-- Triggeres & Events

DELIMITER $$
CREATE TRIGGER emp_insert
	after insert on employee_salary
		for each row
BEGIN
	 insert into employee_demographics (employee_id,first_name,last_name)
     values (new.employee_id,new.first_name,new.last_name);
END $$
DELIMITER ;

insert into employee_salary (employee_id,first_name,last_name,occupation,salary,dept_id)
	values(14,'Barry','Allen','Justise Society',100000,null);


select * from employee_demographics;

select * from employee_salary;

-- Events

DELIMITER $$
CREATE EVENT del_retirees1
   ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	 delete from employee_demographics
		where age >= 60;
END $$
DELIMITER ;

select * from employee_demographics;

show variables like 'event%';