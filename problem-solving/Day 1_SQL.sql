/** using superstores order tables**/

--entire table
select * from Orders;

--select top row for idea on table column
select top 1 * from Orders;

--number of orders per category per sub-category
select Category, Sub_Category,count (order_ID) as No_of_orders
from Orders
where sales>1
group by Category, Sub_Category
order by Category, Sub_Category;

--number of orders and total profit per region
select Region, count(Order_ID) as No_of_orders, sum(Profit) as Total_profit
from Orders
group by Region
order by sum(Profit) desc;

/** creating new table and inserting values**/

--create table Emp_details with constraints
create table Emp_details
(
emp_id int identity (1,1),
emp_name varchar (50) not null,
dept_id int,
manager_id int,
salary int,
joining_date date,
primary key (emp_id)
)

--alter table - change datatype
Alter table Emp_details alter column salary float;

--insert values into empl_details
insert into Empl_details values 
('Yaksha V',2,3,1000,'2025-10-18'),
('Ravi Varman',3,4,1500,'2023-03-10'),
('Aruna Nigam',3,5,6000,'2022-06-20'),
('Rana Sigha',2,5,8000,'2020-01-15'),
('Ganga Gupta',1,null,12000,'2018-08-05');

--create table Dept_details with constraints
create table Dept_details
(
dept_id int,
dept_name varchar (50) not null,
)

--insert values into dept_details
insert into Dept_details values 
(1,'Management'),(2,'IT'),(3,'HR');

select * from Emp_details
select * from Dept_details

select e.emp_id,e.emp_name,e.manager_id,e.salary,e.joining_date,d.dept_id,d.dept_name
from Empl_details e
inner join Dept_details d on e.dept_id = d.dept_id;