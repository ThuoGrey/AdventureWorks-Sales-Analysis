# AdventureWorks Sales Performance Analysis (2022-2025)

## PROJECT OVERVIEW

The project was initiated in response to a request from the sales department for a consolidated executive reporting solution focused on internet sales performance. The objective was to provide both Sales Managers and Sales Representatives with actionable insights that would improve sales tracking, customer engagement, and product performance analysis.


## OBJECTIVES

To address this need, we delivered a series of tailored Power BI dashboards, each designed to meet distinct analytical requirements:

  1. Executive Overview for Sales Managers: A high-level dashboard that provides a daily-refresh snapshot of internet sales, highlighting top-performing products and customers. This           allows managers to monitor sales activity at a glance and make quick, informed decisions.

  2. Customer Sales Breakdown for Sales Representatives: An interactive dashboard enabling representatives to filter and explore sales data by customer. This helps identify key accounts,      uncover growth opportunities, and prioritize follow-up actions.

  3. Product Sales Performance View: A detailed dashboard focused on product-level sales data. Sales reps can track top-selling products, analyze trends, and adjust sales strategies           accordingly.

  4. Performance vs. Budget Analysis: A management-focused view that visualizes actual sales performance over time against predefined budget targets. This includes KPIs, trend graphs,         and variance indicators to support strategic planning and goal tracking.


## DATA TRANSFORMATION
 The following tables were extracted using SQL in order to create the data model required for conducting analysis and meeting the business needs outlined in the Business Requirement Overview.

 Sales budgets were supplied in Excel format and linked in the data model at a later stage of the procedure.

 The SQL statements for cleaning and converting the required data are listed below.

1. FACT DIMENSION;
```
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
```

2. CUSTOMERS DIMENSION;
```
-- Cleaned DIM_Customers Table --
SELECT 
  c.customerkey AS CustomerKey,
  c.firstname AS [First Name],
  c.lastname AS [Last Name], 
  c.firstname + ' ' + lastname AS [Full Name],
  CASE c.gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender,
  c.datefirstpurchase AS DateFirstPurchase,
  g.city AS [Customer City] -- Joined in Customer City from Geography Table
FROM 
  [AdventureWorksDW2022].[dbo].[DimCustomer] as c
  LEFT JOIN dbo.dimgeography AS g ON g.geographykey = c.geographykey 
ORDER BY 
  CustomerKey ASC -- Ordered List by CustomerKey
```

3. PRODUCTS DIMENSION;
```
-- Cleaned DIM_Products Table --
SELECT 
  p.[ProductKey], 
  p.[ProductAlternateKey] AS ProductItemCode,
  p.[EnglishProductName] AS [Product Name], 
  ps.EnglishProductSubcategoryName AS [Sub Category], -- Joined in from Sub Category Table
  pc.EnglishProductCategoryName AS [Product Category], -- Joined in from Category Table 
  p.[Color] AS [Product Color],
  p.[Size] AS [Product Size],
  p.[ProductLine] AS [Product Line],
  p.[ModelName] AS [Product Model Name], 
  p.[EnglishDescription] AS [Product Description], 
  ISNULL (p.Status, 'Outdated') AS [Product Status] 
FROM 
  [AdventureWorksDW2022].[dbo].[DimProduct] as p
  LEFT JOIN dbo.DimProductSubcategory AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey 
  LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey 
order by 
  p.ProductKey asc

```

4. DATE DIMENSION;
```
-- Cleaned DIM_Date Table --
  SELECT 
    [DateKey], 
    [FullDateAlternateKey] AS Date,
    [EnglishDayNameOfWeek] AS Day,
    [EnglishMonthName] AS Month, 
    Left([EnglishMonthName], 3) AS MonthShort,   -- Useful for front end date navigation and front end graphs. 
    [MonthNumberOfYear] AS MonthNo, 
    [CalendarQuarter] AS Quarter, 
    [CalendarYear] AS Year
  FROM 
   [AdventureWorksDW2022].[dbo].[DimDate]
  WHERE 
    CalendarYear >= 2022
```

## DATA MODEL

Below is a screenshot of the data model after the cleansed and prepared tables were imported into Power BI.

The model illustrates how FACT Budget dimension has been linked to FACT InternetSales Dimension and the relevant dimension tables.

![DATA MODEL](https://github.com/user-attachments/assets/3a5c8914-05a0-45a5-a26a-2bd10afef6f9)

## SALES DASHBOARD

The completed sales management dashboard includes a main overview page and two additional pages that consolidate key tables and visualizations to display sales trends over time, by customer, and by product.

OVERVIEW DASHBOARD

![sales over](https://github.com/user-attachments/assets/30bfb16c-eadf-4e03-aed6-09402a8517ae)

CUSTOMER DASHBOARD

![Customer report](https://github.com/user-attachments/assets/d2ea8cf1-6079-4291-9841-1338d0d55297)

PRODUCT DASHBOARD

![product report](https://github.com/user-attachments/assets/9748a83d-905e-4a19-9e50-64dcac59881b)
