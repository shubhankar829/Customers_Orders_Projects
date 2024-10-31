# Customers_Orders_Projects

**Project Overview**

This project presents a SQL database designed to manage and analyze customer orders within a simulated e-commerce setting. It includes three main tables: Customers, Orders, and Products. Through various SQL queries, it showcases practical skills in data retrieval, aggregation, and analysis, demonstrating how SQL can be used to gain insights from relational data.

**Database Design and Data Insertion**

_Tables Created:_

1. Customers: Stores customer information (CustomerID, Name, Email).
2. Orders: Contains order details, linking each order to a customer and product (OrderID, CustomerID, ProductName, OrderDate, Quantity).
3. Products: Lists available products and their prices (ProductID, ProductName, Price).

Each table is populated with sample data for demonstration and testing purposes.

**Key SQL Queries for Data Analysis**

_Basic Data Retrieval:_ Fetching all records, specific attributes, and filtered data (e.g., customer names starting with “J”).

_Aggregations:_ Calculating totals, averages, and other key metrics, such as total quantities ordered and average product prices.

_Complex Data Joins and Filtering:_ Queries combining data from multiple tables to answer questions like customers who ordered on specific dates or have ordered every product category.

**Advanced Analytical Queries:**

1. Identifying customers with orders on consecutive days.
2. Finding products that haven’t been ordered yet.
3. Extracting top products by average order quantity.
4. Determining the percentage of high-quantity orders compared to the average.

**Key SQL Techniques Used**

_JOIN Operations:_ Efficient use of INNER JOIN, LEFT JOIN, and correlated subqueries.

_Aggregate Functions:_ SUM, AVG, COUNT to summarize and analyze data.

_Window Functions:_ To rank and perform sequence analysis.

_Common Table Expressions (CTEs): _Simplifying complex calculations, such as finding the percentage of orders above average quantities.
