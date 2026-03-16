-- ============================================================
-- Coffee Shop POS — Seed Data
-- Run AFTER schema.sql
-- ============================================================

USE coffee_shop_pos;

-- ========== DEFAULT ADMIN USER ==========
-- Password: admin123  (BCrypt hash)
INSERT INTO users (username, password_hash, full_name, role) VALUES
('admin',   '$2a$11$K7R0IkFhSbSzQFo8kOZr2e8TfJl0l0KaYMKGqh1CkRKBz1r5h1FXe', 'System Admin',   'Admin'),
('manager', '$2a$11$K7R0IkFhSbSzQFo8kOZr2e8TfJl0l0KaYMKGqh1CkRKBz1r5h1FXe', 'Store Manager',  'Manager'),
('cashier', '$2a$11$K7R0IkFhSbSzQFo8kOZr2e8TfJl0l0KaYMKGqh1CkRKBz1r5h1FXe', 'Jane Cashier',   'Cashier'),
('waiter',  '$2a$11$K7R0IkFhSbSzQFo8kOZr2e8TfJl0l0KaYMKGqh1CkRKBz1r5h1FXe', 'John Waiter',    'Waiter');

-- ========== CATEGORIES ==========
INSERT INTO categories (name, description) VALUES
('Hot Coffee',     'Freshly brewed hot coffee drinks'),
('Cold Coffee',    'Iced and blended coffee drinks'),
('Tea',            'Hot and iced teas'),
('Pastries',       'Freshly baked pastries and cakes'),
('Sandwiches',     'Light meals and sandwiches'),
('Beverages',      'Non-coffee beverages');

-- ========== MENU ITEMS ==========
INSERT INTO menu_items (category_id, name, description, price) VALUES
-- Hot Coffee
(1, 'Espresso',           'Single shot of espresso',         150.00),
(1, 'Double Espresso',    'Double shot of espresso',         200.00),
(1, 'Americano',          'Espresso with hot water',         180.00),
(1, 'Cappuccino',         'Espresso with steamed milk foam', 250.00),
(1, 'Latte',              'Espresso with steamed milk',      270.00),
(1, 'Mocha',              'Espresso, chocolate, steamed milk', 300.00),
-- Cold Coffee
(2, 'Iced Americano',     'Espresso over ice with water',    200.00),
(2, 'Iced Latte',         'Espresso with cold milk and ice', 280.00),
(2, 'Frappuccino',        'Blended coffee with cream',       350.00),
(2, 'Cold Brew',          'Slow-steeped cold coffee',        300.00),
-- Tea
(3, 'Green Tea',          'Japanese green tea',              150.00),
(3, 'Black Tea',          'Classic black tea',               120.00),
(3, 'Chai Latte',         'Spiced tea with steamed milk',    250.00),
-- Pastries
(4, 'Croissant',          'Butter croissant',                180.00),
(4, 'Chocolate Muffin',   'Rich chocolate muffin',           200.00),
(4, 'Blueberry Scone',    'Fresh blueberry scone',           220.00),
(4, 'Cheesecake Slice',   'New York cheesecake',             350.00),
-- Sandwiches
(5, 'Club Sandwich',      'Triple-decker club sandwich',     400.00),
(5, 'Grilled Cheese',     'Classic grilled cheese',          300.00),
(5, 'Chicken Wrap',       'Grilled chicken wrap',            350.00),
-- Beverages
(6, 'Fresh Orange Juice', 'Freshly squeezed OJ',            200.00),
(6, 'Mineral Water',      'Sparkling mineral water',         80.00),
(6, 'Hot Chocolate',      'Rich hot chocolate',              250.00);

-- ========== TABLES ==========
INSERT INTO tables (table_number, capacity, status) VALUES
('T1',  2, 'Available'),
('T2',  2, 'Available'),
('T3',  4, 'Available'),
('T4',  4, 'Available'),
('T5',  4, 'Available'),
('T6',  6, 'Available'),
('T7',  6, 'Available'),
('T8',  8, 'Available'),
('T9',  8, 'Available'),
('T10', 10, 'Available');

-- ========== INVENTORY ==========
INSERT INTO inventory (name, unit, quantity, reorder_level, cost_per_unit) VALUES
('Coffee Beans',       'kg',     50.00, 10.00, 800.00),
('Milk',               'liters', 40.00, 15.00, 120.00),
('Sugar',              'kg',     25.00,  5.00,  80.00),
('Chocolate Syrup',    'liters', 10.00,  3.00, 350.00),
('Tea Leaves',         'kg',     15.00,  5.00, 500.00),
('Butter',             'kg',     10.00,  3.00, 400.00),
('Flour',              'kg',     20.00,  5.00, 100.00),
('Cream',              'liters', 15.00,  5.00, 200.00),
('Bread',              'pcs',    30.00, 10.00,  60.00),
('Chicken',            'kg',     10.00,  3.00, 500.00),
('Cheese',             'kg',      8.00,  2.00, 600.00),
('Orange Juice',       'liters', 20.00,  5.00, 150.00),
('Cups (Disposable)',  'pcs',   200.00, 50.00,   5.00),
('Napkins',            'pcs',   500.00, 100.00,  2.00);
