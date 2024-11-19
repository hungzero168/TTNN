drop database if exists mvhung;
create database if not exists mvhung;
use mvhung;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(50) UNIQUE,
    title VARCHAR(255),
    price DECIMAL(10, 2),
    sale_price DECIMAL(10, 2),
    featured_image VARCHAR(255),
    description TEXT,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified_date DATETIME ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE product_gallery (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    gallery_image VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE
);

CREATE TABLE tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(100) UNIQUE
);

CREATE TABLE product_categories (
    product_id INT,
    category_id INT,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

CREATE TABLE product_tags (
    product_id INT,
    tag_id INT,
    PRIMARY KEY (product_id, tag_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);

-- Sample data for products table
INSERT INTO products (sku, title, price, sale_price, featured_image, description) VALUES
('PROD001', 'Smartphone X', 999.99, 899.99, 'smartphone_x.jpg', 'Latest smartphone with advanced features'),
('PROD002', 'Laptop Pro', 1499.99, 1399.99, 'laptop_pro.jpg', 'High-performance laptop for professionals'),
('PROD003', 'Wireless Earbuds', 149.99, 129.99, 'wireless_earbuds.jpg', 'True wireless earbuds with noise cancellation'),
('PROD004', '4K Smart TV', 799.99, 749.99, '4k_smart_tv.jpg', '55-inch 4K Smart TV with HDR'),
('PROD005', 'Fitness Tracker', 79.99, 69.99, 'fitness_tracker.jpg', 'Water-resistant fitness tracker with heart rate monitor'),
('PROD006', 'Gaming Console', 499.99, 449.99, 'gaming_console.jpg', 'Next-gen gaming console with 4K graphics'),
('PROD007', 'Bluetooth Speaker', 129.99, 99.99, 'bluetooth_speaker.jpg', 'Portable waterproof Bluetooth speaker'),
('PROD008', 'Digital Camera', 699.99, 649.99, 'digital_camera.jpg', 'Mirrorless digital camera with 4K video'),
('PROD009', 'Smart Watch', 299.99, 279.99, 'smart_watch.jpg', 'Fitness-focused smartwatch with GPS'),
('PROD010', 'Tablet', 399.99, 349.99, 'tablet.jpg', '10-inch tablet with high-resolution display'),
('PROD011', 'Wireless Mouse', 49.99, 39.99, 'wireless_mouse.jpg', 'Ergonomic wireless mouse with long battery life'),
('PROD012', 'External SSD', 159.99, 139.99, 'external_ssd.jpg', '1TB external SSD with USB-C connection'),
('PROD013', 'Smart Thermostat', 199.99, 179.99, 'smart_thermostat.jpg', 'Wi-Fi enabled smart thermostat for energy savings'),
('PROD014', 'Wireless Keyboard', 79.99, 69.99, 'wireless_keyboard.jpg', 'Slim wireless keyboard with backlit keys'),
('PROD015', 'Portable Charger', 39.99, 29.99, 'portable_charger.jpg', '10000mAh portable charger with fast charging'),
('PROD016', 'Noise-Cancelling Headphones', 299.99, 269.99, 'noise_cancelling_headphones.jpg', 'Over-ear headphones with active noise cancellation'),
('PROD017', 'Smart Doorbell', 179.99, 159.99, 'smart_doorbell.jpg', 'Wi-Fi video doorbell with two-way audio'),
('PROD018', 'Wireless Router', 129.99, 109.99, 'wireless_router.jpg', 'Dual-band Wi-Fi 6 router for fast home networking'),
('PROD019', 'Portable Projector', 399.99, 349.99, 'portable_projector.jpg', 'Mini LED projector with built-in battery'),
('PROD020', 'Electric Toothbrush', 89.99, 79.99, 'electric_toothbrush.jpg', 'Smart electric toothbrush with pressure sensor'),
('PROD021', 'Dash Cam', 149.99, 129.99, 'dash_cam.jpg', '4K dash cam with GPS and Wi-Fi'),
('PROD022', 'Smart Light Bulbs', 59.99, 49.99, 'smart_light_bulbs.jpg', 'Set of 4 color-changing smart LED bulbs'),
('PROD023', 'Wireless Earphones', 99.99, 89.99, 'wireless_earphones.jpg', 'Sports wireless earphones with ear hooks'),
('PROD024', 'Robot Vacuum', 299.99, 249.99, 'robot_vacuum.jpg', 'Smart robot vacuum with mapping technology'),
('PROD025', 'Portable Monitor', 199.99, 179.99, 'portable_monitor.jpg', '15.6-inch USB-C portable monitor'),
('PROD026', 'Smart Scale', 69.99, 59.99, 'smart_scale.jpg', 'Wi-Fi connected smart scale with body composition analysis'),
('PROD027', 'Wireless Charging Pad', 39.99, 29.99, 'wireless_charging_pad.jpg', 'Fast wireless charging pad for smartphones'),
('PROD028', 'Action Camera', 249.99, 219.99, 'action_camera.jpg', '4K action camera with image stabilization'),
('PROD029', 'Smart Plug', 24.99, 19.99, 'smart_plug.jpg', 'Wi-Fi smart plug compatible with voice assistants'),
('PROD030', 'Bluetooth Transmitter', 34.99, 29.99, 'bluetooth_transmitter.jpg', 'Bluetooth 5.0 transmitter for TV and audio devices');

-- Sample data for product_gallery table
INSERT INTO product_gallery (product_id, gallery_image) VALUES
(1, 'smartphone_x_front.jpg'),
(1, 'smartphone_x_back.jpg'),
(2, 'laptop_pro_open.jpg'),
(2, 'laptop_pro_closed.jpg'),
(3, 'wireless_earbuds_case.jpg'),
(3, 'wireless_earbuds_in_ear.jpg'),
(4, '4k_smart_tv_front.jpg'),
(4, '4k_smart_tv_side.jpg'),
(5, 'fitness_tracker_black.jpg'),
(5, 'fitness_tracker_blue.jpg'),
(6, 'gaming_console_front.jpg'),
(6, 'gaming_console_side.jpg'),
(7, 'bluetooth_speaker_black.jpg'),
(7, 'bluetooth_speaker_red.jpg'),
(8, 'digital_camera_front.jpg'),
(8, 'digital_camera_back.jpg'),
(9, 'smart_watch_black.jpg'),
(9, 'smart_watch_white.jpg'),
(10, 'tablet_front.jpg'),
(10, 'tablet_back.jpg');

-- Sample data for categories table
INSERT INTO categories (category_name) VALUES
('Electronics'),
('Computers'),
('Audio'),
('Home Entertainment'),
('Wearables'),
('Gaming'),
('Photography'),
('Smart Home'),
('Mobile Accessories'),
('Health & Fitness');

-- Sample data for tags table
INSERT INTO tags (tag_name) VALUES
('New Arrival'),
('Best Seller'),
('Sale'),
('Premium'),
('Budget-friendly'),
('Wireless'),
('4K'),
('Smart Device'),
('Portable'),
('High Performance');

-- Sample data for product_categories table
INSERT INTO product_categories (product_id, category_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 3), (8, 7), (9, 5), (10, 2),
(11, 2), (12, 2), (13, 8), (14, 2), (15, 9),
(16, 3), (17, 8), (18, 1), (19, 4), (20, 10),
(21, 1), (22, 8), (23, 3), (24, 8), (25, 2),
(26, 10), (27, 9), (28, 7), (29, 8), (30, 3);

-- Sample data for product_tags table
INSERT INTO product_tags (product_id, tag_id) VALUES
(1, 1), (1, 4), (2, 2), (2, 4), (3, 3), (3, 5),
(4, 2), (4, 7), (5, 1), (5, 8), (6, 1), (6, 6),
(7, 3), (7, 9), (8, 4), (8, 7), (9, 2), (9, 8),
(10, 1), (10, 9), (11, 5), (11, 6), (12, 2), (12, 10),
(13, 8), (13, 10), (14, 5), (14, 6), (15, 3), (15, 9),
(16, 4), (16, 6), (17, 1), (17, 8), (18, 2), (18, 10),
(19, 3), (19, 9), (20, 8), (20, 10), (21, 1), (21, 7),
(22, 3), (22, 8), (23, 5), (23, 6), (24, 2), (24, 8),
(25, 9), (25, 10), (26, 8), (26, 10), (27, 5), (27, 6),
(28, 1), (28, 7), (29, 3), (29, 8), (30, 5), (30, 6);


-- query  hiển thị tất cả dữ liệu trong 1 bảng
SELECT p.id, p.sku, p.title, p.price, p.sale_price, p.featured_image,
       p.description, p.created_date, p.modified_date,
       GROUP_CONCAT(g.gallery_image) AS gallery,
       GROUP_CONCAT(c.category_name) AS categories,
       GROUP_CONCAT(t.tag_name) AS tags
FROM products p
LEFT JOIN product_gallery g ON p.id = g.product_id
LEFT JOIN product_categories pc ON p.id = pc.product_id
LEFT JOIN categories c ON pc.category_id = c.id
LEFT JOIN product_tags pt ON p.id = pt.product_id
LEFT JOIN tags t ON pt.tag_id = t.id
GROUP BY p.id;

-- query  hiển thị 1 dữ liệu trong 
SELECT p.id, p.sku, p.title, p.price, p.sale_price, p.featured_image,
       p.description, p.created_date, p.modified_date,
       GROUP_CONCAT(g.gallery_image) AS gallery,
       GROUP_CONCAT(c.category_name) AS categories,
       GROUP_CONCAT(t.tag_name) AS tags
FROM products p
LEFT JOIN product_gallery g ON p.id = g.product_id
LEFT JOIN product_categories pc ON p.id = pc.product_id
LEFT JOIN categories c ON pc.category_id = c.id
LEFT JOIN product_tags pt ON p.id = pt.product_id
LEFT JOIN tags t ON pt.tag_id = t.id
WHERE p.id = '01';
GROUP BY p.id;
