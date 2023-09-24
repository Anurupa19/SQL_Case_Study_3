use data_in_motion;

-- Create the Books table
CREATE TABLE Books (
  book_id INT PRIMARY KEY,
  title VARCHAR(100),
  author VARCHAR(100),
  genre VARCHAR(50),
  price DECIMAL(8, 2)
);

-- Insert data into the Books table
INSERT INTO Books (book_id, title, author, genre, price)
VALUES
  (1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 10.99),
  (2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 12.50),
  (3, '1984', 'George Orwell', 'Science Fiction', 8.99),
  (4, 'Pride and Prejudice', 'Jane Austen', 'Romance', 9.99),
  (5, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 11.25);

-- Create the Customers table
CREATE TABLE Customers_1 (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  city VARCHAR(50),
  country VARCHAR(50)
);

-- Insert data into the Customers table
INSERT INTO Customers_1 (customer_id, name, email, city, country)
VALUES
  (1, 'John Smith', 'john@example.com', 'London', 'UK'),
  (2, 'Jane Doe', 'jane@example.com', 'New York', 'USA'),
  (3, 'Michael Johnson', 'michael@example.com', 'Sydney', 'Australia'),
  (4, 'Sophia Rodriguez', 'sophia@example.com', 'Paris', 'France'),
  (5, 'Luis Hernandez', NULL, 'Mexico City', 'Mexico');

-- Create the Orders table
CREATE TABLE Orders_1 (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  total_amount DECIMAL(10, 2),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert data into the Orders table
INSERT INTO Orders_1 (order_id, customer_id, order_date, total_amount)
VALUES
  (1, 1, '2022-01-15', 50.99),
  (2, 2, '2022-02-20', 75.50),
  (3, 3, '2022-03-10', 30.75),
  (4, 4, '2022-04-05', 22.99),
  (5, 5, '2022-05-12', 15.25);

-- Create the Order_Items table
CREATE TABLE Order_Items_1 (
  order_item_id INT PRIMARY KEY,
  order_id INT,
  book_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert data into the Order_Items table
INSERT INTO Order_Items_1 (order_item_id, order_id, book_id, quantity)
VALUES
  (1, 1, 1, 2),
  (2, 2, 3, 1),
  (3, 3, 2, 3),
  (4, 4, 5, 1),
  (5, 5, 4, 2);
  
select * from books;
select * from customers_1;
select * from orders_1;
select * from order_items_1;
  
-- 1. Retrieve all books with a price greater than $10. 
  select * from books
where price > 10;
  
-- 2. Find the total amount spent by each customer in descending order.
select c.customer_id, c.name, sum(total_amount) as total_spend
from orders_1 o join customers_1 c
on o.customer_id = c.customer_id
group by c.customer_id, c.name
order by sum(total_amount) desc; 

-- 3. Retrieve the top 3 best-selling books based on the total quantity sold.
select b.book_id, b.title, oi.quantity
from books b join order_items_1 oi
on b.book_id = oi.book_id
order by oi.quantity desc
limit 3;

-- 4. Find the average price of books in the Fiction genre.
select genre, round(avg(price),2) as avg_price
from books
where genre = 'Fiction'
group by genre;

-- 5. Retrieve the names of customers who have placed orders.
select c.name 
from customers_1 c
join orders_1 o on
c.customer_id=o.customer_id;

-- 6. Find the total revenue generated from book sales.
select sum(total_amount) as total_revenue
from orders_1;

-- 7. Retrieve the books with titles containing the word “and” (case-insensitive).
select title
from books
where title like '%and%' or title like '%AND%' or title like '%And%';

-- 8. Find the customers who have placed orders worth more than $50.
select c.customer_id, c.name, o.total_amount
from customers_1 c 
join orders_1 o 
on c.customer_id = o.customer_id
where o.total_amount > 50; 

-- 9. Retrieve the book titles and their corresponding authors sorted in alphabetical order by author
select title, author
from books
order by author asc;

-- 10. Find the customers who have not placed any orders.
select c.name from customers_1 c
left join orders_1 o 
on c.customer_id = o.customer_id
where o.order_id is null;

