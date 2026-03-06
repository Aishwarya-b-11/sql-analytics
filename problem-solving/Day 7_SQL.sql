--team cricket, drivers, orders data used

--1- write a query to produce below output from icc_world_cup table - team_name, no_of_matches_played , no_of_wins , no_of_losses
with all_teams as (
select Team_1 as Team, Winner
from icc_world_cup
union all 
select Team_2 as Team, Winner 
from icc_world_cup)

select Team, 
count (Team) as no_of_matches_played, 
count (case when Team = Winner then Team end) as no_of_wins, 
count (case when Team <> Winner then Team end) as no_of_losses
from all_teams
group by Team;

--2- write a query to print, customer_name, first name and last name - using orders table (everything after first space can be considered as last name)
--I have found the 1st space position, subtracted it from total len to get the rest len, then using right got the last_name

select customer_name,
left (customer_name,CHARINDEX(' ',customer_name)) as first_name,
right (customer_name,(len(customer_name)-CHARINDEX(' ',customer_name))) as Last_name
from orders;

-- or substring is good, since we can also get middle name using this logic, or cte with case

/*3- write a query to print below output (eg) using drivers table. Profit rides -> no of rides where end location of a ride is same as start location of immediate next ride for a driver
id, total_rides , profit_rides
dri_1,5,1
dri_2,2,0*/

select d1.id, count(d1.id), count(d2.id)
from drivers d1
left join drivers d2
on d1.id = d2.id and d1.end_loc = d2.start_loc and d1.end_time = d2.start_time
group by d1.id

/*4- write a query to print customer name and no of occurence of character 'n' in the customer name.
customer_name , count_of_occurence_of_n*/

--logic -> every n is replaced with empty string '' not space ' '. Hence the original len reduced -> their diff gives the replaced char which is the count_of_occurence_of_n
select customer_name, 
len (customer_name) - len (REPLACE(customer_name, 'n', '')) as no_of_n_occurence
from orders;

/*5-write a query to print below output from orders data. example output
hierarchy type, hierarchy name, total_sales_in_west_region, total_sales_in_east_region
category , Technology,...,
category, Furniture,...,
sub_category, Art ,...,
and so on all the values in category ,subcategory and ship_mode are in hierarchy name 
and category ,subcategory and ship_mode are are hierarchy type*/ 

select 'category' as Hierarchy_type, category as Hierarchy_name,
sum (case when region = 'West' then sales end) as total_sales_west,
sum (case when region = 'East' then sales end) as total_sales_east
from orders
group by category
union all
select 'sub_category' as Hierarchy_type, sub_category as Hierarchy_name,
sum (case when region = 'West' then sales end) as total_sales_west,
sum (case when region = 'East' then sales end) as total_sales_east
from orders
group by sub_category
union all
select 'ship_mode' as Hierarchy_type, ship_mode as Hierarchy_name,
sum (case when region = 'West' then sales end) as total_sales_west,
sum (case when region = 'East' then sales end) as total_sales_east
from orders
group by ship_mode;

/*6- the first 2 characters of order_id represents the country of order placed . write a query to print total no of orders placed in each country
(an order can have 2 rows in the data when more than 1 item was purchased in the order but it should be considered as 1 order)*/

select left(order_id,2) as Country, count(distinct order_id) as total_orders
from orders 
group by left(order_id,2)

--EXTRA INFO:
--total rows haivng two constant char followed by anything. eg: DF.....

	select order_id
	from orders
	where order_id like 'DF%'

/*To answer Q6 if this condition is not given:
(an order can have 2 rows in the data when more than 1 item was purchased, but it should be considered as 1 order)
i.e. we want EXTRA INFO*/

	select left(order_id,2), count (order_id) as total_orders
	from orders
	group by left(order_id,2)