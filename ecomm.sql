/*
|--- eCommerce Simulation ---|
*/
 
-- 1) Create tables
CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	user_name TEXT,
	user_email TEXT
);

CREATE TABLE products (
	product_id SERIAL PRIMARY KEY,
	product_name TEXT,
	product_price FLOAT
);

CREATE TABLE orders (
	order_id SERIAL PRIMARY KEY,
	order_num INTEGER,
	user_id INTEGER REFERENCES users(user_id),
	product_id INTEGER REFERENCES products(product_id)
);

-- 2) Add data to tables
INSERT INTO users
(user_name, user_email)
VALUES
('Customer 1', 'c1@dev.mtn'),
('Customer 2', 'c2@dev.mtn'),
('Customer 3', 'c3@dev.mtn');

INSERT INTO products
(product_name, product_price)
VALUES
('Product 1', 14.99),
('Product 2', 25.00),
('Product 3', 120.50),
('Product 4', 60.40),
('Product 5', 79.99),
('Product 6', 80.00);

INSERT INTO orders
(order_num, user_id, product_id)
VALUES
(1, 1, 1),
(1, 1, 2),
(2, 2, 1),
(2, 2, 2),
(2, 2, 3),
(3, 2, 1),
(3, 2, 3),
(4, 3, 1),
(5, 1, 2),
(5, 1, 3),
(6, 3, 2),
(6, 3, 3),
(7, 3, 4),
(7, 3, 5),
(8, 1, 6),
(9, 2, 4),
(9, 2, 5),
(10, 3, 4),
(10, 3, 5),
(10, 3, 6);

-- 3) Queries

---- 3A) All products for the first order
SELECT p.product_name AS "first order products"
FROM products AS p
JOIN orders AS o
	ON p.product_id = o.product_id
WHERE o.order_num = 1;

---- 3B) All orders
SELECT DISTINCT o.order_num, u.user_name, p.product_name
FROM orders AS o
JOIN products AS p
	ON o.product_id = p.product_id
JOIN users as u
	ON o.user_id = u.user_id
ORDER BY 1, 2, 3;

---- 3C) Total cost of an order
SELECT o.order_num, SUM(p.product_price) AS "total cost"
FROM orders AS o
INNER JOIN products AS p
	ON o.product_id = p.product_id
GROUP BY o.order_num
ORDER BY o.order_num;

-- 4) Add foreign key reference from order to users (completed in Step 1)

-- 5) Update orders to link users to orders (completed in Steps 1 & 2)

-- 6) Queries

---- 6A) All orders for a user
SELECT DISTINCT u.user_name, o.order_num
FROM users AS u
JOIN orders AS o
	ON u.user_id = o.user_id
ORDER BY 1, 2;

---- 6B) How many orders each user has
SELECT u.user_name, COUNT(DISTINCT o.order_num) AS "total orders"
FROM users AS u
JOIN orders AS o
	ON u.user_id = o.user_id
GROUP BY u.user_name
ORDER BY 1, 2;

-- BLACK DIAMOND: Total amount on all orders for each user
SELECT 
	u.user_name,
	SUM(p.product_price) AS "total spent",
	COUNT(DISTINCT o.order_num) AS "total orders",
	ROUND((SUM(p.product_price)/COUNT(DISTINCT o.order_num))::numeric, 2) AS "average spend per order"
FROM users AS u
JOIN orders as o
	ON u.user_id = o.user_id
JOIN products AS p
	ON o.product_id = p.product_id
GROUP BY u.user_name
ORDER BY 1, 2;
