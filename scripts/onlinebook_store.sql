-- Online Book Store

-- Create Database
create database if not exists books;

-- Switch to the database
use books;

-- Create Tables
drop table if exists orders;
drop table if exists books;
drop table if exists customers;

create table books (
Book_ID	serial primary key,
Title varchar(255),
Author varchar(255),
Genre varchar(255),
Published_Year	int,
Price decimal(4,2),
Stock int
);

create table  customers (
Customer_ID serial primary key,
Name varchar(255),
Email	varchar(255),
Phone int,
City varchar(255),
Country varchar(255)
);

create table orders (
Order_ID serial primary key,
Customer_ID	bigint unsigned,
Book_ID	 bigint unsigned,
Order_Date datetime,
Quantity int,
Total_Amount decimal(10, 2),
foreign key (customer_id) references customers(customer_id),
foreign key (book_id) references books(book_id)
);

-- Import Data into Books Table

LOAD DATA LOCAL INFILE 'data/books.csv'
INTO TABLE books
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Import Data into Customers Table

LOAD DATA LOCAL INFILE 'data/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Import Data into Orders Table

LOAD DATA LOCAL INFILE 'data/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT @@secure_file_priv;

select*from customers;
select*from books;
select*from orders;

-- Basic Questions 

-- 1) Retrieve all books in the "Fiction" genre:

select * from books where genre = 'fiction';

-- 2) Find books published after the year 1950:

select*from books where Published_Year > 1950;

-- 3) List all customers from the Canada:

select*from customers where country = 'canada';

-- 4) Show orders placed in November 2023:

select*from orders
where Order_Date >= '2023-11-01' and Order_Date < '2023-12-01';

-- 5) Retrieve the total stock of books available:

select count(*) as totalbooks_available 
from books where stock != 0;
select sum(stock) totalstock_available 
from books where stock != 0;

-- 6) Find the details of the most expensive book:

select max(price) as expensivebook_available from books;
select*from books 
where price = (select max(price) from books);

-- 7) Show all customers who ordered more than 1 quantity of a book:

select distinct c.*
from customers c
join orders o on c.customer_id = o.customer_id
where o.quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:

select*from orders where total_amount > 20;

-- 9) List all genres available in the Books table:

select distinct genre from books;

-- 10) Find the book with the lowest stock:

select* from books 
order by stock asc limit 1;

-- 11) Calculate the total revenue generated from all orders:

select sum(total_amount) as total_revenue from orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:

select sum(quantity) as sold_out_books, genre 
from books 
inner join orders on books.book_id = orders.book_id 
group by genre;

-- 2) Find the average price of books in the "Fantasy" genre:

select avg(price) as avg_price 
from books where genre = 'fantasy';
select sum(price)/count(book_id) as avg_price 
from books where genre = 'fantasy';

-- 3) List customers who have placed at least 2 orders:


select customer_id , count(order_id) as num_of_orders 
from orders 
group by customer_id 
having num_of_orders >= 2;
select p.customer_id, o.name, o.email, o.phone, o.city, o.country , count(p.order_id) as num_of_orders 
from customers o 
join orders p on o.customer_id = p.customer_id 
group by p.customer_id
having num_of_orders >= 2;

-- 4) Find the most frequently ordered book:

select b.book_id, b.title, count(o.order_id) 
as num_of_orders 
from books b 
join orders o 
on b.book_id = o.book_id 
group by b.book_id 
order by num_of_orders 
desc limit 1;
select book_id, count(order_id) 
as order_count 
from orders 
group by book_id 
order by order_count desc limit 1;

-- 5) Find the books which are not sold yet:

select b.book_id, b.title, count(o.order_id) num_of_orders 
from books b 
left join orders o on b.book_id = o.book_id 
group by b.book_id 
having num_of_orders = 0;

-- 6) Show the top 3 most expensive books of 'Fantasy' Genre :

select * from books where genre = "fantasy" 
order by price 
desc limit 3; 

-- 7) Retrieve the total quantity of books sold by each author:

select b.author, sum(o.Quantity) total_books_sold from books b 
inner join orders o on b.book_id = o.book_id 
group by b.author;

-- 8) List the cities where customers who spent over $30 are located:

select c.city, sum(o.total_amount) as tol_amount_spent 
from customers c   
join orders o on o.customer_id = c.customer_id 
group by city 
having tol_amount_spent > 30;

-- 9) Find the customer who spent the most on orders:

select c.Customer_ID, c.name, c.email, c.Phone, c.city, c.country, count(o.order_id) 
as total_orders, sum(o.total_amount) as total_amount_on_orders 
from customers c 
join orders o on c.customer_id = o.customer_id 
group by c.customer_id
order by total_amount_on_orders desc 
limit 1;

-- 10) Calculate the stock remaining after fulfilling all orders:

select (sum(b.stock) - sum(o.quantity)) as left_out_stock 
from books b 
join orders o on b.book_id = o.book_id;

select b.book_id,b.title, b.stock, IFNULL(sum(o.quantity), 0) as sold, b.stock - ifnull(sum(o.quantity),0) as remaining_stock
from books b 
left join orders o 
on b.book_id = o.book_id
group by b.book_id
order by b.book_id asc;

select b.book_id, b.stock - ifnull(sum(o.quantity),0) remaining_stock
from books b 
left join orders o 
on b.book_id = o.book_id
group by b.book_id;

select sum(b.stock - ifnull(o.total_ordered ,0)) remaining_stock
from books b
left join (
select book_id, sum(quantity) as total_ordered
from orders
group by book_id
) o
on b.book_id = o.book_id;
