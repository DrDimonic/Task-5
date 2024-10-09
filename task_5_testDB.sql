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
	PRIMARY KEY("order_id" AUTOINCREMENT),
	FOREIGN KEY("customer_id") REFERENCES "customers"("customer_id")
);
CREATE TABLE IF NOT EXISTS "products" (
	"product_id"	INTEGER,
	"product_name"	TEXT NOT NULL,
	PRIMARY KEY("product_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "suppliers" (
	"supplier_id"	INTEGER,
	"supplier_name"	TEXT NOT NULL,
	PRIMARY KEY("supplier_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "product_suppliers" (
	"product_id"	INTEGER,
	"supplier_id"	INTEGER,
	PRIMARY KEY("product_id","supplier_id"),
	FOREIGN KEY("product_id") REFERENCES "products"("product_id"),
	FOREIGN KEY("supplier_id") REFERENCES "suppliers"("supplier_id")
);
CREATE TABLE IF NOT EXISTS "employees" (
	"employee_id"	INTEGER,
	"employee_name"	TEXT NOT NULL,
	"department_id"	INTEGER,
	"manager_id"	INTEGER,
	PRIMARY KEY("employee_id" AUTOINCREMENT),
	FOREIGN KEY("department_id") REFERENCES "departments"("department_id"),
	FOREIGN KEY("manager_id") REFERENCES "employees"("employee_id")
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
	PRIMARY KEY("book_id" AUTOINCREMENT),
	FOREIGN KEY("author_id") REFERENCES "authors"("author_id")
);
CREATE TABLE IF NOT EXISTS "categories" (
	"category_id"	INTEGER,
	"category_name"	TEXT NOT NULL,
	PRIMARY KEY("category_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "products_with_category" (
	"product_id"	INTEGER,
	"product_name"	TEXT NOT NULL,
	"category_id"	INTEGER,
	PRIMARY KEY("product_id" AUTOINCREMENT),
	FOREIGN KEY("category_id") REFERENCES "categories"("category_id") ON DELETE CASCADE
);
INSERT INTO "customers" VALUES (1,'Adam Thompson');
INSERT INTO "customers" VALUES (2,'Brittany Lewis');
INSERT INTO "customers" VALUES (3,'Charles Evans');
INSERT INTO "customers" VALUES (4,'Danielle Garcia');
INSERT INTO "customers" VALUES (5,'Ethan Roberts');
INSERT INTO "orders" VALUES (1,1,'Smart TV');
INSERT INTO "orders" VALUES (2,2,'Laptop');
INSERT INTO "orders" VALUES (3,3,'Headphones');
INSERT INTO "orders" VALUES (4,4,'Smartphone');
INSERT INTO "orders" VALUES (5,5,'Tablet');
INSERT INTO "products" VALUES (1,'Smart TV');
INSERT INTO "products" VALUES (2,'Laptop');
INSERT INTO "products" VALUES (3,'Headphones');
INSERT INTO "products" VALUES (4,'Smartphone');
INSERT INTO "products" VALUES (5,'Tablet');
INSERT INTO "suppliers" VALUES (1,'TechDirect Inc.');
INSERT INTO "suppliers" VALUES (2,'GizmoCorp');
INSERT INTO "suppliers" VALUES (3,'Innovate Solutions');
INSERT INTO "suppliers" VALUES (4,'ElectroWorld');
INSERT INTO "suppliers" VALUES (5,'Future Tech');
INSERT INTO "product_suppliers" VALUES (1,1);
INSERT INTO "product_suppliers" VALUES (2,2);
INSERT INTO "product_suppliers" VALUES (3,3);
INSERT INTO "product_suppliers" VALUES (4,4);
INSERT INTO "product_suppliers" VALUES (5,5);
INSERT INTO "employees" VALUES (1,'Sarah Johnson',1,NULL);
INSERT INTO "employees" VALUES (2,'Liam Taylor',1,1);
INSERT INTO "employees" VALUES (3,'Emily Harris',2,NULL);
INSERT INTO "employees" VALUES (4,'Noah Clark',2,3);
INSERT INTO "employees" VALUES (5,'Olivia Martinez',3,NULL);
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
INSERT INTO "categories" VALUES (1,'Electronics');
INSERT INTO "categories" VALUES (2,'Books');
INSERT INTO "categories" VALUES (3,'Home Appliances');
INSERT INTO "categories" VALUES (4,'Fashion');
INSERT INTO "categories" VALUES (5,'Toys');
INSERT INTO "products_with_category" VALUES (1,'Smart TV',1);
INSERT INTO "products_with_category" VALUES (2,'Laptop',1);
INSERT INTO "products_with_category" VALUES (3,'Headphones',1);
INSERT INTO "products_with_category" VALUES (4,'Pride and Prejudice',2);
INSERT INTO "products_with_category" VALUES (5,'The Time Machine',2);
COMMIT;
