# AdventureWorks Sales Performance Analysis (2022-2025)

## PROJECT OVERVIEW

The project was initiated in response to a request from the sales department for a consolidated executive reporting solution focused on internet sales performance. The objective was to provide both Sales Managers and Sales Representatives with actionable insights that would improve sales tracking, customer engagement, and product performance analysis.


## OBJECTIVES

To address this need, we delivered a series of tailored Power BI dashboards, each designed to meet distinct analytical requirements:

  1. Executive Overview for Sales Managers: A high-level dashboard that provides a daily-refresh snapshot of internet sales, highlighting top-performing products and customers. This           allows managers to monitor sales activity at a glance and make quick, informed decisions.

  2. Customer Sales Breakdown for Sales Representatives: An interactive dashboard enabling representatives to filter and explore sales data by customer. This helps identify key accounts,      uncover growth opportunities, and prioritize follow-up actions.

  3. Product Sales Performance View: A detailed dashboard focused on product-level sales data. Sales reps can track top-selling products, analyze trends, and adjust sales strategies           accordingly.

  4. Performance vs. Budget Analysis: A management-focused view that visualizes actual sales performance over time against predefined budget targets. This includes KPIs, trend graphs,         and variance indicators to support strategic planning and goal tracking.


## Data Transformation & Cleaning
 The following tables were extracted using SQL in order to create the data model required for conducting analysis and meeting the business needs outlined in the Business Requirement Overview.

 Sales budgets were supplied in Excel format and linked in the data model at a later stage of the procedure.

 The SQL statements for cleaning and converting the required data are listed below.

'''
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
'''
