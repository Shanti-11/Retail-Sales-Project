-- SQL RETAIL SALES ANALYSIS 
create database sql_project_1;

create table retail_sales
(
    transactions_id	int primary key,
    sale_date date,
    sale_time time,
	customer_id int,
	gender	varchar(15),
    age	int,
    category varchar(15),
	quantiy int,
	price_per_unit	float,
    cogs	float,
    total_sale float
);

select *
from retail_sales;

select *
from retail_sales
limit 10;

select 
count(*)
from retail_sales;

-- data cleaning
select *
from retail_sales
where transactions_id is null;

select *
from retail_sales
where sale_date is null;

select *
from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null 
or age is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;

-- data exploration

-- no. of sales
select count(*) from retail_sales;

-- no. of customers
select count(distinct customer_id) as total_sale from retail_sales;

-- no. of category
select count(distinct category) as total_sale from retail_sales;

select category from retail_sales;

select distinct category from retail_sales;

-- data analysis
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select *
from retail_sales
where sale_date= '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select *
from retail_sales
 where category= 'Clothing';
 
 select count(category)
from retail_sales
 where category= 'Clothing';
 
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND YEAR(sale_date) = 2022
  AND MONTH(sale_date) = 11;
  
  SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND YEAR(sale_date) = 2022
  AND MONTH(sale_date) = 11 
  AND quantiy > 3;
  
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select 
category,
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
avg(age) as avg_age
from retail_sales
where category= 'beauty';
 
 -- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * 
from retail_sales
where total_sale > 1000;

 -- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
category,
gender,
count(*) as total_trans
from retail_sales
group by category,
gender
order by 1;

 -- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select 
year(sale_date),
month(sale_date),
avg(total_sale),
rank() over(partition by year(sale_date)
 order by avg(total_sale) desc) as rank_order
from retail_sales
group by 
1, 2
order by 1,3 desc;

select * 
from 
(select
year(sale_date),
month(sale_date),
avg(total_sale),
rank() over(partition by year(sale_date)
 order by avg(total_sale) desc) as `rank`
from retail_sales
group by year(sale_date),
month(sale_date) 
 )as t1
where `rank`=1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id,
sum(total_sale) 
from retail_sales
group by 1
order by 2 desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category,
count(distinct customer_id )
from retail_sales
group by 1;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale
as(
select *,
case
when hour(sale_time) < 12 then 'morning'
when hour(sale_time) between 12 and 17 then 'afternoon'
else 'evening'
end 
as shift
from retail_sales)
select  shift,
count(*) as total_order
from hourly_sale
group by shift;

-- end