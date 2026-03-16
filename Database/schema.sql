-- ============================================================
-- Coffee Shop POS — Database Schema
-- MySQL 8.x
-- ============================================================

CREATE DATABASE IF NOT EXISTS coffee_shop_pos
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE coffee_shop_pos;

-- ========== USERS / STAFF ==========
CREATE TABLE users (
    user_id       INT AUTO_INCREMENT PRIMARY KEY,
    username      VARCHAR(50)  UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name     VARCHAR(100) NOT NULL,
    role          ENUM('Admin','Manager','Cashier','Waiter') NOT NULL,
    is_active     TINYINT(1) DEFAULT 1,
    created_at    DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ========== CATEGORIES ==========
CREATE TABLE categories (
    category_id   INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    description   VARCHAR(255),
    is_active     TINYINT(1) DEFAULT 1
) ENGINE=InnoDB;

-- ========== MENU ITEMS ==========
CREATE TABLE menu_items (
    item_id       INT AUTO_INCREMENT PRIMARY KEY,
    category_id   INT NOT NULL,
    name          VARCHAR(100) NOT NULL,
    description   VARCHAR(255),
    price         DECIMAL(10,2) NOT NULL,
    is_available  TINYINT(1) DEFAULT 1,
    image_path    VARCHAR(255),
    created_at    DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ========== TABLES ==========
CREATE TABLE tables (
    table_id      INT AUTO_INCREMENT PRIMARY KEY,
    table_number  VARCHAR(10) UNIQUE NOT NULL,
    capacity      INT NOT NULL,
    status        ENUM('Available','Occupied','Reserved') DEFAULT 'Available'
) ENGINE=InnoDB;

-- ========== ORDERS ==========
CREATE TABLE orders (
    order_id       INT AUTO_INCREMENT PRIMARY KEY,
    table_id       INT,
    user_id        INT NOT NULL,
    order_type     ENUM('Dine-In','Takeaway') DEFAULT 'Dine-In',
    status         ENUM('Pending','Preparing','Served','Completed','Cancelled')
                   DEFAULT 'Pending',
    subtotal       DECIMAL(10,2) DEFAULT 0.00,
    tax            DECIMAL(10,2) DEFAULT 0.00,
    discount       DECIMAL(10,2) DEFAULT 0.00,
    total          DECIMAL(10,2) DEFAULT 0.00,
    payment_method ENUM('Cash','Card','Online') DEFAULT 'Cash',
    created_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
    completed_at   DATETIME,
    FOREIGN KEY (table_id) REFERENCES tables(table_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (user_id)  REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ========== ORDER ITEMS ==========
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id      INT NOT NULL,
    item_id       INT NOT NULL,
    quantity      INT NOT NULL DEFAULT 1,
    unit_price    DECIMAL(10,2) NOT NULL,
    notes         VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (item_id)  REFERENCES menu_items(item_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ========== INVENTORY ==========
CREATE TABLE inventory (
    inventory_id  INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    unit          VARCHAR(20)  NOT NULL,
    quantity      DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    reorder_level DECIMAL(10,2) DEFAULT 10.00,
    cost_per_unit DECIMAL(10,2),
    last_updated  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ========== INVENTORY LOG ==========
CREATE TABLE inventory_log (
    log_id        INT AUTO_INCREMENT PRIMARY KEY,
    inventory_id  INT NOT NULL,
    change_qty    DECIMAL(10,2) NOT NULL,
    reason        VARCHAR(255),
    changed_by    INT,
    changed_at    DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (changed_by)   REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- ========== INDEXES FOR PERFORMANCE ==========
CREATE INDEX idx_orders_created   ON orders(created_at);
CREATE INDEX idx_orders_status    ON orders(status);
CREATE INDEX idx_orders_table     ON orders(table_id);
CREATE INDEX idx_menu_category    ON menu_items(category_id);
CREATE INDEX idx_inv_log_inv      ON inventory_log(inventory_id);
