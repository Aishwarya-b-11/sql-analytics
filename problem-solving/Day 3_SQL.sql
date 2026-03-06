--Q1 - Write a sql to get all the orders where customers name has "a" as second character and "d" as fourth character.
select * from orders
where customer_name like '_a_d%';

--Q2 - Write a sql to get all the orders placed in the month of dec 2020
select * from orders
where order_date between '2020-12-01' and '2020-12-31'
order by order_date;

--Q3 - Write a query to get all the orders where ship_mode is neither in 'Standard Class' nor in 'First Class' and ship_date is after nov 2020
select * from orders
where ship_mode not in ('Standard Class','First Class') and ship_date >= '2020-12-01'
order by ship_date;

--Q4 - Write a query to get all the orders where customer name neither start with "A" and nor ends with "n"
select * from orders
where customer_name not like 'A%n'
order by customer_name;

--Q5 - Write a query to get all the orders where profit is negative
select * from orders
where profit <0
order by profit;

--Q6 - Write a query to get all the orders where either quantity is less than 3 or profit is 0
select * from orders
where quantity < 3 or profit = 0
order by quantity, profit;

--Q7 - Your manager handles the sales for South region and he wants you to create a report of all the orders in his region where some discount is provided to the customers
select * from orders
where region = 'South' and discount<>0 --or discount>0
order by quantity, profit;

--Q8 - Write a query to find top 5 orders with highest sales in furniture category
select top 5 * from orders
where category = 'Furniture'
order by sales desc;

--Q9 - Write a query to find all the records in technology and furniture category for the orders placed in the year 2020 only
select * from orders
where category in ('Furniture', 'Technology') and order_date between '2020-01-01' and '2020-12-31'
order by category, order_date;

--Q10 - Write a query to find all the orders where order date is in year 2020 but ship date is in 2021 (33 rows)
select * from orders
where order_date between '2020-01-01' and '2020-12-31' and ship_date between '2021-01-01' and '2021-12-31'
order by order_date, ship_date;