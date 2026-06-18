-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 16, 2026 at 02:04 PM
-- Server version: 8.0.46-0ubuntu0.22.04.2
-- PHP Version: 8.1.2-1ubuntu2.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shiv_amruttulya`
--

-- --------------------------------------------------------

--
-- Table structure for table `daily_collections`
--

CREATE TABLE `daily_collections` (
  `id` int NOT NULL,
  `shop_id` int DEFAULT NULL,
  `collection_date` date DEFAULT NULL,
  `cash_amount` decimal(10,2) DEFAULT NULL,
  `online_amount` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `added_by` int DEFAULT '1',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_collections`
--

INSERT INTO `daily_collections` (`id`, `shop_id`, `collection_date`, `cash_amount`, `online_amount`, `total_amount`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 1, '2026-06-10', '2500.00', '1800.00', '4300.00', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(2, 2, '2026-06-10', '2200.00', '1500.00', '3700.00', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int NOT NULL,
  `shop_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `expense_date` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `added_by` int DEFAULT '1',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `shop_id`, `category_id`, `amount`, `expense_date`, `description`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 1, 1, '15000.00', '2026-06-01', 'Monthly Rent', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(2, 1, 2, '3500.00', '2026-06-05', 'Electric Bill', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int NOT NULL,
  `category_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `added_by` int DEFAULT '1',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `category_name`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 'Rent', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(2, 'Electricity', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(3, 'Salary', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(4, 'Maintenance', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `franchises`
--

CREATE TABLE `franchises` (
  `id` int NOT NULL,
  `franchise_code` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `franchise_name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `owner_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `added_by` int DEFAULT '1',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `franchises`
--

INSERT INTO `franchises` (`id`, `franchise_code`, `franchise_name`, `owner_name`, `mobile`, `email`, `address`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 'FR001', 'Shiv Amruttulya', 'Shivaji Patil', '9876543211', 'shiv@gmail.com', 'Pune', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `grocery_categories`
--

CREATE TABLE `grocery_categories` (
  `id` int NOT NULL,
  `category_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `added_by` int DEFAULT '1',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grocery_categories`
--

INSERT INTO `grocery_categories` (`id`, `category_name`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 'Tea Material', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(2, 'Milk Products', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(3, 'Snacks', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `grocery_items`
--

CREATE TABLE `grocery_items` (
  `id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `item_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `unit` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `added_by` int DEFAULT '1',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grocery_items`
--

INSERT INTO `grocery_items` (`id`, `category_id`, `item_name`, `unit`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 1, 'Tea Powder', 'Kg', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(2, 2, 'Milk', 'Ltr', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(3, 3, 'Biscuit Packet', 'Nos', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `grocery_purchases`
--

CREATE TABLE `grocery_purchases` (
  `id` int NOT NULL,
  `shop_id` int DEFAULT NULL,
  `grocery_item_id` int DEFAULT NULL,
  `vendor_id` int DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `quantity` decimal(10,2) DEFAULT NULL,
  `rate` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `added_by` int DEFAULT '1',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grocery_purchases`
--

INSERT INTO `grocery_purchases` (`id`, `shop_id`, `grocery_item_id`, `vendor_id`, `purchase_date`, `quantity`, `rate`, `total_amount`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 1, 1, 1, '2026-06-01', '5.00', '450.00', '2250.00', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(2, 1, 2, 2, '2026-06-01', '20.00', '60.00', '1200.00', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int NOT NULL,
  `role_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `added_by` int DEFAULT '1',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
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
  `id` int NOT NULL,
  `franchise_id` int DEFAULT NULL,
  `shop_code` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shop_name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `manager_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `added_by` int DEFAULT '1',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`id`, `franchise_id`, `shop_code`, `shop_name`, `manager_name`, `mobile`, `address`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 1, 'SH001', 'Shiv Amruttulya Chinchwad', 'Manager 1', '9876543213', 'Chinchwad', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(2, 1, 'SH002', 'Shiv Amruttulya Akurdi', 'Manager 2', '9876543214', 'Akurdi', 'active', 1, '2026-06-15 13:16:14', 1, '2026-06-15 23:36:02', '0'),
(3, NULL, '78456', 'Testing', '', '7845978459', '', 'active', 1, '2026-06-15 23:07:46', 1, '2026-06-16 00:05:19', '1'),
(4, NULL, '784', 'Testing 1 ', 'Tester', '7845961230', 'New Dehli', 'active', 1, '2026-06-16 00:12:43', 1, '2026-06-16 00:12:58', '0');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `role_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `added_by` int DEFAULT '1',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted',
  `api_token` text COLLATE utf8mb4_general_ci,
  `token_issued_at` datetime DEFAULT NULL,
  `device_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `device_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `otp` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `otp_validity` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `password`, `mobile`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`, `api_token`, `token_issued_at`, `device_id`, `device_type`, `otp`, `otp_validity`) VALUES
(1, 1, 'Code Crafter Infotech', 'admin@gmail.com', '123456', '9876543210', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIxIiwiaWF0IjoxNzgxNTk3MjI4LCJleHAiOjE3ODQxODkyMjh9.slvJmwUSaldr8DC6Tx0XFljFjkmSLSTBRCSjwX7_0KY', '2026-06-16 13:37:08', 'unknown', 'unknown', NULL, NULL),
(2, 2, 'Shivaji Patil', 'owner@test.com', '123456', '9876543211', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 3, 'Shop Manager', 'manager@test.com', '123456', '9876543212', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` int NOT NULL,
  `vendor_name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `added_by` int DEFAULT '1',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `vendor_name`, `mobile`, `address`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 'ABC Traders', '9876543220', 'Pune', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(2, 'XYZ Suppliers', '9876543221', 'Pune', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `daily_collections`
--
ALTER TABLE `daily_collections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_id` (`shop_id`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `franchise_id` (`franchise_id`);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `franchises`
--
ALTER TABLE `franchises`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `grocery_categories`
--
ALTER TABLE `grocery_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `grocery_items`
--
ALTER TABLE `grocery_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `grocery_purchases`
--
ALTER TABLE `grocery_purchases`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `daily_collections`
--
ALTER TABLE `daily_collections`
  ADD CONSTRAINT `daily_collections_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`);

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
-- Constraints for table `shops`
--
ALTER TABLE `shops`
  ADD CONSTRAINT `shops_ibfk_1` FOREIGN KEY (`franchise_id`) REFERENCES `franchises` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
