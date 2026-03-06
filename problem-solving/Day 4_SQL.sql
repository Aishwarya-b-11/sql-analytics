-- 1- write a update statement to update city as null for order ids :  CA-2020-161389 , US-2021-156909
update orders
set city = null
where order_id in ('US-2021-156909', 'CA-2020-161389');

--2- write a query to find orders where city is null
select * from orders
where city is null;

--3- write a query to get total profit, first order date and latest order date for each category
select category, sum(profit) as total_profit, min (order_date) as first_order_date, max (order_date) as last_order_date
from orders
group by category;

--4- write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category
select sub_category, avg(profit) as avg_profit, max (profit)/2 as max_profit
from orders
group by sub_category
having avg(profit) > max (profit)/2;

--5- create the exams table with below script:
create table exams 
( student_id int, 
subject_name varchar(20), 
marks int);

--exams table (create it)

--write a query to find students who have got same marks in Physics and Chemistry.

select student_id,marks from exams
where subject_name in ('Physics', 'Chemistry')
group by student_id, marks
having count(marks)=2;

--6- write a query to find total number of products in each category.
select category, count(distinct(product_id)) as total_no_of_products
from orders
group by category;

--7- write a query to find top 5 sub categories in west region by total quantity sold
select top 5 sub_category, sum(quantity) as total_qty_sold
from orders
where region = 'West'
group by sub_category
order by total_qty_sold desc;

--8- write a query to find total sales for each region and ship mode combination for orders in year 2020
select region, ship_mode, sum(sales) as total_sales
from orders
where order_date between '2020-01-01' and '2020-12-31'
group by region, ship_mode
order by total_sales desc;