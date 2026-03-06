create table mock_orders
(
order_id int,
order_date date not null,
category varchar(20) not null,
product_name varchar(100),
total_price float,
payment_method varchar(20) check (payment_method in ('UPI','Online','Cash')) not null default 'UPI'
primary key (order_id,product_name)
);

insert into mock_orders values
(1,'2023-11-11','Kids Wear','Shirts',130.5,'UPI'),
(2,'2023-10-12','Mens Wear','Jeans',149.5,default),
(3,'2023-11-30','Mens Wear','Shirts',155.5,'Online'),
(4,'2024-11-30','Womens Wear','Socks',210.5,default),
(5,'2024-11-30','Kids Wear','Shoes',459,'Cash'),
(6,'2024-12-16','Womens Wear','Jacket',210.5,'Cash'),
(7,'2025-01-11','Kids Wear','Socks',125.5,'Online');

--add column
alter table mock_orders add username varchar(20);

--update single value
update mock_orders
set payment_method = 'UPI'
where order_id = 6;

--update column value
update mock_orders
set username = 'Admin';

--drop column username
alter table mock_orders drop column username;

select * from mock_orders

--delets the table
drop table mock_orders