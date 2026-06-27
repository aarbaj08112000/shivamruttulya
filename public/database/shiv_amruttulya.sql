-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 27, 2026 at 02:55 PM
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
-- Table structure for table `accessories_master`
--

CREATE TABLE `accessories_master` (
  `accessory_id` int NOT NULL,
  `shop_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `total_number` int DEFAULT '0',
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `added_by` int DEFAULT '1',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accessories_master`
--

INSERT INTO `accessories_master` (`accessory_id`, `shop_id`, `name`, `description`, `total_number`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, NULL, 'Paper Cup', 'Disposable tea cup', 0, 'active', 1, '2026-06-23 10:46:20', 2, '2026-06-23 11:34:33', '1'),
(2, NULL, 'Plastic Spoon', 'Tea/Coffee spoon', 0, 'active', 1, '2026-06-23 10:46:20', NULL, NULL, '0'),
(3, NULL, 'Plastic Spoon', 'Tea/Coffee spoon', 550, 'active', 2, '2026-06-23 11:20:54', 2, '2026-06-23 11:35:40', '0'),
(4, NULL, 'Plastic Spoon', 'Tea/Coffee spoon', 550, 'active', 2, '2026-06-23 11:32:54', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `app_version`
--

CREATE TABLE `app_version` (
  `id` int NOT NULL,
  `latest_version` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `minimum_version` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `force_update` tinyint(1) DEFAULT '1',
  `update_message` text COLLATE utf8mb4_general_ci,
  `apk_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `uploaded_date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(2, 2, '2026-06-10', '2200.00', '1500.00', '3700.00', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(3, 1, '2026-06-16', '3000.00', '1500.00', '4500.00', 'active', 1, '2026-06-17 15:49:18', 1, '2026-06-17 15:52:00', '1'),
(4, 2, '2026-06-22', '500.00', '200.00', '700.00', 'active', 1, '2026-06-22 18:05:18', NULL, NULL, '0');

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
  `attachement` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
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

INSERT INTO `expenses` (`id`, `shop_id`, `category_id`, `amount`, `expense_date`, `description`, `attachement`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 1, 1, '15000.00', '2026-06-01', 'Monthly Rent', NULL, 'active', 1, '2026-06-15 13:16:14', 1, '2026-06-17 16:04:00', '1'),
(2, 1, 2, '1500.00', '2026-06-16', 'Electricity Bill', NULL, 'active', 1, '2026-06-15 13:16:14', 1, '2026-06-17 16:05:05', '0'),
(3, 1, 2, '1500.00', '2026-06-16', 'Electricity Bill', NULL, 'active', 1, '2026-06-17 16:02:53', NULL, NULL, '0'),
(4, 1, 2, '1500.00', '2026-06-16', 'Electricity Bill', NULL, 'active', 2, '2026-06-21 14:32:06', 2, '2026-06-21 14:32:25', '0');

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
  `joining_date` date DEFAULT NULL,
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

INSERT INTO `franchises` (`id`, `franchise_code`, `franchise_name`, `owner_name`, `mobile`, `email`, `joining_date`, `address`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 'FR001', 'Shiv Amruttulya', 'Shivaji Patil', '9876543211', 'shiv@gmail.com', NULL, 'Pune', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(2, 'FR002', 'Shiv Amruttulya Mumbai', 'Ramesh', '9998887776', 'mumbai@shiv.com', NULL, 'Dadar, Mumbai', 'active', 1, '2026-06-17 16:11:19', 1, '2026-06-17 16:43:50', '1');

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
(3, 'Snacks', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(4, 'Buscuit', 'inactive', 1, '2026-06-22 17:34:53', 1, '2026-06-22 17:35:08', '1');

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
(3, 3, 'Biscuit Packet', 'Nos', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(4, 1, 'Sugar 12', 'Kgg', 'active', 1, '2026-06-17 15:19:24', 1, '2026-06-17 15:23:32', '1'),
(5, 2, 'test1', 'kg', 'active', 1, '2026-06-22 17:40:54', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `grocery_purchases`
--

CREATE TABLE `grocery_purchases` (
  `id` int NOT NULL,
  `shop_id` int DEFAULT NULL,
  `grocery_item_id` int DEFAULT NULL,
  `vendor_id` int DEFAULT NULL,
  `vendor_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `quantity` decimal(10,2) DEFAULT NULL,
  `rate` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `attachement` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
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

INSERT INTO `grocery_purchases` (`id`, `shop_id`, `grocery_item_id`, `vendor_id`, `vendor_name`, `purchase_date`, `quantity`, `rate`, `total_amount`, `attachement`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 1, 1, 1, NULL, '2026-06-01', '5.00', '450.00', '2250.00', NULL, 'active', 1, '2026-06-15 13:16:14', 1, '2026-06-17 15:33:19', '1'),
(2, 1, 2, 2, NULL, '2026-06-01', '20.00', '60.00', '1200.00', NULL, 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(3, 1, 2, 1, NULL, '2026-06-15', '12.00', '50.00', '500.00', NULL, 'active', 1, '2026-06-17 15:25:59', 1, '2026-06-17 15:29:38', '0'),
(4, 1, 2, 3, NULL, '2026-06-15', '10.00', '50.00', '500.00', NULL, 'active', 2, '2026-06-21 18:01:50', NULL, NULL, '0'),
(5, 1, 2, NULL, 'test', '2026-06-15', '10.00', '50.00', '500.00', NULL, 'active', 2, '2026-06-21 18:06:43', NULL, NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `menu_master`
--

CREATE TABLE `menu_master` (
  `menu_id` int NOT NULL,
  `shop_id` int DEFAULT NULL,
  `menu_title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `description` text COLLATE utf8mb4_general_ci,
  `image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `added_by` int DEFAULT '1',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `is_delete` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_master`
--

INSERT INTO `menu_master` (`menu_id`, `shop_id`, `menu_title`, `price`, `description`, `image`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, NULL, 'Tea', '10.00', 'Regular tea', 'tea.jpg', 'active', 1, '2026-06-23 10:46:20', NULL, NULL, '0'),
(2, NULL, 'Coffee', '20.00', 'Hot coffee', 'coffee.jpg', 'active', 1, '2026-06-23 10:46:20', NULL, NULL, '0'),
(3, NULL, 'Coffee', '20.00', 'Hot coffee', NULL, 'active', 2, '2026-06-23 11:01:32', NULL, NULL, '0'),
(4, NULL, 'Coffee', '20.00', 'Hot coffee', 'ggddgd.jpg', 'inactive', 2, '2026-06-23 11:02:00', 2, '2026-06-23 11:03:45', '1'),
(5, 2, 'test', '10.00', 'Test', 'bd195f0fac77dd2f20533c32d426f06f.jpg', 'active', 2, '2026-06-23 12:31:05', 1, '2026-06-26 18:17:13', '0');

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
  `contact_person` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_number` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `opening_date` date DEFAULT NULL,
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

INSERT INTO `shops` (`id`, `franchise_id`, `shop_code`, `shop_name`, `contact_person`, `contact_number`, `email`, `address`, `opening_date`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`) VALUES
(1, 1, 'SH001', 'Shiv Amruttulya Chinchwad', 'Manager 1', '9876543213', NULL, 'Chinchwad', NULL, 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(2, 1, 'SH002', 'Shiv Amruttulya Akurdi', 'Manager 2', '9876543214', NULL, 'Akurdi', NULL, 'active', 1, '2026-06-15 13:16:14', 1, '2026-06-15 23:36:02', '0'),
(3, NULL, '78456', 'Testing', '', '7845978459', NULL, '', NULL, 'active', 1, '2026-06-15 23:07:46', 1, '2026-06-16 00:05:19', '1'),
(4, NULL, '784', 'Shiv Amruttulya Wakad Updated', 'Tester', '7845961230', NULL, 'New Dehli', NULL, 'inactive', 1, '2026-06-16 00:12:43', 2, '2026-06-19 16:03:35', '1'),
(5, NULL, NULL, 'Shiv Amruttulya Wakad', NULL, NULL, NULL, 'Wakad Bridge', NULL, 'active', 1, '2026-06-17 14:48:41', NULL, NULL, '0'),
(6, NULL, NULL, 'Shiv Amruttulya Wakad 12', 'Amit', '9998887776', NULL, 'Wakad Bridge', NULL, 'active', 1, '2026-06-17 14:51:15', NULL, NULL, '0'),
(7, NULL, 'SA-001', 'testing', '', '4774583331', NULL, '', NULL, 'active', 1, '2026-06-21 14:52:50', NULL, NULL, '0');

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
  `profile_image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
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

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `password`, `mobile`, `profile_image`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`, `is_delete`, `api_token`, `token_issued_at`, `device_id`, `device_type`, `otp`, `otp_validity`) VALUES
(1, 1, 'User 123', 'admin@gmail.com', '123456', '7854123690', NULL, 'active', 1, '2026-06-15 13:16:14', 1, '2026-06-18 14:33:09', '0', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIxIiwiaWF0IjoxNzgxNzcyMDMyLCJleHAiOjE3ODQzNjQwMzJ9.fkGLm4QU5ybaIPwXWkvg0F2YxdJMjgGYocSP5ZSZZkU', '2026-06-18 14:10:32', 'unknown', 'unknown', NULL, NULL),
(2, 2, 'Code Crafter Info', 'owner@test.com', '123456', '8745693210', 'bd1052d535cbf06e363d454d5ac1fd8a.jpg', 'active', 1, '2026-06-15 13:16:14', 2, '2026-06-21 15:34:29', '0', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIyIiwiaWF0IjoxNzgyNDY4NDI0LCJleHAiOjE3ODUwNjA0MjR9.442dz1K3sNnOwBZ_zg0WV6JoRZsgMtFOZCUFQwOofFU', '2026-06-26 15:37:04', 'unknown', 'unknown', NULL, NULL),
(3, 3, 'Shop Manager', 'manager@test.com', '123456', '9876543212', NULL, 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);

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
(2, 'XYZ Suppliers', '9876543221', 'Pune', 'active', 1, '2026-06-15 13:16:14', NULL, NULL, '0'),
(3, 'test', NULL, NULL, 'active', 2, '2026-06-21 18:01:50', NULL, NULL, '0');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accessories_master`
--
ALTER TABLE `accessories_master`
  ADD PRIMARY KEY (`accessory_id`),
  ADD KEY `idx_accessory_status` (`status`),
  ADD KEY `idx_accessory_is_delete` (`is_delete`);

--
-- Indexes for table `app_version`
--
ALTER TABLE `app_version`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `menu_master`
--
ALTER TABLE `menu_master`
  ADD PRIMARY KEY (`menu_id`),
  ADD KEY `idx_menu_status` (`status`),
  ADD KEY `idx_menu_is_delete` (`is_delete`);

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
-- AUTO_INCREMENT for table `accessories_master`
--
ALTER TABLE `accessories_master`
  MODIFY `accessory_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `app_version`
--
ALTER TABLE `app_version`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `daily_collections`
--
ALTER TABLE `daily_collections`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `franchises`
--
ALTER TABLE `franchises`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `grocery_categories`
--
ALTER TABLE `grocery_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `grocery_items`
--
ALTER TABLE `grocery_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `grocery_purchases`
--
ALTER TABLE `grocery_purchases`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `menu_master`
--
ALTER TABLE `menu_master`
  MODIFY `menu_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
