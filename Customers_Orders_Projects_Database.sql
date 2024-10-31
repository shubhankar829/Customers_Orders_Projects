create database Customers_Orders_Projects;
use Customers_Orders_Projects;

CREATE TABLE Customers (
 CustomerID INT PRIMARY KEY,
 Name VARCHAR(50),
 Email VARCHAR(100)
);
INSERT INTO Customers (CustomerID, Name, Email)
VALUES
 (1, 'John Doe', 'johndoe@example.com'),
 (2, 'Jane Smith', 'janesmith@example.com'),
 (3, 'Robert Johnson', 'robertjohnson@example.com'),
 (4, 'Emily Brown', 'emilybrown@example.com'),
 (5, 'Michael Davis', 'michaeldavis@example.com'),
 (6, 'Sarah Wilson', 'sarahwilson@example.com'),
 (7, 'David Thompson', 'davidthompson@example.com'),
 (8, 'Jessica Lee', 'jessicalee@example.com'),
 (9, 'William Turner', 'williamturner@example.com'),
 (10, 'Olivia Martinez', 'oliviamartinez@example.com');
CREATE TABLE Orders (
 OrderID INT PRIMARY KEY,
 CustomerID INT,
 ProductName VARCHAR(50),
 OrderDate DATE,
 Quantity INT
);
INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
 (1, 1, 'Product A', '2023-07-01', 5),
 (2, 2, 'Product B', '2023-07-02', 3),
 (3, 3, 'Product C', '2023-07-03', 2),
 (4, 4, 'Product A', '2023-07-04', 1),
 (5, 5, 'Product B', '2023-07-05', 4),
 (6, 6, 'Product C', '2023-07-06', 2),
 (7, 7, 'Product A', '2023-07-07', 3),
 (8, 8, 'Product B', '2023-07-08', 2),
 (9, 9, 'Product C', '2023-07-09', 5),
 (10, 10, 'Product A', '2023-07-10', 1);
CREATE TABLE Products (
 ProductID INT PRIMARY KEY,
 ProductName VARCHAR(50),
 Price DECIMAL(10, 2)
);
INSERT INTO Products (ProductID, ProductName, Price)
VALUES
 (1, 'Product A', 10.99),
 (2, 'Product B', 8.99),
 (3, 'Product C', 5.99),
 (4, 'Product D', 12.99),
 (5, 'Product E', 7.99),
 (6, 'Product F', 6.99),
 (7, 'Product G', 9.99),
 (8, 'Product H', 11.99),
 (9, 'Product I', 14.99),
 (10, 'Product J', 4.99); select * from Customers; select * from Orders; select * from Products;-- Task 1 :-
-- 1. Write a query to retrieve all records from the Customers table..
 select * from Customers;
/*2. Write a query to retrieve the names and email addresses of customers whose
names start with 'J'.*/

select name, email from customers where email like 'J%'

/*
3. Write a query to retrieve the order details (OrderID, ProductName, Quantity)
for all orders..*/

select orderid, productname, quantity from Orders

-- 4.Write a query to calculate the total quantity of products ordered.
select sum(quantity) as total_quantity from orders

-- 5. Write a query to retrieve the names of customers who have placed an order.
select distinct name 
from customers 
where customerid IN (select distinct customerid from orders)

-- 6. Write a query to retrieve the products with a price greater than $10.00.
select productid, productname from Products where price >= 10.00

/*7. Write a query to retrieve the customer name and order date for all orders
placed on or after '2023-07-05'.*/

select c.name, o.orderdate, o.quantity from orders o 
left join customers c 
on c.customerid = o.customerid
where o.orderdate >= '2023-07-05';

-- 8. Write a query to calculate the average price of all products.
select round(avg(price),2) as average_price from Products


/*9. Write a query to retrieve the customer names along with the total quantity of
products they have ordered.*/

select c.name, sum(o.quantity) as total_quantity from orders o
left join customers c
on o.CustomerID = c.CustomerID
group by c.name;

/*10. Write a query to retrieve the products that have not been ordered*/
select productId, productname from Products where productname NOT IN (
select distinct productname from Orders
);

-- Task 2 :-

 select * from Customers; select * from Orders; select * from Products;

/*1. Write a query to retrieve the top 5 customers who have placed the
highest total quantity of orders.*/

-- Approach 1
select top 5 customerid, sum(quantity) as total_quantity
from Orders
group by customerid 
order by total_quantity desc

-- Approach 2
select top 5 o.customerid,c.name, sum(o.quantity) as total_quantity
from Orders o left join customers c 
on o.customerid = c.customerid
group by o.customerid ,c.name
order by total_quantity desc;


/*2. Write a query to calculate the average price of products for each product
category.*/
select productname, avg(price) as avg_price_of_products  from products
group by productname

/*3. Write a query to retrieve the customers who have not placed any orders.*/
select customerid, name , email from customers where customerid not in (
select customerid from orders)

/*4. Write a query to retrieve the order details (OrderID, ProductName,
Quantity) for orders placed by customers whose names start with 'M'.*/

select o.orderid, o.productname, o.quantity from orders o  join customers c 
on o.customerid = c.customerid
where c.name like 'M%'

--5. Write a query to calculate the total revenue generated from all orders.

select sum(o.quantity * p.price) as TotalRevenue
from
orders o left join Products p 
on o.Productname = p.productName

/*6. Write a query to retrieve the customer names along with the total
revenue generated from their orders.*/

select c.name, sum(o.quantity * p.price) as TotalRevenue
from orders o 
left join Products p on o.Productname = p.productName
left join Customers c on o.CustomerID = c.CustomerID
group by c.name


/*7. Write a query to retrieve the customers who have placed at least one
order for each product category.*/

SELECT c.Name AS CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Products p ON o.ProductName = p.ProductName
GROUP BY c.CustomerID, c.Name
HAVING COUNT(DISTINCT p.ProductID) = (SELECT COUNT(*) FROM Products);

/*8. Write a query to retrieve the customers who have placed orders on
consecutive days.*/

SELECT DISTINCT c.Name AS CustomerName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE DATEADD(DAY, 1, o.OrderDate) = 
      (SELECT MIN(o2.OrderDate) 
       FROM Orders o2 
       WHERE o2.CustomerID = o.CustomerID AND o2.OrderDate > o.OrderDate);


/*9. Write a query to retrieve the top 3 products with the highest average
quantity ordered.*/

select top 3 productname , cast(avg(quantity) as decimal) as AvgQuantity
from orders 
group by productname
order by AvgQuantity desc

/*10. Write a query to calculate the percentage of orders that have a quantity
greater than the average quantity.*/

With AvgQuantity as (
select avg(quantity) as AverageQuantity FROM Orders
)
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Orders)) AS PercentageAboveAverage
FROM Orders o
WHERE o.Quantity > (SELECT AverageQuantity FROM AvgQuantity);

