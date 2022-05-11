DROP DATABASE IF EXISTS `auth`;
CREATE DATABASE `auth`;
USE `auth`;

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
    `tenant` INT,
    `account` INT,
    PRIMARY KEY (`ID`),
    FOREIGN KEY (`userID`) REFERENCES users(`ID`)
);


DROP DATABASE IF EXISTS `xadcms`;
CREATE DATABASE `xadcms`;
USE `xadcms`;

DROP TABLE IF EXISTS `campaign`;

CREATE TABLE `campaign` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `campaign_name` varchar(50),
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
    `s3_link` varchar(150),
    PRIMARY KEY (`ID`),
    FOREIGN KEY (`campaignID`) REFERENCES campaign(`ID`)
);


-- to execute this run:
-- mysql -u root -proot < schema.sql 