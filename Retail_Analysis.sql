-- SQL Retail Sales Analysis
CREATE DATABASE sql_project1;

-- Create Table 
DROP TABLE IF exists retail_sales;
Create Table retail_sales
                (
                transactions_id INT PRIMARY KEY,
                sale_date DATE,
                sale_time   TIME,
                customer_id INT,
                gender    VARCHAR(15),
                age INT,
                category  VARCHAR(18),
                quantiy    INT,
                price_per_unit  INT,
                cogs FLOAT,
                total_sale INT
                )

select *from retail_sales limit 50;

select count(*) from retail_sales;

select *from retail_sales
where transactions_id is NULL;


select *from retail_sales
where sale_time is NULL;

select *from retail_sales
where 
sale_time is NULL
or
sale_date is null
or
sale_time is null
or
gender is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or 
cogs is null
or
total_sale is null

-- DATA EXploration
-- HOW MANY SALES WE HAVE?
SELECT count(*) as total_sale from retail_sales

-- How Many Uniuque customers we have?
select count(Distinct customer_id) as total_sale from retail_sales

select distinct category from retail_sales

-- DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS
My Analysis & Findings
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
where sale_date ='2022-11-05';

 -- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy < 5
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, SUM(total_sale) As totalSalesEachcategory
FROM retail_sales
GROUP BY category ;
 
 -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty'category.
 -- average age of each category
 SELECT category,Avg(age) as Average_age
 from retail_sales
 group by category;
 
 -- average age of Beauty category
SELECT category,Avg(age) as Average_age
 from retail_sales
 where category='Beauty'
 group by category;
 
 
 -- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

 
 select * from retail_sales; 
select transactions_id as id ,total_sale as sales
 from retail_sales
 where total_sale > 1000; 
 
 -- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 
select 
     category,
     gender,
     count(*) as total_trans
from retail_sales
group by
	  category,
      gender
order by 1;  

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year  
select 
year,
month,
avg_sale
from
(
select 
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_sale,
RANK() over(
partition by extract(year from sale_date) order by avg(total_sale)Desc 
) as rank_
from retail_sales
group by 1,2
) as t1
where rank_=1
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
      customer_id, SUM(total_sale) as total_sales
 from retail_sales
 group by 1
 order by 2 desc
 limit 5
 -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select 
category ,count( distinct customer_id) as cnt_unq_cus
from retail_sales
group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
 WITH hourly_sale
 As
 (
 select *, 
 CASE 
 WHEN  EXTRACT(HOUR FROM SALE_TIME) < 12 THEN 'MORNING'
 WHEN  EXTRACT(HOUR FROM SALE_TIME) BETWEEN 12 AND 17 THEN 'AFTERNOON'
 ELSE 'EVENING'
 END AS Shift
 FROM retail_sales
 )
 SELECT 
 Shift,
 count(*) as total_orders
 FROM  hourly_sale
 group by shift












