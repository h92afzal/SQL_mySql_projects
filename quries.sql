SELECT AcntName, PrimaryPOC, SR_Id,WebSite
FROM Accounts
WHERE AcntName IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM WebEvents
WHERE Channel not IN ('direct', 'adwords');

select *
from Accounts 
where AcntName like '%C'

select *
from Accounts 
where AcntName not like '%one%'

select *
from Accounts 
where AcntName like 'S%'

SELECT *
FROM Orders
WHERE StandardQty > 1000 AND PosterQty = 0 AND GlossQty = 0;


SELECT AcntName
FROM Accounts
WHERE AcntName NOT LIKE 'C%' AND AcntName LIKE '%s';

SELECT OccuredAt, GlossQty 
FROM Orders
WHERE GlossQty BETWEEN 24 AND 29;

SELECT *
FROM WebEvents
WHERE Channel IN ('organic', 'adwords') AND OccuredAt BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY OccuredAt DESC;

SELECT orders.*
FROM orders
JOIN accounts
ON orders.AcctId = accounts.id;

SELECT accounts.AcntName, orders.OccuredAt
FROM orders
JOIN accounts
ON orders.AcctId = accounts.id;

select Accounts.AcntName,accounts.PrimaryPOC, WebEvents.OccuredAt,WebEvents.Channel
from WebEvents
join accounts on WebEvents.Acnt_Id=accounts.id
where accounts.AcntName = 'Walmart';

select region.RegionName,accounts.AcntName, 
(orders.TotalAmtUsd/(orders.total+0.01)) as unit_price 
from accounts join orders on accounts.id=orders.AcctId 
join SalesReps on accounts.SR_Id=SalesReps.SRId join region on SalesReps.RegionId = region.id;

SELECT r.RegionName region, s.SRName rep, a.AcntName account
FROM SalesReps s
JOIN Region r
ON s.RegionId = r.id
JOIN accounts a
ON a.SR_Id = s.SRId
ORDER BY a.AcntName;

SELECT r.RegionName, a.AcntName, o.TotalAmtUsd/(o.total + 0.01) UnitPrice
FROM region r
JOIN SalesReps s
ON s.RegionId = r.id
JOIN accounts a
ON a.SR_Id = s.SRId
JOIN orders o
ON o.AcctId = a.id
WHERE o.StandardQty > 100 AND o.PosterQty > 50
ORDER BY 3;

SELECT Max(OccuredAt) as Occurred_At
FROM WebEvents;

select top 1 OccuredAt
from Orders
order by OccuredAt desc;

