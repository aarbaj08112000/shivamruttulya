ALTER TABLE `users` ADD COLUMN `profile_image` text COLLATE utf8mb4_general_ci DEFAULT NULL AFTER `mobile`;

ALTER TABLE `shops` ADD COLUMN `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL AFTER `contact_number`;
ALTER TABLE `shops` ADD COLUMN `opening_date` date DEFAULT NULL AFTER `address`;
