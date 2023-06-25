--Year to date (YTD) sales
select round((sum(sales_per_order)/POWER(10,6)), 2) from ecommerce_data
where YEAR(order_date) = '2022'

--YTD profit
select round((sum(profit_per_order)/POWER(10,6)), 2) from ecommerce_data
where YEAR(order_date) = '2022'

--YTD quantity
select round(((sum(order_quantity)*1.0)/POWER(10,3)), 2) from ecommerce_data
where YEAR(order_date) = '2022'

--YTD Profit margin
select round(sum(profit_per_order)*100.0/sum(sales_per_order), 2) from ecommerce_data
where YEAR(order_date) = '2022'

--Sales by category
select 
category_name,
round((sum(case when year(order_date) = '2022' then sales_per_order end)/power(10,6)) ,2) as YTD_sales, 
round(sum(case when year(order_date) = '2021' then sales_per_order end)/power(10,6),2) as PYTD_sales,
round((sum(case when year(order_date) = '2022' then sales_per_order end) - sum(case when year(order_date) = '2021' then sales_per_order end))*100.0/sum(case when year(order_date) = '2021' then sales_per_order end),2) as yoy_sales
from ecommerce_data 
group by category_name
order by category_name desc

--Top 5 products by YTD sales
select 
product_name,
round((sum(case when year(order_date) = '2022' then sales_per_order end)/power(10,3)), 2) as YTD_sales
from ecommerce_data 
group by product_name
order by YTD_sales desc
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY

--Bottom 5 products by YTD sales
select * from (select 
product_name,
round((sum(case when year(order_date) = '2022' then sales_per_order end)/power(10,3)), 2) as YTD_sales
from ecommerce_data 
group by product_name
order by YTD_sales
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY) t
order by YTD_sales desc

--Sales by region
select customer_region, round(sum(sales_per_order)/power(10,6),2) as sales from ecommerce_data
where year(order_date) = '2022'
group by customer_region

--Sales by Shipping type
select shipping_type, round(sum(sales_per_order)/power(10,6),2) as sales from ecommerce_data
where year(order_date) = '2022'
group by shipping_type

--Month wise YTD sales
