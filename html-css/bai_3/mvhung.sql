-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 30, 2024 at 04:23 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mvhung`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category_name`) VALUES
(5, 'Accessories'),
(3, 'Audio'),
(9, 'Cameras'),
(8, 'Computers'),
(7, 'Gaming'),
(2, 'Laptops'),
(12, 'Monitors'),
(11, 'Smart Home'),
(1, 'Smartphones'),
(10, 'Tablets'),
(4, 'TVs'),
(6, 'Wearables');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `sku` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `featured_image` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_date` datetime DEFAULT current_timestamp(),
  `modified_date` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `sku`, `title`, `price`, `sale_price`, `featured_image`, `description`, `created_date`, `modified_date`) VALUES
(1, 'IPHONE13PRO', 'iPhone 13 Pro', 999.00, 949.00, 'iphone13pro.jpg', 'Apple iPhone 13 Pro with A15 Bionic chip, Pro camera system, and Super Retina XDR display with ProMotion.', '2023-06-01 10:00:00', '2023-06-01 10:00:00'),
(2, 'SAMSUNGS21', 'Samsung Galaxy S21', 799.99, 749.99, 'samsungs21.jpg', 'Samsung Galaxy S21 5G with dynamic AMOLED display, pro-grade camera, and all-day intelligent battery.', '2023-06-01 11:00:00', '2023-06-01 11:00:00'),
(3, 'SONYWH1000XM4', 'Sony WH-1000XM4', 349.99, 299.99, 'sonywh1000xm4.jpg', 'Sony WH-1000XM4 Wireless Noise-Canceling Headphones with exceptional sound quality and long battery life.', '2023-06-01 12:00:00', '2023-06-01 12:00:00'),
(4, 'DELLXPS15', 'Dell XPS 15', 1799.99, 1699.99, 'dellxps15.jpg', 'Dell XPS 15 laptop with 11th Gen Intel Core processors, NVIDIA GeForce graphics, and InfinityEdge display.', '2023-06-01 13:00:00', '2023-06-01 13:00:00'),
(5, 'LGCX55', 'LG CX 55\" OLED TV', 1499.99, 1399.99, 'lgcx55.jpg', 'LG CX 55-inch 4K Smart OLED TV with AI ThinQ, NVIDIA G-SYNC, and Dolby Vision IQ & Dolby Atmos.', '2023-06-01 14:00:00', '2023-06-01 14:00:00'),
(6, 'APPLEWATCHS6', 'Apple Watch Series 6', 399.00, 349.00, 'applewatchs6.jpg', 'Apple Watch Series 6 with Always-On Retina display, Blood Oxygen app, and ECG app.', '2023-06-02 10:00:00', '2023-06-02 10:00:00'),
(7, 'SONYPS5', 'PlayStation 5', 499.99, NULL, 'ps5.jpg', 'Sony PlayStation 5 gaming console with ultra-high speed SSD, ray tracing, and 4K-TV gaming.', '2023-06-02 11:00:00', '2023-06-02 11:00:00'),
(8, 'BOSEQC35', 'Bose QuietComfort 35 II', 299.00, 249.00, 'boseqc35.jpg', 'Bose QuietComfort 35 II Wireless Bluetooth Headphones with world-class noise cancellation.', '2023-06-02 12:00:00', '2023-06-02 12:00:00'),
(9, 'MACBOOKAIR', 'MacBook Air M1', 999.00, 899.00, 'macbookair.jpg', 'Apple MacBook Air with M1 chip, 13-inch Retina display, and up to 18 hours of battery life.', '2023-06-02 13:00:00', '2023-06-02 13:00:00'),
(10, 'SAMSUNGQ80T', 'Samsung Q80T QLED TV', 1299.99, 1199.99, 'samsungq80t.jpg', 'Samsung Q80T 55\" QLED 4K UHD Smart TV with Quantum HDR 12x and Alexa built-in.', '2023-06-02 14:00:00', '2023-06-02 14:00:00'),
(11, 'IPADPRO2021', 'iPad Pro 2021', 799.00, 749.00, 'ipadpro2021.jpg', 'Apple iPad Pro 2021 with M1 chip, Liquid Retina XDR display, and 5G capability.', '2023-06-03 10:00:00', '2023-06-03 10:00:00'),
(12, 'XBOXSERIESX', 'Xbox Series X', 499.99, NULL, 'xboxseriesx.jpg', 'Microsoft Xbox Series X gaming console with 4K gaming at up to 120 FPS, 1TB custom SSD, and ray tracing.', '2023-06-03 11:00:00', '2023-06-03 11:00:00'),
(13, 'SONYAX43', 'Sony A8H 43\" OLED TV', 1299.99, 1199.99, 'sonyax43.jpg', 'Sony A8H 43\" OLED 4K Ultra HD Smart TV with HDR and Alexa Compatibility.', '2023-06-03 12:00:00', '2023-06-03 12:00:00'),
(14, 'ASUSROGZEPHYRUS', 'ASUS ROG Zephyrus G14', 1449.99, 1349.99, 'asusrogzephyrus.jpg', 'ASUS ROG Zephyrus G14 Gaming Laptop with AMD Ryzen 9, NVIDIA GeForce RTX 3060, and 1TB SSD.', '2023-06-03 13:00:00', '2023-06-03 13:00:00'),
(15, 'GOPROHERO9', 'GoPro HERO9 Black', 399.99, 349.99, 'goprohero9.jpg', 'GoPro HERO9 Black - Waterproof Action Camera with Front LCD and Touch Rear Screens, 5K Ultra HD Video.', '2023-06-03 14:00:00', '2023-06-03 14:00:00'),
(16, 'SAMSUNGGALAXYTABS7', 'Samsung Galaxy Tab S7', 649.99, 599.99, 'galaxytabs7.jpg', 'Samsung Galaxy Tab S7 with 11\" screen, 128GB storage, and S Pen included.', '2023-06-04 10:00:00', '2023-06-04 10:00:00'),
(17, 'FITBITVERSA3', 'Fitbit Versa 3', 229.95, 199.95, 'fitbitversa3.jpg', 'Fitbit Versa 3 Health & Fitness Smartwatch with GPS, 24/7 Heart Rate, Alexa Built-in.', '2023-06-04 11:00:00', '2023-06-04 11:00:00'),
(18, 'CANONEOSR6', 'Canon EOS R6', 2499.00, 2399.00, 'canoneosr6.jpg', 'Canon EOS R6 Full-Frame Mirrorless Camera with 4K Video, Full-Frame CMOS Sensor, DIGIC X Image Processor.', '2023-06-04 12:00:00', '2023-06-04 12:00:00'),
(19, 'NINTENDOSWITCH', 'Nintendo Switch', 299.99, NULL, 'nintendoswitch.jpg', 'Nintendo Switch gaming console with Joy‑Con controllers and HD Rumble.', '2023-06-04 13:00:00', '2023-06-04 13:00:00'),
(20, 'AIRPODSPRO', 'AirPods Pro', 249.00, 219.00, 'airpodspro.jpg', 'Apple AirPods Pro with Active Noise Cancellation, Transparency mode, and Adaptive EQ.', '2023-06-04 14:00:00', '2023-06-04 14:00:00'),
(21, 'SURFACELAPTOP4', 'Microsoft Surface Laptop 4', 999.99, 949.99, 'surfacelaptop4.jpg', 'Microsoft Surface Laptop 4 13.5\" Touch-Screen – Intel Core i5 - 8GB - 512GB SSD.', '2023-06-05 10:00:00', '2023-06-05 10:00:00'),
(22, 'SAMSUNGFRAME', 'Samsung The Frame TV', 1299.99, 1199.99, 'samsungframe.jpg', 'Samsung The Frame QLED 4K UHD HDR Smart TV that transforms into a work of art.', '2023-06-05 11:00:00', '2023-06-05 11:00:00'),
(23, 'OCULUS2', 'Oculus Quest 2', 299.00, NULL, 'oculusquest2.jpg', 'Oculus Quest 2 Advanced All-In-One Virtual Reality Headset.', '2023-06-05 12:00:00', '2023-06-05 12:00:00'),
(24, 'DYSONV11', 'Dyson V11 Torque Drive', 699.99, 599.99, 'dysonv11.jpg', 'Dyson V11 Torque Drive Cordless Vacuum Cleaner with twice the suction of any cord-free vacuum.', '2023-06-05 13:00:00', '2023-06-05 13:00:00'),
(25, 'GARMINFENIX6', 'Garmin Fenix 6 Pro', 649.99, 599.99, 'garminfenix6.jpg', 'Garmin Fenix 6 Pro Multisport GPS Watch with maps, music, grade-adjusted pace guidance and Pulse Ox sensors.', '2023-06-05 14:00:00', '2023-06-05 14:00:00'),
(26, 'LGOLED65C1', 'LG OLED65C1PUB', 2499.99, 2299.99, 'lgoled65c1.jpg', 'LG OLED65C1PUB Alexa Built-in C1 Series 65\" 4K Smart OLED TV.', '2023-06-06 10:00:00', '2023-06-06 10:00:00'),
(27, 'SONOSMOVE', 'Sonos Move', 399.00, 379.00, 'sonosmove.jpg', 'Sonos Move - Battery-powered Smart Speaker, Wi-Fi and Bluetooth with Alexa built-in.', '2023-06-06 11:00:00', '2023-06-06 11:00:00'),
(28, 'RAZERBLADE15', 'Razer Blade 15', 1999.99, 1899.99, 'razerblade15.jpg', 'Razer Blade 15 Base Gaming Laptop 2021: Intel Core i7-10750H 6 Core, NVIDIA GeForce RTX 3060.', '2023-06-06 12:00:00', '2023-06-06 12:00:00'),
(29, 'SAMSUNGGALAXYBUD', 'Samsung Galaxy Buds Pro', 199.99, 169.99, 'galaxybudspro.jpg', 'Samsung Galaxy Buds Pro, Bluetooth Earbuds with Intelligent ANC and Sound by AKG.', '2023-06-06 13:00:00', '2023-06-06 13:00:00'),
(30, 'HPSPECTREX360', 'HP Spectre x360', 1299.99, 1199.99, 'hpspectrex360.jpg', 'HP Spectre x360 2-in-1 15.6\" 4K UHD Touch-Screen Laptop with Intel Core i7.', '2023-06-06 14:00:00', '2023-06-06 14:00:00'),
(31, 'SONYBRAVIA65X90J', 'Sony BRAVIA XR X90J', 1799.99, 1699.99, 'sonybravia65x90j.jpg', 'Sony BRAVIA XR X90J 65 Inch TV: Full Array LED 4K Ultra HD Smart Google TV.', '2023-06-07 10:00:00', '2023-06-07 10:00:00'),
(32, 'BEOPLAYHX', 'Bang & Olufsen Beoplay HX', 499.00, 449.00, 'beoplayhx.jpg', 'Bang & Olufsen Beoplay HX – Comfortable Wireless ANC Over-Ear Headphones.', '2023-06-07 11:00:00', '2023-06-07 11:00:00'),
(33, 'DELLG5SE', 'Dell G5 15 SE', 999.99, 949.99, 'dellg5se.jpg', 'Dell G5 15 SE Gaming Laptop with AMD Ryzen 7 4800H and AMD Radeon RX 5600M.', '2023-06-07 12:00:00', '2023-06-07 12:00:00'),
(34, 'PHILIPSHUE', 'Philips Hue Starter Kit', 199.99, 179.99, 'philipshue.jpg', 'Philips Hue White and Color Ambiance LED Smart Button Starter Kit.', '2023-06-07 13:00:00', '2023-06-07 13:00:00'),
(35, 'SAMSUNGODYSSEY', 'Samsung Odyssey G9', 1479.99, 1399.99, 'samsungodyssey.jpg', 'Samsung Odyssey G9 49-Inch Curved Gaming Monitor with Dual QHD Display.', '2023-06-07 14:00:00', '2023-06-07 14:00:00'),
(36, 'LOGITECHG915', 'Logitech G915 TKL', 229.99, 199.99, 'logitechg915.jpg', 'Logitech G915 TKL Tenkeyless Lightspeed Wireless RGB Mechanical Gaming Keyboard.', '2023-06-08 10:00:00', '2023-06-08 10:00:00'),
(37, 'RINGDOORBELL', 'Ring Video Doorbell Pro', 249.99, 219.99, 'ringdoorbell.jpg', 'Ring Video Doorbell Pro with HD Video, Motion Activated Alerts, Easy Installation.', '2023-06-08 11:00:00', '2023-06-08 11:00:00'),
(38, 'BOSEQC45', 'Bose QuietComfort 45', 329.00, 299.00, 'boseqc45.jpg', 'Bose QuietComfort 45 Bluetooth Wireless Noise Cancelling Headphones.', '2023-06-08 12:00:00', '2023-06-08 12:00:00'),
(39, 'ASUSZENBOOK', 'ASUS ZenBook 14', 999.99, 949.99, 'asuszenbook14.jpg', 'ASUS ZenBook 14 Ultra-Slim Laptop 14\" FHD NanoEdge Bezel Display.', '2023-06-08 13:00:00', '2023-06-08 13:00:00'),
(40, 'SAMSUNGQ90T', 'Samsung Q90T QLED TV', 2199.99, 1999.99, 'samsungq90t.jpg', 'Samsung Q90T QLED 4K UHD HDR Smart TV with Alexa Built-in.', '2023-06-08 14:00:00', '2023-06-08 14:00:00'),
(41, 'JABRAPRO75T', 'Jabra Elite 75t', 179.99, 149.99, 'jabrapro75t.jpg', 'Jabra Elite 75t Earbuds – True Wireless Earbuds with Charging Case.', '2023-06-09 10:00:00', '2023-06-09 10:00:00'),
(42, 'LENOVOYOGA9I', 'Lenovo Yoga 9i', 1399.99, 1299.99, 'lenovoyoga9i.jpg', 'Lenovo Yoga 9i 14 2-in-1 14\" Touch-Screen Laptop - Intel Core i7.', '2023-06-09 11:00:00', '2023-06-09 11:00:00'),
(43, 'SONYXM4', 'Sony WF-1000XM4', 279.99, 249.99, 'sonywf1000xm4.jpg', 'Sony WF-1000XM4 Industry Leading Noise Canceling Truly Wireless Earbud Headphones.', '2023-06-09 12:00:00', '2023-06-09 12:00:00'),
(44, 'HISENSEU8G', 'Hisense U8G ULED TV', 999.99, 899.99, 'hisenseu8g.jpg', 'Hisense U8G Quantum Series 55-Inch Android 4K ULED Smart TV.', '2023-06-09 13:00:00', '2023-06-09 13:00:00'),
(45, 'CORSAIRK100', 'Corsair K100 RGB', 229.99, 199.99, 'corsairk100.jpg', 'Corsair K100 RGB Mechanical Gaming Keyboard with CORSAIR OPX Optical-Mechanical Keyswitches.', '2023-06-09 14:00:00', '2023-06-09 14:00:00'),
(46, 'SAMSUNGGALAXYA52', 'Samsung Galaxy A52', 499.99, 449.99, 'galaxya52.jpg', 'Samsung Galaxy A52 5G Android Cell Phone, Factory Unlocked Smartphone.', '2023-06-10 10:00:00', '2023-06-10 10:00:00'),
(47, 'LGULTRAFINEMONITOR', 'LG UltraFine 5K Display', 1299.99, 1199.99, 'lgultrafine5k.jpg', 'LG UltraFine 5K Display 27-inch IPS Monitor with macOS Compatibility.', '2023-06-10 11:00:00', '2023-06-10 11:00:00'),
(48, 'ANKERQ30', 'Anker Soundcore Life Q30', 79.99, 69.99, 'ankerq30.jpg', 'Anker Soundcore Life Q30 Hybrid Active Noise Cancelling Headphones.', '2023-06-10 12:00:00', '2023-06-10 12:00:00'),
(49, 'MSIGL65', 'MSI GL65 Leopard', 1299.99, 1199.99, 'msigl65.jpg', 'MSI GL65 Leopard 10SFK-062 15.6\" FHD 144Hz 3ms Thin Bezel Gaming Laptop.', '2023-06-10 13:00:00', '2023-06-10 13:00:00'),
(50, 'TCLS6', 'TCL 6-Series TV', 799.99, 749.99, 'tcls6.jpg', 'TCL 6-Series 55\" 4K UHD QLED Dolby Vision HDR Roku Smart TV.', '2023-06-10 14:00:00', '2023-06-10 14:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`product_id`, `category_id`) VALUES
(1, 1),
(1, 5),
(2, 1),
(2, 5),
(3, 3),
(3, 5),
(4, 2),
(4, 5),
(5, 4),
(6, 5),
(6, 6),
(7, 7),
(8, 3),
(8, 5),
(9, 2),
(9, 8),
(10, 4),
(11, 5),
(11, 10),
(12, 7),
(13, 4),
(14, 2),
(14, 7),
(15, 5),
(15, 9),
(16, 5),
(16, 10),
(17, 5),
(17, 6),
(18, 5),
(18, 9),
(19, 5),
(19, 7),
(20, 3),
(20, 5),
(21, 2),
(21, 8),
(22, 4),
(22, 5),
(23, 5),
(23, 7),
(24, 5),
(24, 11),
(25, 5),
(25, 6),
(26, 4),
(26, 5),
(27, 3),
(27, 11),
(28, 2),
(28, 7),
(29, 3),
(29, 5),
(30, 2),
(30, 8),
(31, 4),
(31, 5),
(32, 3),
(32, 5),
(33, 2),
(33, 7),
(34, 5),
(34, 11),
(35, 7),
(35, 12),
(36, 5),
(36, 7),
(37, 5),
(37, 11),
(38, 3),
(38, 5),
(39, 2),
(39, 8),
(40, 4),
(40, 5),
(41, 3),
(41, 5),
(42, 2),
(42, 8),
(43, 3),
(43, 5),
(44, 4),
(44, 5),
(45, 5),
(45, 7),
(46, 1),
(46, 5),
(47, 8),
(47, 12),
(48, 3),
(48, 5),
(49, 2),
(49, 7),
(50, 4),
(50, 5);

-- --------------------------------------------------------

--
-- Table structure for table `product_gallery`
--

CREATE TABLE `product_gallery` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `gallery_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_gallery`
--

INSERT INTO `product_gallery` (`id`, `product_id`, `gallery_image`) VALUES
(1, 1, 'iphone13pro_back.jpg'),
(2, 1, 'iphone13pro_side.jpg'),
(3, 2, 'samsungs21_front.jpg'),
(4, 2, 'samsungs21_back.jpg'),
(5, 3, 'sonywh1000xm4_case.jpg'),
(6, 3, 'sonywh1000xm4_wearing.jpg'),
(7, 4, 'dellxps15_open.jpg'),
(8, 4, 'dellxps15_side.jpg'),
(9, 5, 'lgcx55_front.jpg'),
(10, 5, 'lgcx55_side.jpg'),
(11, 6, 'applewatchs6_front.jpg'),
(12, 6, 'applewatchs6_side.jpg'),
(13, 7, 'ps5_standing.jpg'),
(14, 7, 'ps5_controller.jpg'),
(15, 8, 'boseqc35_front.jpg'),
(16, 8, 'boseqc35_folded.jpg'),
(17, 9, 'macbookair_open.jpg'),
(18, 9, 'macbookair_closed.jpg'),
(19, 10, 'samsungq80t_front.jpg'),
(20, 10, 'samsungq80t_angle.jpg'),
(21, 11, 'ipadpro2021_front.jpg'),
(22, 11, 'ipadpro2021_back.jpg'),
(23, 12, 'xboxseriesx_front.jpg'),
(24, 12, 'xboxseriesx_side.jpg'),
(25, 13, 'sonyax43_front.jpg'),
(26, 13, 'sonyax43_angle.jpg'),
(27, 14, 'asusrogzephyrus_open.jpg'),
(28, 14, 'asusrogzephyrus_closed.jpg'),
(29, 15, 'goprohero9_front.jpg'),
(30, 15, 'goprohero9_side.jpg'),
(31, 16, 'galaxytabs7_front.jpg'),
(32, 16, 'galaxytabs7_back.jpg'),
(33, 17, 'fitbitversa3_front.jpg'),
(34, 17, 'fitbitversa3_back.jpg'),
(35, 18, 'canoneosr6_front.jpg'),
(36, 18, 'canoneosr6_back.jpg'),
(37, 19, 'nintendoswitch_front.jpg'),
(38, 19, 'nintendoswitch_back.jpg'),
(39, 20, 'airpodspro_front.jpg'),
(40, 20, 'airpodspro_back.jpg'),
(41, 21, 'surfacelaptop4_front.jpg'),
(42, 21, 'surfacelaptop4_back.jpg'),
(43, 22, 'samsungframe_front.jpg'),
(44, 22, 'samsungframe_back.jpg'),
(45, 23, 'oculusquest2_front.jpg'),
(46, 23, 'oculusquest2_back.jpg'),
(47, 24, 'dysonv11_front.jpg'),
(48, 24, 'dysonv11_back.jpg'),
(49, 25, 'garminfenix6_front.jpg'),
(50, 26, 'lgoled65c1_front.jpg'),
(51, 26, 'lgoled65c1_back.jpg'),
(52, 27, 'sonosmove_front.jpg'),
(53, 27, 'sonosmove_back.jpg'),
(54, 28, 'razerblade15_front.jpg'),
(55, 28, 'razerblade15_back.jpg'),
(56, 29, 'galaxybudspro_front.jpg'),
(57, 29, 'galaxybudspro_back.jpg'),
(58, 30, 'hpspectrex360_front.jpg'),
(59, 30, 'hpspectrex360_back.jpg'),
(60, 31, 'sonybravia65x90j_front.jpg'),
(61, 31, 'sonybravia65x90j_back.jpg'),
(62, 32, 'beoplayhx_front.jpg'),
(63, 32, 'beoplayhx_back.jpg'),
(64, 33, 'dellg5se_front.jpg'),
(65, 33, 'dellg5se_back.jpg'),
(66, 34, 'philipshue_front.jpg'),
(67, 34, 'philipshue_back.jpg'),
(68, 35, 'samsungodyssey_front.jpg'),
(69, 35, 'samsungodyssey_back.jpg'),
(70, 36, 'logitechg915_front.jpg'),
(71, 36, 'logitechg915_back.jpg'),
(72, 37, 'ringdoorbell_front.jpg'),
(73, 37, 'ringdoorbell_back.jpg'),
(74, 38, 'boseqc45_front.jpg'),
(75, 38, 'boseqc45_back.jpg'),
(76, 39, 'asuszenbook_front.jpg'),
(77, 39, 'asuszenbook_back.jpg'),
(78, 40, 'samsungq90t_front.jpg'),
(79, 40, 'samsungq90t_back.jpg'),
(80, 41, 'jabrapro75t_front.jpg'),
(81, 41, 'jabrapro75t_back.jpg'),
(82, 42, 'lenovoyoga9i_front.jpg'),
(83, 42, 'lenovoyoga9i_back.jpg'),
(84, 43, 'sonywf1000xm4_front.jpg'),
(85, 43, 'sonywf1000xm4_back.jpg'),
(86, 44, 'hisenseu8g_front.jpg'),
(87, 44, 'hisenseu8g_back.jpg'),
(88, 45, 'corsairk100_front.jpg'),
(89, 45, 'corsairk100_back.jpg'),
(90, 46, 'galaxya52_front.jpg'),
(91, 46, 'galaxya52_back.jpg'),
(92, 47, 'lgultrafine5k_front.jpg'),
(93, 47, 'lgultrafine5k_back.jpg'),
(94, 48, 'ankerq30_front.jpg'),
(95, 48, 'ankerq30_back.jpg'),
(96, 49, 'msigl65_front.jpg'),
(97, 49, 'msigl65_back.jpg'),
(98, 50, 'tcls6_front.jpg'),
(99, 50, 'tcls6_back.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `product_tags`
--

CREATE TABLE `product_tags` (
  `product_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_tags`
--

INSERT INTO `product_tags` (`product_id`, `tag_id`) VALUES
(1, 2),
(1, 8),
(1, 10),
(2, 1),
(2, 5),
(2, 9),
(3, 3),
(3, 6),
(4, 4),
(4, 10),
(5, 2),
(5, 5),
(5, 7),
(6, 6),
(6, 8),
(7, 4),
(7, 5),
(8, 3),
(8, 6),
(9, 8),
(9, 10),
(10, 2),
(10, 5),
(10, 7),
(11, 8),
(11, 10),
(11, 12),
(12, 4),
(12, 5),
(13, 2),
(13, 5),
(13, 15),
(14, 4),
(14, 10),
(14, 12),
(15, 6),
(15, 12),
(15, 13),
(16, 1),
(16, 5),
(17, 1),
(17, 5),
(18, 1),
(18, 5),
(19, 1),
(19, 5),
(20, 1),
(20, 5),
(21, 1),
(21, 5),
(22, 1),
(22, 5),
(23, 1),
(23, 5),
(24, 1),
(24, 5),
(25, 1),
(25, 5),
(26, 1),
(26, 5),
(27, 1),
(27, 5),
(28, 1),
(28, 5),
(29, 1),
(29, 5),
(30, 1),
(30, 5),
(31, 1),
(31, 5),
(32, 1),
(32, 5),
(33, 1),
(33, 5),
(34, 1),
(34, 5),
(35, 1),
(35, 5),
(36, 1),
(36, 5),
(37, 1),
(37, 5),
(38, 1),
(38, 5),
(39, 1),
(39, 5),
(40, 1),
(40, 5),
(41, 1),
(41, 5),
(42, 1),
(42, 5),
(43, 1),
(43, 5),
(44, 1),
(44, 5),
(45, 1),
(45, 5),
(46, 1),
(46, 5),
(47, 1),
(47, 5),
(48, 1),
(48, 5),
(49, 1),
(49, 5),
(50, 1),
(50, 5);

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `tag_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `tag_name`) VALUES
(5, '4K'),
(1, '5G'),
(9, 'Android'),
(8, 'Apple'),
(11, 'Budget-Friendly'),
(14, 'Fitness'),
(4, 'Gaming'),
(15, 'HDR'),
(10, 'High-End'),
(3, 'Noise Cancelling'),
(2, 'OLED'),
(12, 'Portable'),
(13, 'Professional'),
(7, 'Smart Home'),
(6, 'Wireless');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`product_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_gallery`
--
ALTER TABLE `product_gallery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `product_tags`
--
ALTER TABLE `product_tags`
  ADD PRIMARY KEY (`product_id`,`tag_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tag_name` (`tag_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `product_gallery`
--
ALTER TABLE `product_gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `product_categories_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_gallery`
--
ALTER TABLE `product_gallery`
  ADD CONSTRAINT `product_gallery_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_tags`
--
ALTER TABLE `product_tags`
  ADD CONSTRAINT `product_tags_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
