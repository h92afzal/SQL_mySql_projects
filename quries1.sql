SELECT TOP (1000) [OId]
      ,[AcctId]
      ,[OccuredAt]
      ,[StandardQty]
      ,[GlossQty]
      ,[PosterQty]
      ,[Total]
      ,[StdAmtUsd]
      ,[GlossAmtUsd]
      ,[PosterAmtUsd]
      ,[TotalAmtUsd]
  FROM [ParchnPosy].[dbo].[Orders]
  order by OccuredAt

  SELECT TOP (10) 
  *
  FROM [ParchnPosy].[dbo].[Orders]
  ORDER BY OccuredAt DESC


  --Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.
  SELECT TOP (10) 
  OId,OccuredAt,TotalAmtUsd
  FROM [ParchnPosy].[dbo].[Orders]
  ORDER BY OccuredAt 

  --Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.

  SELECT TOP (5)
  OId,AcctId,TotalAmtUsd
  FROM [ParchnPosy].[dbo].[Orders]
  ORDER BY TotalAmtUsd DESC

  --Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.

  SELECT TOP (20)
  OId,AcctId,TotalAmtUsd
  FROM [ParchnPosy].[dbo].[Orders]
  ORDER BY TotalAmtUsd 


  SELECT 
  OId,AcctId,TotalAmtUsd
  FROM [ParchnPosy].[dbo].[Orders]
  ORDER BY AcctId,TotalAmtUsd DESC 


  SELECT 
  AcctId,TotalAmtUsd
  FROM [ParchnPosy].[dbo].[Orders]
  ORDER BY TotalAmtUsd DESC ,AcctId 


  --Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).

  SELECT
  OId,AcctId,TotalAmtUsd
  FROM [ParchnPosy].[dbo].[Orders]
  ORDER BY AcctId ASC, TotalAmtUsd DESC

  --Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order). 

  SELECT
  OId,AcctId,TotalAmtUsd
  FROM [ParchnPosy].[dbo].[Orders]
  ORDER BY TotalAmtUsd DESC,AcctId ASC 

    SELECT
  OId,AcctId,TotalAmtUsd
  FROM [ParchnPosy].[dbo].[Orders]
  ORDER BY TotalAmtUsd DESC,AcctId ASC 


  --Pulls the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.

  SELECT TOP (5)
  *
  FROM [ParchnPosy].[dbo].[Orders]
  WHERE GlossAmtUsd >= 1000

  --Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.
  
  SELECT TOP (10)
  *
  FROM [ParchnPosy].[dbo].[Orders]
  WHERE TotalAmtUsd <500

