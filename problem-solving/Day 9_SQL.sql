--orders, loan, library, rating, employee data used
--1 - Find premium customers from orders data. Premium customers - done orders > average no of orders per customer

with counts as 
(select customer_name, count(distinct order_id) as order_count
from orders
group by customer_name)

select customer_name, order_count, (select avg(order_count) from counts) as avg_order_count
from counts
where order_count > (select avg(order_count) from counts);
--group by customer_name, order_count; --> can avoid this since cte already has group by, this is just for caution if used

/* Note:
	0. Same order id exist so we have to count that only once, hence used order id to count as distinct not name
	1. Below query throughs an error as aggregate needs group by
			select customer_name, order_count, avg(order_count)
			from counts
	2. If group by used -> avg is calculated for that customer not the entire orders as you require */


--2 - Find employees whose salary is more than average salary of employees in their department

with avg_dept_salary as
(select d.dep_id, avg(salary) as avg_salary
from dept d
left join employee e on e.dept_id = d.dep_id
group by d.dep_id)

select e.emp_name, e.dept_id, e.salary, a.avg_salary
from employee e
left join avg_dept_salary a on e.dept_id = a.dep_id
where e.salary > a.avg_salary;


--3 - Find employees whose age is more than average age of all the employees.

select *, (select avg(emp_age) from employee) as avg_age 
from employee
where emp_age > (select avg(emp_age) from employee);


--4 - Print emp name, salary and dep id of highest salaried employee in each department 

select e1.emp_name, e1.salary, e1.dept_id, e2.max_salary
from employee e1
left join (select dept_id, max(salary) as max_salary from employee group by dept_id) e2
on e1.dept_id = e2.dept_id
where e1.salary = max_salary
order by e1.dept_id;


--5 - Print emp name, salary and dep id of highest salaried overall

select emp_name, salary, dept_id, (select max(salary) from employee) as max_salary 
from employee
where salary = (select max(salary) from employee)


--6 - Print product id and total sales of highest selling products (by no of units sold) in each category

with 
product_quantity as --CTE 1
(select category, product_id, sum(quantity) as total_quantity
from orders
group by category, product_id),

max_product_quantity as --CTE 2: pulls data from CTE 1
(select category, max(total_quantity) as max_quantity --There are lot of unique product id for the category, hence we take category for max not product id.
from product_quantity
group by category)

select *
from product_quantity p
inner join max_product_quantity m on p.category = m.category --I know the * from max_product_quantity will be same but sperated by category, hence this.
where p.total_quantity  = m.max_quantity


/* Library: borrowing
Generate a report on the borrowing habits of patrons. 
Two tables - Books and Borrowers.
Write an SQL to display the name of each borrower along with a comma-separated list of the books they have borrowed in alphabetical order. 
Sort by Borrower Name ascending order.*/

select p.BorrowerName, string_agg (b.BookName, ', ') within group (order by b.BookName)
from borrowers p
left join books b on p.BookID = b.BookID
group by p.BorrowerName


/* Loan Repayment
A large financial institution provides various types of loans to customers. 
Analyze loan repayment data to assess credit risk and improve risk management strategies.
Write an SQL to create 2 flags for each loan as per below rules. Display loan id, loan amount , due date and the 2 flags.
1- fully_paid_flag: 1 if the loan was fully repaid irrespective of payment date else it should be 0.
2- on_time_flag : 1 if the loan was fully repaid on or before due date else 0.*/

with repayment as
(select l.loan_id, l.loan_amount, l.due_date, sum(p.amount_paid) as amount_repaid, max(p.payment_date) as last_pay_date
from loans l
left join payments p on l.loan_id = p.loan_id
group by l.loan_id, l.loan_amount, l.due_date)

select loan_id, loan_amount, due_date,
case when loan_amount = amount_repaid then 1 else 0 end as fully_paid_flag,
case when loan_amount = amount_repaid and due_date >= last_pay_date then 1 else 0 end as on_time_flag
from repayment


/* Rating - Lowest Price 
Small online store - analyze customer ratings for the products that are selling. 
Tables - products, purchases. 
Table purchase - each record has number of stars (from 1 to 5) as a customer rating for that product.
For each category, find the lowest price among all products that received at least one 4-star or above rating.
If a product category did not have any products that received at least one 4-star or above rating, the lowest price is considered to be 0. 
Sort by product category in alphabetical order.*/

select c.category, coalesce (min (case when p.stars >= 4 then c.price end), 0) as lowest_price
from products c
left join purchases p on c.id = p.id
group by c.category
order by c.category ASC;

/* note: min (case when p.stars >= 4 then c.price else 0 end) 
	Reason why this fails:
	1. What case does: 
		Apple (50, 3-star): Becomes 0
		Apple (25, 4-star): Becomes 25
		Apple (15, 2-star): Becomes 0
	2. The computer compares: [0, 25, 0] - The answer it gives is 0. (This is wrong because the lowest 4-star price was 25).
	3. Almost every category will return 0 because any product with < 4 stars or no rating -> all triggers that else 0, but the above one gives Null and SQL does not take Null for calculation or comparison*/