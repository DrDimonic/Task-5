-- Dominic Cork

-- a) Inner JOIN
-- Write a query to retrieve the names of all customers and the products they have ordered. Use the customers and orders tables.
SELECT customers.customer_name, orders.product_name FROM customers
INNER JOIN orders on customers.customer_id = orders.customer_id;

-- b) Left JOIN
-- Retrieve a list of all customers and their corresponding orders.
Include customers who have not placed any orders.
SELECT customers.customer_name, orders.product_name FROM customers
LEFT JOIN orders on customers.customer_id = orders.customer_id;

-- c) Right JOIN
-- List all products along with the suppliers who provide them, including products that have no supplier listed.
SELECT products.product_name, suppliers.supplier_name FROM products
RIGHT JOIN product_suppliers on products.product_id = product_suppliers.product_id
RIGHT JOIN suppliers on product_suppliers.supplier_id = suppliers.supplier_id;


-- d) Full Outer JOIN
-- Retrieve all employee names and departments, including employees not assigned to any department and departments with no employees.

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
-- Write a query to retrieve a list of all employees and their managers. Both employees and managers are stored in the employees table.
SELECT e1.employee_name as employee, e2.employee_name as manager FROM employees e1
LEFT JOIN employees e2 on e1.manager_id = e2.employee_id;


-- f) Cross JOIN
-- Write a query that generates all possible combinations of product names and customer names using a cross join between the products and customers tables.
SELECT products.product_name, customers.customer_name FROM products
CROSS JOIN customers;


-- g) Natural JOIN
-- Write a query to retrieve a list of customers and their orders using a natural join between the customersand orders tables.
SELECT customer_name, product_name FROM customers
NATURAL JOIN orders;


-- h) JOIN with Aggregation
-- Retrieve the total number of products ordered by each customer. Use a join between customers and orders, grouping by customer_name.
SELECT customers.customer_name, count(orders.product_name) as total_products FROM customers
JOIN orders on customers.customer_id = orders.customer_id
GROUP by customers.customer_name;


-- i) Multiple Joins
-- Write a query that retrieves all order details, including customer name, product name, and order date. Use joins between customers, orders, and products.
SELECT customers.customer_name, products.product_name, orders.order_date FROM customers
JOIN orders on customers.customer_id = orders.customer_id
JOIN products on orders.product_id = products.product_id;










