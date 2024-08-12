CREATE TABLE Employee
    ( 
    [ID] INT identity(1,1), 
    [FirstName] Varchar(100), 
    [LastName] Varchar(100), 
    [Country] Varchar(100), 
    ) 
    GO 
    
    Insert into Employee ([FirstName],[LastName],[Country] )values('Raj','Gupta','India'),
                                ('Raj','Gupta','India'),
                                ('Mohan','Kumar','USA'),
                                ('James','Barry','UK'),
                                ('James','Barry','UK'),
                                ('James','Barry','UK')

	
SELECT [FirstName], 
    [LastName], 
    [Country], 
    COUNT(*) AS CNT
FROM Employee
GROUP BY [FirstName], 
      [LastName], 
      [Country]
HAVING COUNT(*) > 1;


select FirstName, LastName, count(*) as cnt
from Employee
group by FirstName,LastName
having count(*) > 1;

select * 
from Employee
where id not in 
(select max(id)
  from Employee
  group by FirstName, LastName,Country  );
  
  delete 
    FROM Employee
    WHERE ID NOT IN
    (
        SELECT MAX(ID)
        FROM Employee
        GROUP BY [FirstName], 
                 [LastName], 
                 [Country]
    );


	select * from Employee;
 	
with cte_del (firstname,lastname, country, duplicatecnt) as
(
select firstname, lastname, country, ROW_NUMBER() over(PARTITION BY firstname,lastname,country order by id) as duplicatecnt
from Employee)
select * from cte_del;