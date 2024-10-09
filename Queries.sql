-- Dominic Cork

-- 1. JOINS (9)

-- a) Inner JOIN
-- Write a query to retrieve the names of all customers and the products they have ordered. 
-- Use the customers and orders tables.
SELECT customers.customer_name, orders.product_name FROM customers
INNER JOIN orders on customers.customer_id = orders.customer_id;

-- b) Left JOIN
-- Retrieve a list of all customers and their corresponding orders.
-- Include customers who have not placed any orders.
SELECT customers.customer_name, orders.product_name FROM customers
LEFT JOIN orders on customers.customer_id = orders.customer_id;

-- c) Right JOIN
-- List all products along with the suppliers who provide them, 
-- including products that have no supplier listed.
/*
Correct query for Right Join, not supported in SQLite
SELECT products.product_name, suppliers.supplier_name FROM products
RIGHT JOIN product_suppliers on products.product_id = product_suppliers.product_id
RIGHT JOIN suppliers on product_suppliers.supplier_id = suppliers.supplier_id;
*/
-- SQLite work-around for Right JOIN
SELECT products.product_name, suppliers.supplier_name FROM product_suppliers
LEFT JOIN products on product_suppliers.product_id = products.product_id
LEFT JOIN suppliers on product_suppliers.supplier_id = suppliers.supplier_id;


-- d) Full Outer JOIN
-- Retrieve all employee names and departments, 
-- including employees not assigned to any department and departments with no employees.

/*
Correct query for Full Outer Join, not supported in SQLite:
SELECT employees.employee_name, departments.department_name FROM employees
FULL OUTER JOIN departments on employees.department_id = departments.department_id;
*/
-- SQLite work-around for Full Outer Join
SELECT employees.employee_name, departments.department_name FROM employees
LEFT JOIN departments on employees.department_id = departments.department_id
UNION
SELECT employees.employee_name, departments.department_name FROM departments
LEFT JOIN employees on departments.department_id = employees.department_id;


-- e) Self JOIN
-- Write a query to retrieve a list of all employees and their managers. 
-- Both employees and managers are stored in the employees table.
SELECT e1.employee_name as employee, e2.employee_name as manager FROM employees e1
LEFT JOIN employees e2 on e1.manager_id = e2.employee_id;


-- f) Cross JOIN
-- Write a query that generates all possible combinations of product names and 
-- customer names using a cross join between the products and customers tables.
SELECT products.product_name, customers.customer_name FROM products
CROSS JOIN customers;


-- g) Natural JOIN
-- Write a query to retrieve a list of customers and their orders 
-- using a natural join between the customersand orders tables.
SELECT customer_name, product_name FROM customers
NATURAL JOIN orders;


-- h) JOIN with Aggregation
-- Retrieve the total number of products ordered by each customer. 
-- Use a join between customers and orders, grouping by customer_name.
SELECT customers.customer_name, count(orders.product_name) as total_products FROM customers
JOIN orders on customers.customer_id = orders.customer_id
GROUP by customers.customer_name;


-- i) Multiple Joins
-- Write a query that retrieves all order details, including customer name, product name, and order date. 
-- Use joins between customers, orders, and products.
SELECT customers.customer_name, products.product_name, orders.order_date FROM customers
JOIN orders on customers.customer_id = orders.customer_id
JOIN products on orders.product_id = products.product_id;





-- 2. FOREIGN KEYS (3)

-- a) FOREIGN KEY Definition
-- Create a books table with the following structure and define a foreign key referencing the authors table.
CREATE TABLE if NOT EXISTS authors (
	author_id INTEGER PRIMARY KEY AUTOINCREMENT,
	author_name TEXT NOT NULL);

CREATE TABLE if NOT EXISTS books (
	book_id INTEGER PRIMARY KEY AUTOINCREMENT,
	book_title TEXT NOT NULL,
	author_id INTEGER,
	FOREIGN KEY (author_id) REFERENCES authors(author_id));


-- b) Cascading Deletes
-- Define a products table where deleting a category in the
-- categories table automatically deletes all related products.
CREATE TABLE if NOT EXISTS categories (
	category_id INTEGER PRIMARY KEY AUTOINCREMENT,
	category_name TEXT NOT NULL);

CREATE TABLE if NOT EXISTS new_products (
	product_id INTEGER PRIMARY KEY AUTOINCREMENT,
	product_name TEXT NOT NULL,
	category_id INTEGER,
	FOREIGN KEY (category_id) REFERENCES categories(category_id) on DELETE CASCADE);
	
INSERT INTO new_products (product_name) SELECT product_name FROM products;

CREATE TABLE IF NOT EXISTS new_product_suppliers (
    product_id INTEGER,
    supplier_id INTEGER,
    PRIMARY KEY (product_id, supplier_id),
    FOREIGN KEY (product_id) REFERENCES new_products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id));
    
INSERT INTO new_product_suppliers (product_id, supplier_id) SELECT product_id, supplier_id FROM product_suppliers;
DROP TABLE product_suppliers;
DROP TABLE products;


-- c) Violating FOREIGN KEY CONSTRAINT
-- Write a query to insert a new order in the orders table. The orders table references the 
-- customers table through a foreign key. What will happen if you try to insert an order 
-- with a customer_id that doesn't exist in the customers table?
INSERT INTO orders (customer_id, product_name, order_date)
VALUES (9999, 'Smartphone', '2024-01-01');





-- 3. Consistency Constraints (7)

-- a) Unique CONSTRAINT
-- Write a query to create a users table with a unique constraint on the email column.
CREATE TABLE if NOT EXISTS users (
	user_id INTEGER PRIMARY KEY AUTOINCREMENT,
	user_name TEXT,
	email TEXT);


-- b) CHECK CONSTRAINT
-- Create a products table where the price must be greater than 0 using a CHECK constraint.
CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name TEXT NOT NULL,
    price REAL NOT NULL,
    CHECK (price > 0));

    
-- c) PRIMARY KEY and Consistency
-- Define a courses table with a composite primary key that includes both course_id and department_id.
CREATE TABLE IF NOT EXISTS courses (
    course_id INTEGER NOT NULL,
    department_id INTEGER NOT NULL,
    course_name TEXT NOT NULL,
    PRIMARY KEY (course_id, department_id));

    
-- d) FOREIGN KEY and Consistency
-- Create a student_courses table where each entry must reference valid student_id from the 
-- studentstable and course_id from the courses table, ensuring consistency between the two tables.
CREATE TABLE IF NOT EXISTS student_courses (
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    department_id INTEGER NOT NULL,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id, department_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id, department_id) REFERENCES courses(course_id, department_id));

    
-- e) Not NULL CONSTRAINT
-- Create a users table where the username and email fields must not be null.
CREATE TABLE if NOT EXISTS users (
	user_id INTEGER PRIMARY KEY AUTOINCREMENT,
	user_name TEXT NOT NULL,
	email TEXT NOT NULL);

	
-- f) Adding a CHECK CONSTRAINT to an Existing TABLE
-- Write a query to add a CHECK constraint to the employees 
-- table to ensure that the salary is greater than 0.
/*
Correct query for adding a CHECK CONSTRAINT, not supported in SQLite:
ALTER TABLE employees
ADD CONSTRAINT check_salary
CHECK (salary > 0);
*/
-- SQLite work-around for adding Check CONSTRAINT:
CREATE TABLE IF NOT EXISTS new_employees (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    employee_name TEXT NOT NULL,
    salary REAL NOT NULL,
    CHECK (salary > 0));

INSERT INTO new_employees (employee_id, employee_name, salary) SELECT employee_id, employee_name, salary FROM employees;
DROP TABLE employees;
ALTER TABLE new_employees RENAME TO employees;


-- g) Composite Key CONSTRAINT
-- Write a query to create a student_courses table where each row must be
-- unique  based on a combination of student_id and course_id (composite key).
CREATE TABLE IF NOT EXISTS student_courses (
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id));










