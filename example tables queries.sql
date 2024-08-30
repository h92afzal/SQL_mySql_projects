-- You have a `Purchases` table with fields (`customer_id`, `purchase_date`, `amount_spent`). 
-- Write a query to find the percentage of customers who made a purchase on the day after their first purchase.
select *
from purchases;

with First_Purchase as
(
	select customer_id, min(purchase_date) as prev_day_purchase
    from purchases
    group by customer_id
),
Second_Purchase as
(
	select distinct p.customer_id
    from purchases p
    join First_Purchase fp
    on p.customer_id=fp.customer_id
    and datediff(p.purchase_date,fp.prev_day_purchase) = 1
)
select round(count(distinct sp.customer_id) / count(distinct fp.customer_id) * 100, 2) as percentage 
from First_Purchase fp
left join Second_Purchase sp
on fp.customer_id=sp.customer_id;


-- In a `Login` table with fields (`user_id`, `login_date`, `device_type`), 
-- write a query to report the fraction of users who logged in on the same device on the day after their first login.
select * from login;

with first_day_login as
(
	select user_id,min(login_date) as first_login
    from login
    group by user_id
),
second_day_login as
(
	select distinct l.user_id
    from login as l
    join first_day_login as fl
    on l.user_id = fl.user_id
    and datediff(l.login_date,fl.first_login) = 1
)
select round(count(distinct sdl.user_id) / count(fl.user_id) * 100,2) as percentage 
from first_day_login fl
left join second_day_login sdl
on fl.user_id = sdl.user_id;

-- You have a `Subscriptions` table with fields (`user_id`, `subscription_date`, `plan_type`). 
-- Write a query to find the percentage of users who upgraded their plan type within a week of their first subscription.
select * from subscriptions;

with first_subscription as
(
	select user_id, min(subscription_date) as date_of_sub, plan_type as init_plan
    from subscriptions
    group by user_id
),
second_subscription as
(
	select distinct s.user_id
    from subscriptions s
    join first_subscription fs
    on s.user_id = fs.user_id
    and s.subscription_date > fs.date_of_sub
    and datediff(s.subscription_date,fs.date_of_sub) = 6
    and s.plan_type > fs.init_plan
)
select round(count(distinct ss.user_id) / count(fs.user_id) * 100,2) as percentage
from first_subscription fs
left join second_subscription ss
on fs.user_id = ss.user_id;

select @@sql_mode;
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));


WITH FirstSubscription AS (
    SELECT
        user_id,
        MIN(subscription_date) AS first_subscription_date,
        plan_type AS initial_plan_type
    FROM
        Subscriptions
    GROUP BY
        user_id
),
UpgradedSubscription AS (
    SELECT DISTINCT
        s.user_id
    FROM
        Subscriptions s
    JOIN
        FirstSubscription fs
    ON
        s.user_id = fs.user_id
    AND
        s.subscription_date > fs.first_subscription_date
    AND
        s.subscription_date <= DATE_ADD(fs.first_subscription_date, INTERVAL 7 DAY)
    AND
        s.plan_type > fs.initial_plan_type
)
SELECT
    ROUND(COUNT(DISTINCT us.user_id) / COUNT(DISTINCT fs.user_id) * 100, 2) AS upgrade_percentage
FROM
    FirstSubscription fs
LEFT JOIN
    UpgradedSubscription us
ON
    fs.user_id = us.user_id;


WITH FirstSubscription AS (
    SELECT
        s.user_id,
        s.subscription_date AS first_subscription_date,
        s.plan_type AS initial_plan_type
    FROM
        Subscriptions s
    WHERE
        s.subscription_date = (
            SELECT MIN(subscription_date)
            FROM Subscriptions
            WHERE user_id = s.user_id
        )
),
UpgradedSubscription AS (
    SELECT DISTINCT
        s.user_id
    FROM
        Subscriptions s
    JOIN
        FirstSubscription fs
    ON
        s.user_id = fs.user_id
    AND
        s.subscription_date > fs.first_subscription_date
    AND
        s.subscription_date <= DATE_ADD(fs.first_subscription_date, INTERVAL 7 DAY)
    AND
        s.plan_type > fs.initial_plan_type
)
SELECT
    ROUND(COUNT(DISTINCT us.user_id) / COUNT(DISTINCT fs.user_id) * 100, 2) AS upgrade_percentage
FROM
    FirstSubscription fs
LEFT JOIN
    UpgradedSubscription us
ON
    fs.user_id = us.user_id;

-- Consider an `Orders` table with fields (`customer_id`, `order_date`, `product_id`, `quantity`). 
-- Write a query to report the fraction of customers who placed a second order on the day after their first order.

with first_order_cte as
(
	select customer_id, min(order_date) as first_order
    from orders
    group by customer_id
),
second_order_cte as
(
	select distinct o.customer_id
    from orders o 
    join first_order_cte fo
    on o.customer_id = fo.customer_id
    and datediff(o.order_date,fo.first_order) = 1
)
select round(count(distinct so.customer_id) / count(fo1.customer_id) *100 ,2) as percentage
from first_order_cte fo1
left join second_order_cte so
on fo1.customer_id=so.customer_id;

-- In a `Transactions` table with fields (`account_id`, `transaction_date`, `transaction_type`, `amount`), 
-- write a query to find the percentage of accounts that had another transaction on the day after their first transaction.

with first_trans as
(
	select account_id, min(transaction_date) as first_trans_date
    from transactions
    group by account_id
),
sec_trans as
(
	select distinct t.account_id    
    from transactions t
    join first_trans ft
    on t.account_id = ft.account_id
    and datediff(t.transaction_date,ft.first_trans_date) = 1
)
select round(count(distinct st.account_id) / count(ft1.account_id) * 100,2) as percentage
from first_trans ft1
left join sec_trans st 
on ft1.account_id = st.account_id;

-- You have a `PageViews` table with fields (`user_id`, `view_date`, `page_id`). 
-- Write a query to determine the fraction of users who viewed a different page on the day after their first page view.
with first_view as
(
	select user_id, min(view_date) as first_view_date
    from pageviews
    group by user_id
),
sec_view as 
(
	select distinct p.user_id
    from pageviews p
    join first_view fv
    on p.user_id = fv.user_id
    and datediff(p.view_date,fv.first_view_date) = 1
)
select round(count(distinct sv.user_id) / count(fv1.user_id) * 100, 2) as percent
from first_view fv1
left join sec_view sv
on fv1.user_id = sv.user_id;

WITH FirstView AS (
    SELECT
        user_id,
        MIN(view_date) AS first_view_date,
        page_id AS first_page_id
    FROM
        PageViews
    GROUP BY
        user_id
),
NextDayViews AS (
    SELECT
        pv.user_id,
        pv.page_id,
        pv.view_date
    FROM
        PageViews pv
    JOIN
        FirstView fv
    ON
        pv.user_id = fv.user_id
    WHERE
        pv.view_date = DATE_ADD(fv.first_view_date, INTERVAL 1 DAY)
)
SELECT
    ROUND(COUNT(DISTINCT CASE WHEN ndv.page_id != fv.first_page_id THEN ndv.user_id END) / COUNT(DISTINCT fv.user_id), 2) AS fraction_of_users
FROM
    FirstView fv
LEFT JOIN
    NextDayViews ndv
ON
    fv.user_id = ndv.user_id;

