-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 05, 2024 lúc 03:33 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `mvhung`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `category_name`) VALUES
(3, 'Audio'),
(2, 'Computers'),
(1, 'Electronics'),
(6, 'Gaming'),
(10, 'Health & Fitness'),
(4, 'Home Entertainment'),
(9, 'Mobile Accessories'),
(7, 'Photography'),
(8, 'Smart Home'),
(5, 'Wearables');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `sku` varchar(50),
  `title` varchar(255),
  `price` decimal(10,2),
  `sale_price` decimal(10,2) DEFAULT NULL,
  `featured_image` varchar(255),
  `description` text DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `modified_date` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `sku`, `title`, `price`, `sale_price`, `featured_image`, `description`, `created_date`, `modified_date`) VALUES
(1, 'PROD0012', 'Smartphone X1', 999.82, 899.99, '../img/uploads/67009475c6e0b_z5383701553813_339fe1046e1fe813e65ec808403f0239.jpg', NULL, '2024-10-04 15:15:22', '2024-10-05 08:20:53'),
(2, 'PROD002', 'Laptop Pro', 1499.99, 1399.99, 'laptop_pro.jpg', 'High-performance laptop for professionals', '2024-10-04 15:15:22', NULL),
(3, 'PROD003', 'Wireless Earbuds', 149.99, 129.99, 'wireless_earbuds.jpg', 'True wireless earbuds with noise cancellation', '2024-10-04 15:15:22', NULL),
(4, 'PROD004', '4K Smart TV', 799.99, 749.99, '4k_smart_tv.jpg', NULL, '2024-10-04 15:15:22', '2024-10-04 11:40:26'),
(5, 'PROD0052', 'Fitness Tracker 2', 72.99, 69.99, '../uploads/66ffb4f16cd9a_con-voi-2.jpg', NULL, '2024-10-04 15:15:22', '2024-10-04 11:52:09'),
(6, 'PROD006', 'Gaming Console', 499.99, 449.99, 'gaming_console.jpg', 'Next-gen gaming console with 4K graphics', '2024-10-04 15:15:22', NULL),
(7, 'PROD007', 'Bluetooth Speaker', 129.99, 99.99, 'bluetooth_speaker.jpg', 'Portable waterproof Bluetooth speaker', '2024-10-04 15:15:22', NULL),
(8, 'PROD008', 'Digital Camera', 699.99, 649.99, 'digital_camera.jpg', 'Mirrorless digital camera with 4K video', '2024-10-04 15:15:22', NULL),
(9, 'PROD009', 'Smart Watch', 299.99, 279.99, 'smart_watch.jpg', 'Fitness-focused smartwatch with GPS', '2024-10-04 15:15:22', NULL),
(10, 'PROD010', 'Tablet', 399.99, 349.99, 'tablet.jpg', '10-inch tablet with high-resolution display', '2024-10-04 15:15:22', NULL),
(11, 'PROD011', 'Wireless Mouse', 49.99, 39.99, 'wireless_mouse.jpg', 'Ergonomic wireless mouse with long battery life', '2024-10-04 15:15:22', NULL),
(12, 'PROD012', 'External SSD', 159.99, 139.99, 'external_ssd.jpg', '1TB external SSD with USB-C connection', '2024-10-04 15:15:22', NULL),
(13, 'PROD013', 'Smart Thermostat', 199.99, 179.99, 'smart_thermostat.jpg', 'Wi-Fi enabled smart thermostat for energy savings', '2024-10-04 15:15:22', NULL),
(14, 'PROD014', 'Wireless Keyboard', 79.99, 69.99, 'wireless_keyboard.jpg', 'Slim wireless keyboard with backlit keys', '2024-10-04 15:15:22', NULL),
(15, 'PROD015', 'Portable Charger', 39.99, 29.99, 'portable_charger.jpg', '10000mAh portable charger with fast charging', '2024-10-04 15:15:22', NULL),
(16, 'PROD016', 'Noise-Cancelling Headphones', 299.99, 269.99, 'noise_cancelling_headphones.jpg', 'Over-ear headphones with active noise cancellation', '2024-10-04 15:15:22', NULL),
(17, 'PROD017', 'Smart Doorbell', 179.99, 159.99, 'smart_doorbell.jpg', 'Wi-Fi video doorbell with two-way audio', '2024-10-04 15:15:22', NULL),
(18, 'PROD018', 'Wireless Router', 129.99, 109.99, 'wireless_router.jpg', 'Dual-band Wi-Fi 6 router for fast home networking', '2024-10-04 15:15:22', NULL),
(19, 'PROD019', 'Portable Projector', 399.99, 349.99, 'portable_projector.jpg', 'Mini LED projector with built-in battery', '2024-10-04 15:15:22', NULL),
(20, 'PROD020', 'Electric Toothbrush', 89.99, 79.99, 'electric_toothbrush.jpg', 'Smart electric toothbrush with pressure sensor', '2024-10-04 15:15:22', NULL),
(21, 'PROD021', 'Dash Cam', 149.99, 129.99, 'dash_cam.jpg', '4K dash cam with GPS and Wi-Fi', '2024-10-04 15:15:22', NULL),
(22, 'PROD022', 'Smart Light Bulbs', 59.99, 49.99, 'smart_light_bulbs.jpg', 'Set of 4 color-changing smart LED bulbs', '2024-10-04 15:15:22', NULL),
(23, 'PROD023', 'Wireless Earphones', 99.99, 89.99, 'wireless_earphones.jpg', 'Sports wireless earphones with ear hooks', '2024-10-04 15:15:22', NULL),
(24, 'PROD024', 'Robot Vacuum', 299.99, 249.99, 'robot_vacuum.jpg', 'Smart robot vacuum with mapping technology', '2024-10-04 15:15:22', NULL),
(25, 'PROD025', 'Portable Monitor', 199.99, 179.99, 'portable_monitor.jpg', '15.6-inch USB-C portable monitor', '2024-10-04 15:15:22', NULL),
(26, 'PROD026', 'Smart Scale', 69.99, 59.99, 'smart_scale.jpg', 'Wi-Fi connected smart scale with body composition analysis', '2024-10-04 15:15:22', NULL),
(27, 'PROD027', 'Wireless Charging Pad', 39.99, 29.99, 'wireless_charging_pad.jpg', 'Fast wireless charging pad for smartphones', '2024-10-04 15:15:22', NULL),
(28, 'PROD028', 'Action Camera', 249.99, 219.99, 'action_camera.jpg', '4K action camera with image stabilization', '2024-10-04 15:15:22', NULL),
(29, 'PROD029', 'Smart Plug', 24.99, 19.99, 'smart_plug.jpg', 'Wi-Fi smart plug compatible with voice assistants', '2024-10-04 15:15:22', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_categories`
--

CREATE TABLE `product_categories` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_categories`
--

INSERT INTO `product_categories` (`product_id`, `category_id`) VALUES
(1, 1),
(1, 4),
(1, 10),
(2, 2),
(3, 3),
(4, 4),
(5, 4),
(6, 6),
(7, 3),
(8, 7),
(9, 5),
(10, 2),
(11, 2),
(12, 2),
(13, 8),
(14, 2),
(15, 9),
(16, 3),
(17, 8),
(18, 1),
(19, 4),
(20, 10),
(21, 1),
(22, 8),
(23, 3),
(24, 8),
(25, 2),
(26, 10),
(27, 9),
(28, 7),
(29, 8);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_gallery`
--

CREATE TABLE `product_gallery` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `gallery_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_gallery`
--

INSERT INTO `product_gallery` (`id`, `product_id`, `gallery_image`) VALUES
(3, 2, 'laptop_pro_open.jpg'),
(4, 2, 'laptop_pro_closed.jpg'),
(5, 3, 'wireless_earbuds_case.jpg'),
(6, 3, 'wireless_earbuds_in_ear.jpg'),
(11, 6, 'gaming_console_front.jpg'),
(12, 6, 'gaming_console_side.jpg'),
(13, 7, 'bluetooth_speaker_black.jpg'),
(14, 7, 'bluetooth_speaker_red.jpg'),
(15, 8, 'digital_camera_front.jpg'),
(16, 8, 'digital_camera_back.jpg'),
(17, 9, 'smart_watch_black.jpg'),
(18, 9, 'smart_watch_white.jpg'),
(19, 10, 'tablet_front.jpg'),
(20, 10, 'tablet_back.jpg'),
(33, 1, '../img/uploads/67009475c72c6_z5383699719077_c281add7e71a7ee6218517b516708dcd.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_tags`
--

CREATE TABLE `product_tags` (
  `product_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_tags`
--

INSERT INTO `product_tags` (`product_id`, `tag_id`) VALUES
(1, 1),
(1, 4),
(1, 6),
(2, 2),
(2, 4),
(3, 3),
(3, 5),
(4, 2),
(4, 7),
(5, 4),
(5, 8),
(6, 1),
(6, 6),
(7, 3),
(7, 9),
(8, 4),
(8, 7),
(9, 2),
(9, 8),
(10, 1),
(10, 9),
(11, 5),
(11, 6),
(12, 2),
(12, 10),
(13, 8),
(13, 10),
(14, 5),
(14, 6),
(15, 3),
(15, 9),
(16, 4),
(16, 6),
(17, 1),
(17, 8),
(18, 2),
(18, 10),
(19, 3),
(19, 9),
(20, 8),
(20, 10),
(21, 1),
(21, 7),
(22, 3),
(22, 8),
(23, 5),
(23, 6),
(24, 2),
(24, 8),
(25, 9),
(25, 10),
(26, 8),
(26, 10),
(27, 5),
(27, 6),
(28, 1),
(28, 7),
(29, 3),
(29, 8);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tags`
--

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `tag_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tags`
--

INSERT INTO `tags` (`id`, `tag_name`) VALUES
(7, '4K'),
(2, 'Best Seller'),
(5, 'Budget-friendly'),
(10, 'High Performance'),
(1, 'New Arrival'),
(9, 'Portable'),
(4, 'Premium'),
(3, 'Sale'),
(8, 'Smart Device'),
(6, 'Wireless');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`);

--
-- Chỉ mục cho bảng `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`product_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `product_gallery`
--
ALTER TABLE `product_gallery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `product_tags`
--
ALTER TABLE `product_tags`
  ADD PRIMARY KEY (`product_id`,`tag_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Chỉ mục cho bảng `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tag_name` (`tag_name`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT cho bảng `product_gallery`
--
ALTER TABLE `product_gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT cho bảng `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `product_categories_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `product_gallery`
--
ALTER TABLE `product_gallery`
  ADD CONSTRAINT `product_gallery_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `product_tags`
--
ALTER TABLE `product_tags`
  ADD CONSTRAINT `product_tags_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
