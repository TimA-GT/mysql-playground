-- authentication db
DROP DATABASE IF EXISTS `authentication`;
CREATE DATABASE `authentication`;
USE `authentication`;

-- add tables to authentication db
DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `username` varchar(50) UNIQUE NOT NULL,
    PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `user_access`;

CREATE TABLE `user_access` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `userID` INT,
    `tenant` INT DEFAULT NULL,
    `account` INT DEFAULT NULL,
    PRIMARY KEY (`ID`),
    FOREIGN KEY (`userID`) REFERENCES users(`ID`)
);

-- add data to auth db tables
LOCK TABLES `users` WRITE;
INSERT IGNORE INTO `users`
VALUES
    (1, 'timmy'),
    (2, 'sarah'),
    (3, 'ari');
UNLOCK TABLES;

LOCK TABLES `user_access` WRITE;
INSERT IGNORE INTO `user_access`
VALUES
    (3, 1, 1, NULL),
    (4, 1, 2, NULL),
    (5, 1, NULL, 10),
    (6, 1, NULL, 11),
    (7, 2, 1, NULL);
UNLOCK TABLES;

-- xadcms db
DROP DATABASE IF EXISTS `xadcms`;
CREATE DATABASE `xadcms`;
USE `xadcms`;

-- add tables to xadcms db
DROP TABLE IF EXISTS `campaign`;

CREATE TABLE `campaign` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `campaign_name` varchar(255),
    `tenant` INT,
    `account` INT,
    `start_date` date DEFAULT NULL,
    `end_date` date DEFAULT NULL,
    PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `campaign_reports`;

CREATE TABLE `campaign_reports` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `campaignID` INT,
    `last_updated` date DEFAULT NULL,
    `s3_link` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`ID`),
    FOREIGN KEY (`campaignID`) REFERENCES campaign(`ID`)
);

-- add data to xadcms db tables
LOCK TABLES `campaign` WRITE;
INSERT IGNORE INTO `campaign`
VALUES
    (1, 'my cool campaign', 1, 10, '2022-05-01', '2022-05-25'),
    (2, 'my slow campaign', 1, 11, '2022-01-01', '2022-03-01'),
    (3, 'my bold campaign', 2, 21, '2022-01-01', '2022-03-01'),
    (4, 'my fast campaign', 2, 22, '2022-01-01', '2022-03-01'),
    (5, 'my tall campaign', 1, 10, '2022-01-01', '2022-03-01');
UNLOCK TABLES;

LOCK TABLES `campaign_reports` WRITE;
INSERT IGNORE INTO `campaign_reports`
VALUES
    (1, 1, NULL, NULL),
    (2, 2, NULL, NULL);
UNLOCK TABLES;

-- to execute this run:
-- mysql -u root -proot < schema.sql
