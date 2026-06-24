-- =====================================================
-- Table: menu_master
-- =====================================================

CREATE TABLE IF NOT EXISTS `menu_master` (
    `menu_id` INT(11) NOT NULL AUTO_INCREMENT,
    `menu_title` VARCHAR(255) NOT NULL,
    `price` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
    `description` TEXT DEFAULT NULL,
    `image` VARCHAR(255) DEFAULT NULL,
    `status` ENUM('active','inactive') DEFAULT 'active',
    `added_by` INT(11) DEFAULT 1,
    `added_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_by` INT(11) DEFAULT NULL,
    `updated_date` DATETIME DEFAULT NULL,
    `is_delete` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted',
    PRIMARY KEY (`menu_id`),
    KEY `idx_menu_status` (`status`),
    KEY `idx_menu_is_delete` (`is_delete`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- =====================================================
-- Table: accessories_master
-- =====================================================

CREATE TABLE IF NOT EXISTS `accessories_master` (
    `accessory_id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT DEFAULT NULL,
    `total_number` INT(11) DEFAULT 0,
    `status` ENUM('active','inactive') DEFAULT 'active',
    `added_by` INT(11) DEFAULT 1,
    `added_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_by` INT(11) DEFAULT NULL,
    `updated_date` DATETIME DEFAULT NULL,
    `is_delete` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 = active, 1 = deleted',
    PRIMARY KEY (`accessory_id`),
    KEY `idx_accessory_status` (`status`),
    KEY `idx_accessory_is_delete` (`is_delete`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `menu_master`
(`menu_title`, `price`, `description`, `image`)
VALUES
('Tea', 10.00, 'Regular tea', 'tea.jpg'),
('Coffee', 20.00, 'Hot coffee', 'coffee.jpg');

INSERT INTO `accessories_master`
(`name`, `description`)
VALUES
('Paper Cup', 'Disposable tea cup'),
('Plastic Spoon', 'Tea/Coffee spoon');

ALTER TABLE `accessories_master`
ADD COLUMN `total_number` INT(11) DEFAULT 0 AFTER `description`;


ALTER TABLE `accessories_master` ADD `shop_id` INT NULL AFTER `accessory_id`;
ALTER TABLE `menu_master` ADD `shop_id` INT NULL AFTER `menu_id`;

CREATE TABLE app_version (
    id INT AUTO_INCREMENT PRIMARY KEY,
    latest_version VARCHAR(20) NOT NULL,
    minimum_version VARCHAR(20) NOT NULL,
    force_update TINYINT(1) DEFAULT 1,
    update_message TEXT,
    apk_url VARCHAR(255) NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    uploaded_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

