/*
SQLyog Community v8.71 
MySQL - 5.5.30 : Database - vtjdm15_25
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`vtjdm15_25` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `vtjdm15_25`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `admin` */

insert  into `admin`(`id`,`username`,`password`) values (1,'admin','admin123');

/*Table structure for table `clients` */

DROP TABLE IF EXISTS `clients`;

CREATE TABLE `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `clients` */

insert  into `clients`(`id`,`username`,`password`) values (1,'client@gmail.com','client');

/*Table structure for table `file_tokens` */

DROP TABLE IF EXISTS `file_tokens`;

CREATE TABLE `file_tokens` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `batch_id` varchar(64) NOT NULL,
  `token_index` int(11) NOT NULL,
  `original_value` text NOT NULL,
  `encrypted_value` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_value` varchar(255) DEFAULT NULL,
  `unique_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_batch` (`batch_id`),
  KEY `idx_batch_order` (`batch_id`,`token_index`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

/*Data for the table `file_tokens` */

insert  into `file_tokens`(`id`,`batch_id`,`token_index`,`original_value`,`encrypted_value`,`created_at`,`data_value`,`unique_key`) values (1,'48a013e8-7e09-4806-acfc-49ed7c6d67dd',1,'1','n8q4Y9HwFKC30itqBM5tcQ==:k2LOmEnQlYeBO0Df7GO0mQ==','2025-08-23 11:03:23','sno','8505870100592397'),(2,'48a013e8-7e09-4806-acfc-49ed7c6d67dd',2,'23.5','hiotF6n3W9JQUYozmb5Rdw==:rVg+XodTo2Nq4pgFS6i1SQ==','2025-08-23 11:03:23','temperature','7756581707210619'),(3,'48a013e8-7e09-4806-acfc-49ed7c6d67dd',3,'23.5','p9NMMQuSvOlpzceuKPLIMw==:lpu9HgCRnOz3gOQwqBY8SQ==','2025-08-23 11:03:23','pressure','6498408692924797'),(4,'48a013e8-7e09-4806-acfc-49ed7c6d67dd',4,'2','mSzzXMmeVIb4VMqzMbOQWQ==:Jk4vDnEI0izpEf3LOCpSyg==','2025-08-23 11:03:23','sno','6347954001615614'),(5,'48a013e8-7e09-4806-acfc-49ed7c6d67dd',5,'45','JCzEbWGZADkT96oA4g6ihQ==:dYXpc/a/0jr5OcpHlE5hbw==','2025-08-23 11:03:23','temperature','8125124023721344'),(6,'48a013e8-7e09-4806-acfc-49ed7c6d67dd',6,'32','Pz0HUs4kHIPRBCU/XffZrg==:ZMQVknV90n/PninAQQ5sVQ==','2025-08-23 11:03:23','pressure','5431826361820886'),(7,'48a013e8-7e09-4806-acfc-49ed7c6d67dd',7,'3','lk1biXSPMwTLNYphM/0KAg==:38kbuzvpHlW24cpvxjJClg==','2025-08-23 11:03:23','sno','6706553592044464'),(8,'48a013e8-7e09-4806-acfc-49ed7c6d67dd',8,'45.4','Nk1sXjMUHOqY65cFKIxJGg==:JKOzF5u7Uv0hfcBogWtDZA==','2025-08-23 11:03:23','temperature','4193779615566138'),(9,'48a013e8-7e09-4806-acfc-49ed7c6d67dd',9,'45.7','BYs/x3AltxPNhedRVwdtuA==:pevv5ek5q+XY45HSDMEXbw==','2025-08-23 11:03:23','pressure','2590430101358845'),(10,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',1,'1','/3iXvtId81QVeqv9N91BcA==:b5xJl6Is5F3860PG0Be33Q==','2025-08-23 11:22:32','sno','0307378786665290'),(11,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',2,'23.5','iwnOf5I2vTDx4qL8yONhJQ==:MuiZB1rDTLVT/5NbdjrfZA==','2025-08-23 11:22:32','temperature','4653746839069836'),(12,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',3,'23.5','cUB8nQWIN8fXlBuBQ55+gQ==:eNk35nYuBpEpxOitFLvwvg==','2025-08-23 11:22:32','humidity','2319673986945583'),(13,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',4,'24','5wsIoOor0k0ig+6y4lROuw==:VO6LJWtF0Y+FIXlxJ9rl6w==','2025-08-23 11:22:32','pressure','5979022093332433'),(14,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',5,'45','Hb3oZx5zXhIWHrpOzOWz5Q==:6f5x9kMV6TMWJ82XZRckwQ==','2025-08-23 11:22:32','light','2821970126372385'),(15,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',6,'2','VnsNfjk74ZtRpi8/yzxLlQ==:SkQtfMvK4ulItp2GW86Pgw==','2025-08-23 11:22:32','sno','2666403709725699'),(16,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',7,'45','jzdvmj/lHn8eehfXDEuuXQ==:gKKrQaUCDnUT9P7/6J/w8w==','2025-08-23 11:22:32','temperature','6759813552391135'),(17,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',8,'32','yK31+tWAunEBIw5mIh4bRw==:6D/6fblNYPQU9pl3WmTkNw==','2025-08-23 11:22:32','humidity','7400205851019842'),(18,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',9,'22','vxns5QV2KWBBl6H9/Gnktg==:D+dAdUA996pyJbMBPVn4FA==','2025-08-23 11:22:32','pressure','2986595152483201'),(19,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',10,'11','p09lgqCVKfOEn6Al17FniQ==:zUIxbSPwSxWPIl7Muzl/WA==','2025-08-23 11:22:32','light','1152617237519726'),(20,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',11,'3','zVkecJ+5aQv6aAf2vwLuuA==:v6ObKo9bNMDlhz9bvd4VsQ==','2025-08-23 11:22:32','sno','6574375258571022'),(21,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',12,'45.4','0NpOd42TUJgkQy7661PBCA==:BHgLwuYpdXdkwJK6yuUEjw==','2025-08-23 11:22:32','temperature','6614064064454456'),(22,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',13,'45.7','6dmsJqQfiyNchhxU9lsXWQ==:ZwKkvBLLpiSAOJNbcLBeWA==','2025-08-23 11:22:32','humidity','6336811090209705'),(23,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',14,'34.66','DfZchVT7l43h6n8OA9CNyw==:i9YOffrLvk25G0CIb9fqIg==','2025-08-23 11:22:32','pressure','0768195137619594'),(24,'e59b6e0b-d5b4-4f30-be0c-a4c63dfd0474',15,'112','Qjhg4vJg6qgaVC2RT6ixJg==:Nyb6SqqWicJKSxigwXC/PA==','2025-08-23 11:22:32','light','1662013536508810');

/*Table structure for table `getvalue` */

DROP TABLE IF EXISTS `getvalue`;

CREATE TABLE `getvalue` (
  `Batch_id` varchar(255) DEFAULT NULL,
  `Enc_value` varchar(255) DEFAULT NULL,
  `Token_index` int(10) DEFAULT NULL,
  `time_stamp` varchar(255) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `getvalue` */

insert  into `getvalue`(`Batch_id`,`Enc_value`,`Token_index`,`time_stamp`,`userid`,`status`) values ('3dd6205f-d933-41bb-9e37-e97c79ce2ef4 ','9p7Gf103Qe5ew3cREDgCuw==:ht0zeMs5UV4ZpcWmcuatAw== ',1,'2025-08-21 10:34:43.0','Un2@gmail.com','7096318908722299'),('48a013e8-7e09-4806-acfc-49ed7c6d67dd','hiotF6n3W9JQUYozmb5Rdw==:rVg XodTo2Nq4pgFS6i1SQ==',2,'2025-08-23 11:03:23.0','Un2@gmail.com','pending'),('48a013e8-7e09-4806-acfc-49ed7c6d67dd','hiotF6n3W9JQUYozmb5Rdw==:rVg XodTo2Nq4pgFS6i1SQ==',2,'2025-08-23 11:03:23.0','Un2@gmail.com','pending'),('48a013e8-7e09-4806-acfc-49ed7c6d67dd','hiotF6n3W9JQUYozmb5Rdw==:rVg XodTo2Nq4pgFS6i1SQ==',2,'2025-08-23 11:03:23.0','Un2@gmail.com','pending'),('48a013e8-7e09-4806-acfc-49ed7c6d67dd','hiotF6n3W9JQUYozmb5Rdw==:rVg XodTo2Nq4pgFS6i1SQ==',2,'2025-08-23 11:03:23.0','Un2@gmail.com','pending'),('48a013e8-7e09-4806-acfc-49ed7c6d67dd','hiotF6n3W9JQUYozmb5Rdw==:rVg XodTo2Nq4pgFS6i1SQ==',2,'2025-08-23 11:03:23.0','Un2@gmail.com','pending'),('48a013e8-7e09-4806-acfc-49ed7c6d67dd','hiotF6n3W9JQUYozmb5Rdw==:rVg XodTo2Nq4pgFS6i1SQ==',2,'2025-08-23 11:03:23.0','Un2@gmail.com','pending');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `address` text,
  `data_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`username`,`password`,`email`,`dob`,`mobile`,`address`,`data_value`) values (1,'Un2','Un2@12345','Un2@gmail.com','2025-08-03','9977665544','hyderabad','Temperature');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
