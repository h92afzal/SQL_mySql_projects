SELECT * FROM leet_code.employee;

select name
from employee
where managerId is null;

-- Write a solution to find managers with at least five direct reports.
select e1.name
from employee e1
join employee e2
on e1.id = e2.managerId
group by e1.name
having count(e1.id) >= 5; 

-- The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. 
-- The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.
select s.user_id, round(avg(if(c.action = 'confirmed',1,0)),2) as confirmation_rate
from signups s
left join confirmations c
on s.user_id = c.user_id
group by s.user_id;

-- Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".
select id,description,rating
from cinema
where description != 'boring' and id%2<>0
order by rating desc;

-- Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places.
-- Average selling price = Total Price of Product / Number of products sold.
-- Average selling price for product 1 = ((100 * 5) + (15 * 20)) / 115 = 6.96
-- Average selling price for product 2 = ((200 * 15) + (30 * 30)) / 230 = 16.96

select * from prices;
select * from unitssold;

select p.product_id, ifnull(round(sum(p.price*u.units) / sum(u.units),2),0) as average_price
from prices p
join unitssold u 
on p.product_id = u.product_id and
u.purchase_date BETWEEN start_date AND end_date
group by p.product_id;

SELECT p.product_id,COALESCE(round(sum(p.price*u.units)/sum(units),2),0) as average_price FROM Prices p left join UnitsSold u on 
p.product_id=u.product_id and purchase_date between p.start_date and p.end_date  group by p.product_id;  

-- Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.
-- The average experience years for the first project is (3 + 2 + 1) / 3 = 2.00 and for the second project is (3 + 2) / 2 = 2.50

select e.employee_id,round(sum(p.employee_id)/count(p.employee_id),2) as avg_experience_year
from employee1 e 
join project p
on e.employee_id = p.project_id
group by e.employee_id;

SELECT p.project_id, ROUND(AVG(e.experience_years),2) AS average_years
FROM Project p 
LEFT JOIN Employee1 e
ON p.employee_id = e.employee_id
GROUP BY p.project_id;

-- Write a solution to find the percentage of the users registered in each contest rounded to two decimals.

select r.contest_id, round((count(distinct r.user_id)/count(distinct u.user_id)*100),2) as percentage
from users u
join register r
group by r.contest_id
order by 2 desc, 1 asc;

# Write your MySQL query statement below 
SELECT R.contest_id, ROUND(COUNT(DISTINCT R.user_id) / COUNT(DISTINCT U.user_id) * 100, 2) AS percentage
FROM Users AS U 
JOIN Register AS R
GROUP BY R.contest_id
ORDER BY 2 DESC, 1 ASC;

-- Write a solution to find each query_name, the quality and poor_query_percentage.
-- Dog queries quality is ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50
-- Dog queries poor_ query_percentage is (1 / 3) * 100 = 33.33
-- Cat queries quality equals ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66
-- Cat queries poor_ query_percentage is (1 / 3) * 100 = 33.33

select query_name, round(avg(1.0*rating / position),2) as quality,
round((if(query_name = 'Dog' or query_name='Cat' ,1,0)/count(*))*100,2) as poor_query_percentage
from queries
group by query_name;

select query_name, round(avg(1.0*rating / position),2) as quality,
round(avg(if(rating<3 ,1,0))*100,2) as poor_query_percentage
from queries
where query_name is not null
group by query_name;

select q.query_name,
round(avg(q.rating/q.position),2) as quality,
round(avg(if(rating<3,1,0))*100,2) as poor_query_percentage
from Queries q
where q.query_name is not null
group by  q.query_name;

-- Write an SQL query to find for each month and country, the number of transactions and their total amount, 
-- the number of approved transactions and their total amount.
select * from transactions;

select concat(date_format(trans_date,'%Y'),'-',date_format(trans_date,'%m')) as month,country,
count(trans_date) as trans_count, sum(if(state = 'approved',1,0)) as approved_count,
sum(amount) as trans_total_amount, sum(if(state = 'approved', amount, 0)) as approved_total_amount
from transactions
group by 1,2;

# Write your MySQL query statement below
SELECT CONCAT(DATE_FORMAT(trans_date, "%Y"),"-",DATE_FORMAT(trans_date, "%m")) AS month,
country, COUNT(trans_date) AS trans_count, SUM(IF(state ="approved",1,0)) AS approved_count, 
SUM(amount) AS trans_total_amount, SUM(IF(state ="approved",amount,0)) AS approved_total_amount 
FROM Transactions
GROUP BY CONCAT(DATE_FORMAT(trans_date, "%Y"),"-",DATE_FORMAT(trans_date, "%m")), country;

SELECT 
    LEFT(trans_date, 7) AS month,
    country, 
    COUNT(id) AS trans_count,
    SUM(state = 'approved') AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM((state = 'approved') * amount) AS approved_total_amount
FROM 
    Transactions
GROUP BY 
    month, country;
    
-- If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

-- The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

-- Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
select * from delivery;
-- identify the first order for each customer
-- find first order is immediate or not
-- calculate the percentage of these orders
select min(order_date) as order_date
from delivery
group by customer_id;

select customer_id,
case 
	when order_date = customer_pref_delivery_date then 1 else 0
end as immediate
from delivery;

with first_order as
(
	select customer_id, min(order_date) as order_date
	from delivery
	group by customer_id
),
immediate_delivery as
(
	select d.customer_id,
    case
		when d.order_date = d.customer_pref_delivery_date then 1 else 0
    end as immediate
    from delivery d
    join first_order f
    on d.customer_id = f.customer_id
    and d.order_date = f.order_date
)	
select round(avg(immediate)*100,2) as immediate_percentage 
from immediate_delivery;

-- Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, 
-- rounded to 2 decimal places. In other words, you need to count the number of players that logged in 
-- for at least two consecutive days starting from their first login date, then divide that number by the total number of players.
WITH FirstLogin AS (
    SELECT
        player_id,
        MIN(event_date) AS first_login_date
    FROM
        Activity
    GROUP BY
        player_id
),
NextDayLogin AS (
    SELECT
        f.player_id,
        f.first_login_date,
        ADDDATE(f.first_login_date, INTERVAL 1 DAY) AS next_day
    FROM
        FirstLogin f
)
SELECT
    ROUND(
        COUNT(DISTINCT CASE WHEN a.event_date = n.next_day THEN n.player_id END) / COUNT(DISTINCT f.player_id),
        2
    ) AS fraction_of_players
FROM
    NextDayLogin n
LEFT JOIN
    Activity a
ON
    n.player_id = a.player_id
AND
    a.event_date = n.next_day
JOIN
    FirstLogin f
ON
    n.player_id = f.player_id;


