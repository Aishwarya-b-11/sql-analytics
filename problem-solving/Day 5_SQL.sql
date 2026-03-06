--order, returns, emp, dept data tables used

--1- write a query to get region wise count of return orders
-- here no_of_returns_o, no_of_returns_r is only for extra learning - inner join then the rows are same so does not matter if you count order_id or return_reason

select region, count (o.order_id) as no_of_returns_o,count (r.return_reason) as no_of_returns_r, count (distinct (o.order_id)) as no_of_distinct_returns
from orders o
inner join returns_r r on o.order_id = r.order_id
group by region;

--2- write a query to get category wise sales of orders that were not returned
-- you can also use r.order_id instead of r.return_reason

select o.category, sum(o.sales) as total_sales
from orders o
left join returns_r r on o.order_id = r.order_id
where r.return_reason is null
group by o.category, r.return_reason;

--3- write a query to print dep name and average salary of employees in that dep .

select d.dep_id, d.dep_name, avg(e.salary) as Avg_salary
from employee e
inner join dept d on e.dept_id = d.dep_id
group by d.dep_id, d.dep_name;

--4- write a query to print dep names where none of the emplyees have same salary.
-- or you can use this as well - having count(e.emp_id)=count(distinct e.salary)

select d.dep_name
from employee e
inner join dept d on e.dept_id = d.dep_id
group by d.dep_name
having count(e.salary) = count(distinct(e.salary));

--5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)

select o.sub_category
from orders o
inner join returns_r r on o.order_id = r.order_id
group by o.sub_category
having count(distinct(r.return_reason))=3;

--6- write a query to find cities where not even a single order was returned.
-- where r.return_reason is null - don't use this since the city must not have even 1 order returned and this condition focuses on null for individual rows not 0 for city

select o.city
from orders o
left join returns_r r on o.order_id = r.order_id
group by o.city
having count(r.return_reason)=0

--7- write a query to find top 3 subcategories by sales of returned orders in east region
--here need not include this condition in where - r.return_reason is not null - since already inner join will eleminate those that are not returned

select top 3 o.sub_category, sum(sales) as return_sales
from orders o
inner join returns_r r on o.order_id = r.order_id
where o.region = 'East'
group by o.sub_category
order by return_sales desc;

--8- write a query to print dep name for which there is no employee
 --where e.emp_id is null - same as Q6

select d.dep_id, d.dep_name
from employee e
right join dept d on e.dept_id = d.dep_id
group by d.dep_id,d.dep_name
having count(e.emp_id)=0;

--9- write a query to print employees name for dep id is not avaiable in dept table

select e.emp_id, e.emp_name
from employee e
left join dept d on e.dept_id = d.dep_id
where d.dep_name is null


