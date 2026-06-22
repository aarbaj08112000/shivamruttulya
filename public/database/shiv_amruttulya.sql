-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 22, 2026 at 11:35 AM
-- Server version: 11.8.6-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u875583157_shivamruttulya`
--

-- --------------------------------------------------------

--
-- Table structure for table `daily_collections`
--

CREATE TABLE `daily_collections` (
  `id` int(11) NOT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `collection_date` date DEFAULT NULL,
  `cash_amount` decimal(10,2) DEFAULT NULL,
  `online_amount` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `added_by` int(11) DEFAULT 1,
  `added_date` datetime DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_collections`
--

INSERT INTO `daily_collections` (`id`, `shop_id`, `collection_date`, `cash_amount`, `online_amount`, `total_amount`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 1, '2026-05-01', 3200.00, 1800.00, 5000.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(2, 2, '2026-05-01', 4100.00, 1900.00, 6000.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(3, 1, '2026-05-05', 3500.00, 1700.00, 5200.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(4, 2, '2026-05-05', 4300.00, 2100.00, 6400.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(5, 1, '2026-05-10', 3800.00, 2200.00, 6000.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(6, 2, '2026-05-10', 4500.00, 2500.00, 7000.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(7, 1, '2026-05-15', 4200.00, 2300.00, 6500.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(8, 2, '2026-05-15', 4800.00, 2700.00, 7500.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(9, 1, '2026-05-20', 4000.00, 2500.00, 6500.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(10, 2, '2026-05-20', 5000.00, 2800.00, 7800.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(11, 1, '2026-06-01', 4300.00, 2200.00, 6500.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(12, 2, '2026-06-01', 5200.00, 2800.00, 8000.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(13, 1, '2026-06-05', 4500.00, 2500.00, 7000.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(14, 2, '2026-06-05', 5500.00, 3000.00, 8500.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(15, 1, '2026-06-10', 4800.00, 2700.00, 7500.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(16, 2, '2026-06-10', 5800.00, 3200.00, 9000.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(17, 1, '2026-06-15', 5000.00, 3000.00, 8000.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(18, 2, '2026-06-15', 6200.00, 3300.00, 9500.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(19, 1, '2026-06-20', 5300.00, 3200.00, 8500.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(20, 2, '2026-06-20', 6500.00, 3500.00, 10000.00, 'active', 1, '2026-06-22 09:45:06', NULL, NULL, '0'),
(21, 3, '2026-06-22', 1000.00, 4000.00, 5000.00, 'active', 4, '2026-06-22 15:56:51', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(11) NOT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `expense_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `added_by` int(11) DEFAULT 1,
  `added_date` datetime DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `shop_id`, `category_id`, `amount`, `expense_date`, `description`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 1, 1, 5000.00, '2026-05-01', 'Monthly shop rent', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(2, 1, 2, 1200.00, '2026-05-05', 'Electricity bill payment', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(3, 1, 3, 8000.00, '2026-05-07', 'Staff salary', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(4, 1, 4, 1800.00, '2026-05-10', 'Milk purchase', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(5, 1, 5, 2500.00, '2026-05-12', 'Tea powder stock purchase', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(6, 1, 7, 1100.00, '2026-05-15', 'Gas cylinder refill', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(7, 1, 8, 300.00, '2026-05-18', 'Water can charges', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(8, 2, 1, 5000.00, '2026-05-01', 'Monthly shop rent', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(9, 2, 3, 8000.00, '2026-05-07', 'Staff salary', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(10, 2, 10, 1200.00, '2026-05-20', 'Counter repair work', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(11, 1, 1, 5000.00, '2026-06-01', 'Monthly shop rent', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(12, 1, 2, 1200.00, '2026-06-05', 'Electricity bill payment', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(13, 1, 6, 1200.00, '2026-06-08', 'Sugar purchase', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(14, 1, 9, 500.00, '2026-06-10', 'Cleaning material purchase', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(15, 1, 11, 700.00, '2026-06-12', 'Internet bill', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(16, 2, 1, 5000.00, '2026-06-01', 'Monthly shop rent', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(17, 2, 2, 1200.00, '2026-06-05', 'Electricity bill payment', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(18, 2, 3, 8000.00, '2026-06-07', 'Staff salary', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(19, 2, 13, 800.00, '2026-06-15', 'Packaging materials purchase', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(20, 2, 15, 1000.00, '2026-06-20', 'Miscellaneous shop expenses', 'active', 1, '2026-06-22 09:43:27', NULL, NULL, '0'),
(21, 3, 6, 1000.00, '2026-06-23', 'ok', 'active', 4, '2026-06-22 15:56:01', 4, '2026-06-22 15:57:19', '0');

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(100) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `added_by` int(11) DEFAULT 1,
  `added_date` datetime DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `category_name`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 'Shop Rent', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(2, 'Electricity Bill', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(3, 'Staff Salary', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(4, 'Milk Purchase', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(5, 'Tea Powder Purchase', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(6, 'Sugar Purchase', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(7, 'Gas Cylinder', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(8, 'Water Charges', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(9, 'Cleaning Supplies', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(10, 'Maintenance & Repairs', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(11, 'Internet & WiFi', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(12, 'Marketing & Promotion', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(13, 'Packaging Materials', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(14, 'Transportation Expense', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0'),
(15, 'Miscellaneous Expense', 'active', 1, '2026-06-22 09:42:05', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `franchises`
--

CREATE TABLE `franchises` (
  `id` int(11) NOT NULL,
  `franchise_code` varchar(20) DEFAULT NULL,
  `franchise_name` varchar(150) DEFAULT NULL,
  `owner_name` varchar(100) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  `address` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `added_by` int(11) DEFAULT 1,
  `added_date` datetime DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `grocery_categories`
--

CREATE TABLE `grocery_categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(100) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `added_by` int(11) DEFAULT 1,
  `added_date` datetime DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grocery_categories`
--

INSERT INTO `grocery_categories` (`id`, `category_name`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 'Tea Ingredients', 'active', 1, '2026-06-22 09:37:11', NULL, NULL, '0'),
(2, 'Milk & Dairy', 'active', 1, '2026-06-22 09:37:11', NULL, NULL, '0'),
(3, 'Sugar & Sweeteners', 'active', 1, '2026-06-22 09:37:11', NULL, NULL, '0'),
(4, 'Tea Masala & Spices', 'active', 1, '2026-06-22 09:37:11', NULL, NULL, '0'),
(5, 'Coffee Materials', 'active', 1, '2026-06-22 09:37:11', NULL, NULL, '0'),
(6, 'Snacks & Biscuits', 'active', 1, '2026-06-22 09:37:11', NULL, NULL, '0'),
(7, 'Disposable Items', 'active', 1, '2026-06-22 09:37:11', NULL, NULL, '0'),
(8, 'Cleaning & Hygiene Supplies', 'active', 1, '2026-06-22 09:37:11', NULL, NULL, '0'),
(9, 'Kitchen Essentials', 'active', 1, '2026-06-22 09:37:11', NULL, NULL, '0'),
(10, 'Packaging Materials', 'active', 1, '2026-06-22 09:37:11', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `grocery_items`
--

CREATE TABLE `grocery_items` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `added_by` int(11) DEFAULT 1,
  `added_date` datetime DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grocery_items`
--

INSERT INTO `grocery_items` (`id`, `category_id`, `item_name`, `unit`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 1, 'CTC Tea Powder', 'Kg', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(2, 1, 'Green Tea Leaves', 'Kg', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(3, 2, 'Milk', 'Ltr', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(4, 2, 'Curd', 'Kg', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(5, 3, 'Sugar', 'Kg', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(6, 3, 'Jaggery Powder', 'Kg', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(7, 4, 'Tea Masala', 'Kg', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(8, 4, 'Cardamom', 'Kg', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(9, 4, 'Ginger Powder', 'Kg', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(10, 5, 'Coffee Powder', 'Kg', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(11, 5, 'Instant Coffee', 'Kg', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(12, 6, 'Parle-G Biscuit', 'Packet', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(13, 6, 'Good Day Biscuit', 'Packet', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(14, 6, 'Khari', 'Packet', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(15, 7, 'Paper Cup', 'Nos', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(16, 7, 'Plastic Spoon', 'Nos', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(17, 8, 'Dish Wash Liquid', 'Bottle', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(18, 8, 'Floor Cleaner', 'Bottle', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(19, 9, 'Gas Cylinder', 'Nos', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(20, 9, 'Match Box', 'Box', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(21, 10, 'Carry Bag', 'Nos', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0'),
(22, 10, 'Food Container', 'Nos', 'active', 1, '2026-06-22 09:38:26', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `grocery_purchases`
--

CREATE TABLE `grocery_purchases` (
  `id` int(11) NOT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `grocery_item_id` int(11) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `vendor_name` varchar(255) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `quantity` decimal(10,2) DEFAULT NULL,
  `rate` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `added_by` int(11) DEFAULT 1,
  `added_date` datetime DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grocery_purchases`
--

INSERT INTO `grocery_purchases` (`id`, `shop_id`, `grocery_item_id`, `vendor_id`, `vendor_name`, `purchase_date`, `quantity`, `rate`, `total_amount`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 1, 1, NULL, 'ABC Tea Suppliers', '2026-05-03', 25.00, 420.00, 10500.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(2, 1, 2, NULL, 'Green Leaf Traders', '2026-05-05', 10.00, 550.00, 5500.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(3, 1, 3, NULL, 'Shree Dairy', '2026-05-08', 100.00, 58.00, 5800.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(4, 2, 3, NULL, 'Gokul Dairy', '2026-05-10', 120.00, 60.00, 7200.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(5, 1, 5, NULL, 'Mahalaxmi Sugars', '2026-05-12', 50.00, 45.00, 2250.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(6, 2, 6, NULL, 'Organic Foods', '2026-05-15', 20.00, 65.00, 1300.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(7, 1, 7, NULL, 'Masala King', '2026-05-18', 5.00, 850.00, 4250.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(8, 2, 8, NULL, 'Spice World', '2026-05-20', 3.00, 1800.00, 5400.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(9, 1, 9, NULL, 'Fresh Spices', '2026-05-22', 2.00, 1200.00, 2400.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(10, 2, 10, NULL, 'Coffee Hub', '2026-05-25', 15.00, 380.00, 5700.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(11, 1, 11, NULL, 'Nescafe Distributor', '2026-06-02', 10.00, 450.00, 4500.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(12, 1, 12, NULL, 'Parle Agency', '2026-06-04', 100.00, 8.00, 800.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(13, 2, 13, NULL, 'Britannia Distributor', '2026-06-06', 80.00, 15.00, 1200.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(14, 1, 14, NULL, 'Bakery Fresh', '2026-06-08', 50.00, 20.00, 1000.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(15, 2, 15, NULL, 'Disposable Mart', '2026-06-10', 2000.00, 0.80, 1600.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(16, 1, 16, NULL, 'Hotel Supplies', '2026-06-12', 1000.00, 0.50, 500.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(17, 2, 17, NULL, 'Clean India Traders', '2026-06-15', 12.00, 120.00, 1440.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(18, 1, 18, NULL, 'Hygiene World', '2026-06-18', 10.00, 180.00, 1800.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(19, 1, 19, NULL, 'HP Gas Agency', '2026-06-20', 4.00, 1100.00, 4400.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0'),
(20, 2, 20, NULL, 'General Store', '2026-06-22', 50.00, 5.00, 250.00, 'active', 1, '2026-06-22 09:40:53', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `added_by` int(11) DEFAULT 1,
  `added_date` datetime DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 'Admin', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(2, 'Franchise Owner', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(3, 'Shop Manager', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE `shops` (
  `id` int(11) NOT NULL,
  `shop_code` varchar(20) DEFAULT NULL,
  `shop_name` varchar(150) DEFAULT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `contact_number` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `opening_date` date DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `added_by` int(11) DEFAULT 1,
  `added_date` datetime DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`id`, `shop_code`, `shop_name`, `contact_person`, `contact_number`, `email`, `address`, `opening_date`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 'SA-001', 'Shiv Amruttulya Marunji', 'Manager', '9876543211', NULL, 'Marunji, Pune', '2025-06-01', 'active', 1, '2026-06-22 09:34:57', NULL, NULL, '0'),
(2, 'SA-002', 'Shiv Amruttulya Blue Ridge', 'Manager', '9876543212', NULL, 'Blue Ridge, Pune', '2026-04-01', 'active', 1, '2026-06-22 09:34:57', NULL, NULL, '0'),
(3, 'SA-003', 'Ni-Tea', 'Nitesh', '7558574420', 'niteshproject10@gmail.com', 'zolo green tree', '2026-06-22', 'active', 4, '2026-06-22 10:24:50', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `profile_image` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `added_by` int(11) DEFAULT 1,
  `added_date` datetime DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted',
  `api_token` text DEFAULT NULL,
  `token_issued_at` datetime DEFAULT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `device_type` varchar(50) DEFAULT NULL,
  `otp` varchar(10) DEFAULT NULL,
  `otp_validity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `password`, `mobile`, `profile_image`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`, `api_token`, `token_issued_at`, `device_id`, `device_type`, `otp`, `otp_validity`) VALUES
(1, 1, 'Code Crafter', 'admin@gmail.com', 'Admin@123', '123456789', '690e068bfc5e6ae55ed6ed62a363ca73.jpg', 'active', 1, '2026-06-15 13:16:14', 1, '2026-06-21 10:10:00', '0', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIxIiwiaWF0IjoxNzgyMTIxNTQzLCJleHAiOjE3ODQ3MTM1NDN9.zHS4SGrBMdNr_EUzzhE3t8GdkYnbpthMNwGCqsoM5Ts', '2026-06-22 15:15:43', 'unknown', 'unknown', NULL, NULL),
(2, 1, 'Gayu Hedau', 'gayu@gmail.com', 'Gayu@123', '8381058482', NULL, 'active', 1, '2026-06-15 13:16:14', 2, '2026-06-22 11:06:22', '0', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIyIiwiaWF0IjoxNzgyMTI2MzA4LCJleHAiOjE3ODQ3MTgzMDh9.AAsquUz3FXQ-cPRhpXTP5Ybb5eL90v9f8xvLQcS_1rs', '2026-06-22 16:35:08', 'unknown', 'unknown', NULL, NULL),
(3, 1, 'Aarbaj Mulla', 'aarbaj@gmail.com', 'Aarbaj@123', '9876543212', NULL, 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, 'Nitesh Sharma', 'nitesh@gmail.com', 'Nitesh@123', '9876543212', NULL, 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiI0IiwiaWF0IjoxNzgyMTIzNzk1LCJleHAiOjE3ODQ3MTU3OTV9.FY-htWoUImn7M8-Vlwp4UH6ejqpRpJgcwZaNBp5gCRI', '2026-06-22 15:53:15', 'unknown', 'unknown', NULL, NULL),
(6, 1, 'Mayur', 'mayur@gmail.com', 'Mayur@123', '9876543212', NULL, 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` int(11) NOT NULL,
  `vendor_name` varchar(150) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `added_by` int(11) DEFAULT 1,
  `added_date` datetime DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `daily_collections`
--
ALTER TABLE `daily_collections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_id` (`shop_id`),
  ADD KEY `shop_id_2` (`shop_id`),
  ADD KEY `shop_id_3` (`shop_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_id` (`shop_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `franchises`
--
ALTER TABLE `franchises`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `grocery_categories`
--
ALTER TABLE `grocery_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `grocery_items`
--
ALTER TABLE `grocery_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `grocery_purchases`
--
ALTER TABLE `grocery_purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_id` (`shop_id`),
  ADD KEY `grocery_item_id` (`grocery_item_id`),
  ADD KEY `vendor_id` (`vendor_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `daily_collections`
--
ALTER TABLE `daily_collections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `franchises`
--
ALTER TABLE `franchises`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `grocery_categories`
--
ALTER TABLE `grocery_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `grocery_items`
--
ALTER TABLE `grocery_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `grocery_purchases`
--
ALTER TABLE `grocery_purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`),
  ADD CONSTRAINT `expenses_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `expense_categories` (`id`);

--
-- Constraints for table `grocery_items`
--
ALTER TABLE `grocery_items`
  ADD CONSTRAINT `grocery_items_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `grocery_categories` (`id`);

--
-- Constraints for table `grocery_purchases`
--
ALTER TABLE `grocery_purchases`
  ADD CONSTRAINT `grocery_purchases_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`),
  ADD CONSTRAINT `grocery_purchases_ibfk_2` FOREIGN KEY (`grocery_item_id`) REFERENCES `grocery_items` (`id`),
  ADD CONSTRAINT `grocery_purchases_ibfk_3` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
