-- Cleaned FACT_InternetSales Table --
SELECT 
  [ProductKey], 
  [OrderDateKey], 
  [DueDateKey], 
  [ShipDateKey], 
  [CustomerKey],
  [SalesOrderNumber], 
  [SalesAmount]
FROM 
  [AdventureWorksDW2022].[dbo].[FactInternetSales]
WHERE 
  LEFT (OrderDateKey, 4) >= YEAR(GETDATE()) -3 -- Ensures we always only bring three years of date from extraction.
ORDER BY
  OrderDateKey ASC
