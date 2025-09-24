
-- ========================================================
-- Task 2: Data Insertion and Handling Nulls (based on Task 1 schema)
-- File: task2_dml.sql
-- ========================================================

USE ecommerce_db;

-- Insert Users
INSERT INTO users (user_id, username, email, password_hash, status) VALUES
(1, 'rahul', 'rahul@example.com', 'hash123', 'active'),
(2, 'anita', 'anita@example.com', 'hash234', 'active'),
(3, 'vikram', 'vikram@example.com', 'hash345', 'inactive');

-- Insert Addresses (with NULLs for optional fields)
INSERT INTO addresses (address_id, user_id, address_line1, address_line2, city, state, postal_code, country, is_default) VALUES
(1, 1, '123 Street', NULL, 'Delhi', NULL, '110001', 'India', TRUE),
(2, 2, '456 Avenue', 'Near Park', 'Mumbai', 'MH', '400001', 'India', FALSE),
(3, 3, '789 Road', NULL, 'Bangalore', NULL, NULL, 'India', TRUE);

-- Insert Categories
INSERT INTO categories (category_id, name) VALUES
(1, 'Electronics'), (2, 'Books'), (3, 'Clothing');

-- Insert Products
INSERT INTO products (product_id, name, description, price, stock_qty, category_id) VALUES
(1, 'Laptop', 'High performance laptop', 60000, 10, 1),
(2, 'Headphones', 'Noise cancelling', 2000, 25, 1),
(3, 'Novel', 'Fiction novel', 300, 50, 2),
(4, 'T-Shirt', 'Cotton round neck', 500, 100, 3);

-- Insert Orders
INSERT INTO orders (order_id, user_id, status, shipping_address_id, total_amount) VALUES
(1, 1, 'pending', 1, 0),
(2, 2, 'pending', 2, 0);

-- Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 60000),
(1, 2, 2, 2000),
(2, 3, 1, 300);

-- Update Orders to calculate total_amount
UPDATE orders SET total_amount = (
    SELECT SUM(quantity * unit_price) FROM order_items WHERE order_items.order_id = orders.order_id
);

-- Insert Payments
INSERT INTO payments (payment_id, order_id, amount, method, status, paid_at) VALUES
(1, 1, 64000, 'Card', 'completed', NOW()),
(2, 2, 300, 'UPI', 'completed', NOW());

-- Insert Reviews
INSERT INTO reviews (review_id, user_id, product_id, rating, comment) VALUES
(1, 1, 1, 5, 'Excellent laptop!'),
(2, 2, 3, 4, 'Enjoyed the book');

-- Demonstration of NULL handling (insert address without postal_code/state)
INSERT INTO addresses (user_id, address_line1, city, postal_code, country) VALUES
(1, '999 Mystery Lane', 'Chennai', NULL, 'India');

-- Demonstration of UPDATE multiple rows (set all inactive users to active)
UPDATE users SET status = 'active' WHERE status = 'inactive';

-- Demonstration of DELETE (remove a cancelled order)
DELETE FROM orders WHERE order_id = 2;

-- Demonstration of ROLLBACK (pseudo-code, run inside transaction)
-- BEGIN;
-- DELETE FROM orders WHERE order_id = 1;
-- ROLLBACK;

-- Demonstration of INSERT INTO ... SELECT (duplicate a product for testing)
INSERT INTO products (name, description, price, stock_qty, category_id)
SELECT CONCAT(name, ' - Copy'), description, price, stock_qty, category_id
FROM products WHERE product_id = 1;

-- Final check
SELECT * FROM users;
SELECT * FROM addresses;
SELECT * FROM categories;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;
SELECT * FROM reviews;
