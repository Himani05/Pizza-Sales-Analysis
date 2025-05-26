--Ctrl+E to run all queries
--Ctrl+K then Ctrl+C == comment
--Ctrl+K then Ctrl+U == uncomment

USe Piza_DB;
select * from pizza_sales;

--KPI

--1) Total revenue
SELECT 
	SUM(total_price) AS Total_Revenue 
FROM pizza_sales;

--2) Average Order Value
SELECT 
	(SUM(total_price)/COUNT(DISTINCT order_id)) AS Average_Order_Value
FROM pizza_sales;

--3) Total Pizza Sold
SELECT 
	SUM(quantity) AS Total_pizza_Sold
FROM pizza_sales;

--4) Total Orders
SELECT
	COUNT(DISTINCT order_id) As Total_Orders
FROM pizza_sales;

--5) Average Pizza per order
SELECT 
	(SUM(quantity)/COUNT(DISTINCT order_id)) AS Average_pizza_perOrder
FROM pizza_sales;
	
--Daily Trends
--1) Daily Trend for total orders  
SELECT DATENAME(DW,order_date) AS order_day,COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY DATENAME(DW,order_date);

--2)Hourly Trend for Orders
SELECT DATEPART(HOUR, order_time) as order_hours, COUNT(DISTINCT order_id) as total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)

--3) Percentage of sales by pizza category
SELECT 
	DISTINCT pizza_category,
	CAST(SUM(total_price) AS decimal(10,2)) AS sale,
	ROUND(SUM(total_price)/(SELECT SUM(total_price) FROM pizza_sales)*100,2) AS percentages
FROM pizza_sales
GROUP BY pizza_category;

--4) Percentage of sales by pizza size
SELECT 
	DISTINCT pizza_size,
	CAST(SUM(total_price) AS decimal(10,2)) AS sale,
	ROUND(SUM(total_price)/(SELECT SUM(total_price) FROM pizza_sales)*100,2) AS percentages
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

--5) Total Pizza Sold by pizza category
SELECT 
	DISTINCT pizza_category , SUM(quantity) AS total_Pizza_sold
FROM pizza_sales
GROUP BY pizza_category;

--6) TOP 5 best seller

SELECT TOP 5
	pizza_name,
	SUM(quantity) AS total_Order
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_Order desc;

--7)Bottom 5 worst seller
SELECT * FROM pizza_sales;

SELECT TOP 5
	pizza_name,
	SUM(quantity) AS total_Order
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_Order;


SELECT Order_date,DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY DATENAME(DW, order_date)

