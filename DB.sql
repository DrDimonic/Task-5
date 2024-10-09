BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "customers" (
	"customer_id"	INTEGER,
	"customer_name"	TEXT NOT NULL,
	PRIMARY KEY("customer_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "orders" (
	"order_id"	INTEGER,
	"customer_id"	INTEGER,
	"product_name"	TEXT NOT NULL,
	"order_date"	DATE,
	"product_id"	INTEGER,
	FOREIGN KEY("customer_id") REFERENCES "customers"("customer_id"),
	PRIMARY KEY("order_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "suppliers" (
	"supplier_id"	INTEGER,
	"supplier_name"	TEXT NOT NULL,
	PRIMARY KEY("supplier_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "departments" (
	"department_id"	INTEGER,
	"department_name"	TEXT NOT NULL,
	PRIMARY KEY("department_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "authors" (
	"author_id"	INTEGER,
	"author_name"	TEXT NOT NULL,
	PRIMARY KEY("author_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "books" (
	"book_id"	INTEGER,
	"book_title"	TEXT NOT NULL,
	"author_id"	INTEGER,
	FOREIGN KEY("author_id") REFERENCES "authors"("author_id"),
	PRIMARY KEY("book_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "products_with_category" (
	"product_id"	INTEGER,
	"product_name"	TEXT NOT NULL,
	"category_id"	INTEGER,
	FOREIGN KEY("category_id") REFERENCES "categories"("category_id") ON DELETE CASCADE,
	PRIMARY KEY("product_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "categories" (
	"category_id"	INTEGER,
	"category_name"	TEXT NOT NULL,
	PRIMARY KEY("category_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "new_products" (
	"product_id"	INTEGER,
	"product_name"	TEXT NOT NULL,
	"category_id"	INTEGER,
	FOREIGN KEY("category_id") REFERENCES "categories"("category_id") on DELETE CASCADE,
	PRIMARY KEY("product_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "new_product_suppliers" (
	"product_id"	INTEGER,
	"supplier_id"	INTEGER,
	FOREIGN KEY("supplier_id") REFERENCES "suppliers"("supplier_id"),
	FOREIGN KEY("product_id") REFERENCES "new_products"("product_id") ON DELETE CASCADE,
	PRIMARY KEY("product_id","supplier_id")
);
CREATE TABLE IF NOT EXISTS "users" (
	"user_id"	INTEGER,
	"user_name"	TEXT NOT NULL,
	"email"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("user_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "products" (
	"product_id"	INTEGER,
	"product_name"	TEXT NOT NULL,
	"price"	REAL NOT NULL,
	CHECK("price" > 0),
	PRIMARY KEY("product_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "courses" (
	"course_id"	INTEGER NOT NULL,
	"department_id"	INTEGER NOT NULL,
	"course_name"	TEXT NOT NULL,
	PRIMARY KEY("course_id","department_id")
);
CREATE TABLE IF NOT EXISTS "student_courses" (
	"student_id"	INTEGER NOT NULL,
	"course_id"	INTEGER NOT NULL,
	"department_id"	INTEGER NOT NULL,
	"enrollment_date"	DATE,
	FOREIGN KEY("student_id") REFERENCES "students"("student_id"),
	FOREIGN KEY("course_id","department_id") REFERENCES "courses"("course_id","department_id"),
	PRIMARY KEY("student_id","course_id","department_id")
);
CREATE TABLE IF NOT EXISTS "employees" (
	"employee_id"	INTEGER,
	"employee_name"	TEXT NOT NULL,
	"salary"	REAL NOT NULL,
	CHECK("salary" > 0),
	PRIMARY KEY("employee_id" AUTOINCREMENT)
);
INSERT INTO "customers" VALUES (1,'Adam Thompson');
INSERT INTO "customers" VALUES (2,'Brittany Lewis');
INSERT INTO "customers" VALUES (3,'Charles Evans');
INSERT INTO "customers" VALUES (4,'Danielle Garcia');
INSERT INTO "customers" VALUES (5,'Ethan Roberts');
INSERT INTO "orders" VALUES (1,1,'Smart TV','2024-01-01',1);
INSERT INTO "orders" VALUES (2,2,'Laptop','2024-03-11',2);
INSERT INTO "orders" VALUES (3,3,'Headphones','2024-06-20',3);
INSERT INTO "orders" VALUES (4,4,'Smartphone','2024-10-17',4);
INSERT INTO "orders" VALUES (5,5,'Tablet','2024-12-25',5);
INSERT INTO "suppliers" VALUES (1,'TechDirect Inc.');
INSERT INTO "suppliers" VALUES (2,'GizmoCorp');
INSERT INTO "suppliers" VALUES (3,'Innovate Solutions');
INSERT INTO "suppliers" VALUES (4,'ElectroWorld');
INSERT INTO "suppliers" VALUES (5,'Future Tech');
INSERT INTO "departments" VALUES (1,'Sales');
INSERT INTO "departments" VALUES (2,'HR');
INSERT INTO "departments" VALUES (3,'IT');
INSERT INTO "departments" VALUES (4,'Finance');
INSERT INTO "departments" VALUES (5,'Marketing');
INSERT INTO "authors" VALUES (1,'Isaac Asimov');
INSERT INTO "authors" VALUES (2,'Agatha Christie');
INSERT INTO "authors" VALUES (3,'Mark Twain');
INSERT INTO "authors" VALUES (4,'Jane Austen');
INSERT INTO "authors" VALUES (5,'H.G. Wells');
INSERT INTO "books" VALUES (1,'Foundation',1);
INSERT INTO "books" VALUES (2,'Murder on the Orient Express',2);
INSERT INTO "books" VALUES (3,'The Adventures of Tom Sawyer',3);
INSERT INTO "books" VALUES (4,'Pride and Prejudice',4);
INSERT INTO "books" VALUES (5,'The Time Machine',5);
INSERT INTO "new_products" VALUES (1,'Smart TV',NULL);
INSERT INTO "new_products" VALUES (2,'Laptop',NULL);
INSERT INTO "new_products" VALUES (3,'Headphones',NULL);
INSERT INTO "new_products" VALUES (4,'Smartphone',NULL);
INSERT INTO "new_products" VALUES (5,'Tablet',NULL);
INSERT INTO "new_products" VALUES (6,'Smart TV',NULL);
INSERT INTO "new_products" VALUES (7,'Laptop',NULL);
INSERT INTO "new_products" VALUES (8,'Headphones',NULL);
INSERT INTO "new_products" VALUES (9,'Smartphone',NULL);
INSERT INTO "new_products" VALUES (10,'Tablet',NULL);
INSERT INTO "new_products" VALUES (11,'Smart TV',NULL);
INSERT INTO "new_products" VALUES (12,'Laptop',NULL);
INSERT INTO "new_products" VALUES (13,'Headphones',NULL);
INSERT INTO "new_products" VALUES (14,'Smartphone',NULL);
INSERT INTO "new_products" VALUES (15,'Tablet',NULL);
INSERT INTO "new_product_suppliers" VALUES (1,1);
INSERT INTO "new_product_suppliers" VALUES (2,2);
INSERT INTO "new_product_suppliers" VALUES (3,3);
INSERT INTO "new_product_suppliers" VALUES (4,4);
INSERT INTO "new_product_suppliers" VALUES (5,5);
INSERT INTO "employees" VALUES (1,'John Doe',50000.0);
INSERT INTO "employees" VALUES (2,'Jane Smith',60000.0);
INSERT INTO "employees" VALUES (3,'Emily Johnson',55000.0);
INSERT INTO "employees" VALUES (4,'Michael Brown',75000.0);
INSERT INTO "employees" VALUES (5,'Sarah Wilson',80000.0);
COMMIT;
