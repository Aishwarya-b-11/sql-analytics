
/* Product Reviews
A retail company, analysing customer feedback to identify trends and patterns in product reviews.
Write an SQL query to find all product reviews containing the word "excellent" or "amazing" in the review text. 
However, exclude reviews that contain the word "not" immediately before "excellent" or "amazing". 
Please note that the words can be in upper or lower case or combination of both. 
Query should return the review_id,product_id, and review_text for each review meeting the criteria, 
display the output in ascending order of review_id.*/
 
Select review_id, product_id, review_text
from product_reviews
where (lower (review_text) like '%excellent%' or lower (review_text) like '%amazing%')
and (lower (review_text) not like '%not amazing%') 
and (lower (review_text) not like '%not excellent%')
order by review_id ASC;


/* Category Sales 1
Write an SQL query to retrieve the total sales amount for each product category in the month of Feb 2022, 
only include sales made on weekdays (Monday to Friday). 
Display the output in ascending order of total sales.*/

select category, sum(amount) as total_sales
from sales
where order_date between '2022-02-01' and '2022-02-28'
and format (order_date,'ddd') not in ('Sat', 'Sun')
group by category
order by total_sales ASC;


/* Category Sales 2
Write an SQL query to retrieve the total sales amount in each category. 
Include all categories, if no products were sold in a category display as 0. 
Display the output in ascending order of total_sales. */

select c.category_name, isnull(sum(s.amount2), 0) as total_sales
from categories c
left join sales s on c.category_id = s.category_id
group by c.category_name
order by total_sales ASC;


/*Employee Mentor
Find the names of all employees who were not mentored by the employee with id = 3.*/

select name
from emp103
where isnull(mentor_id,0)<>3


/* Department Average Salary
Two tables: Employees and Departments. 
Employees table - IDs, names, salaries, and department IDs. 
Departments table - IDs and names. 
Write a SQL query to find the average salary of employees in each department, but only include departments that have more than 2 employees . 
Display department name and average salary round to 2 decimal places. 
Sort the result by average salary in descending order.*/

select d.dept_name, round(avg(cast(e.salary as decimal)),2) as Avg_salary
from Dept d
inner join Emp e on d.dept1_id = e.dept_id
group by d.dept_name
having count(e.emp_id)>2
order by Avg_salary desc;


/* Product Sales
Two tables: Products and Sales. 
Products - IDs, names, and prices. 
Sales - product IDs, quantities sold, and dates of sale. 
Write a SQL query to find the total sales amount for each product. 
Display product name, total sales. Sort by product name.*/

select p.product_name, sum(s.quantity * p.price) as total_sales
from sales s
inner join products p on s.product_id = p.product_id
group by p.product_name
order by p.product_name;


/* Category Product
Table lists various product categories, each containing a comma-separated list of products. 
Write a SQL query to count the number of products in each category. 
Sort the result by product count & category in ASC order*/

select category, (len(products) - len(replace(products, ',', ''))+1) as product_count
from categories
order by product_count, category;
