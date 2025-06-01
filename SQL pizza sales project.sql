use Pizza_sales

--1) Total Revenue

select * from [dbo].[pizzas dataset sql]
where pizza_id = 'big_meat_s'

select 
round (sum (quantity * price), 2) as [Total Revenue]
from [dbo].[order_details dataset]
as o join [dbo].[pizzas dataset sql] as p
on o.pizza_id = p.pizza_id 

--2) Average Order Value
--total order value/order count

select
 round (sum(quantity * price)/count(distinct order_id), 2) as [average order value]
from [dbo].[order_details dataset]
as o join [dbo].[pizzas dataset sql] as p
on o.pizza_id = p.pizza_id 

--3) Total pizzas sold

select 
sum (quantity) as [total pizzas sold]
from [dbo].[order_details dataset ];

--4) Total Orders
select 
count (distinct order_id) as [total_orders]
from [dbo]. [order_details dataset] 

--5) Average Pizza Per order
--pizza sold/no of pizzas

select
sum(quantity)/count(distinct order_id)
as [average pizzas per order] from [dbo].[order_details dataset]



--1) Daily Trends for Total Orders

select 
format (date, 'dddd') as DayOfWeek,
count (distinct order_id) as total_orders
from [dbo].[orders dataset sql] group by format(date, 'dddd')
order by total_orders desc;

--2) Hourly Trends for Total Orders
select 
DATEPART(hour, time) as[hour],
count(distinct order_id) as count
from [dbo].[orders dataset sql]
group by DATEPART(hour, time)
order by [hour];

--3) percentage of sales by pizza category
--a: calculate total revenue per category
--% sales calulated as (a:/total revenue) *100

select
category,sum(quantity* price) as revenue,
round (sum(quantity * price)*100/(select sum(quantity * price)
from [dbo].[pizzas dataset sql] as p2 join [dbo].[order_details dataset]
as od2 On od2.pizza_id = p2.pizza_id), 2) as percentage_sales
from 
[dbo].[pizzas dataset sql] as p join [dbo].[pizza_types dataset sql] as pt
ON p.pizza_type_id = pt.pizza_type_id join [dbo].[order_details dataset] 
as od ON od.pizza_id = p.pizza_id group by category order by percentage_sales desc

--4) percentage of sales by pizza size


select
size,sum(quantity* price) as revenue,
round (sum(quantity * price)*100/(select sum(quantity * price)
from [dbo].[pizzas dataset sql] as p2 join [dbo].[order_details dataset]
as od2 On od2.pizza_id = p2.pizza_id), 2) as percentage_sales
from 
[dbo].[pizzas dataset sql] as p join [dbo].[pizza_types dataset sql] as pt
ON p.pizza_type_id = pt.pizza_type_id join [dbo].[order_details dataset] 
as od ON od.pizza_id = p.pizza_id group by size order by percentage_sales desc

--5) Total pizzas sold by pizza category

select 
category,sum(quantity) as quantity_sold
from 
[dbo].[pizzas dataset sql] as p join [dbo].[pizza_types dataset sql] as pt
ON p.pizza_type_id = pt.pizza_type_id join [dbo].[order_details dataset] 
as od ON od.pizza_id = p.pizza_id group by category order by 
sum(quantity) desc;

--6) Top 5 Best sellers by Total Pizza sold

select top 5
name, sum (quantity)as total_pizzas_sold
from 
[dbo].[pizzas dataset sql] as p join [dbo].[pizza_types dataset sql] as pt
ON p.pizza_type_id = pt.pizza_type_id join [dbo].[order_details dataset] 
as od ON od.pizza_id = p.pizza_id group by name order by 
total_pizzas_sold desc;

--7) Bottom 5 wrost sellers by total pizzas sold


select top 5
name, sum (quantity)as total_pizzas_sold
from 
[dbo].[pizzas dataset sql] as p join [dbo].[pizza_types dataset sql] as pt
ON p.pizza_type_id = pt.pizza_type_id join [dbo].[order_details dataset] 
as od ON od.pizza_id = p.pizza_id group by name order by 
total_pizzas_sold asc;