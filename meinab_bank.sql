-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: meinab_bank
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_no` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_type` varchar(45) NOT NULL,
  `account_balance` float NOT NULL DEFAULT '0',
  `customer_id` int NOT NULL,
  PRIMARY KEY (`account_no`),
  KEY `fk_customer_id_idx` (`customer_id`),
  CONSTRAINT `fk_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000003 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (10000001,'saving',78502,1),(10000002,'saving',21998,2);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_fname` varchar(45) NOT NULL,
  `customer_lname` varchar(45) NOT NULL,
  `customer_phone_no` varchar(45) NOT NULL,
  `customer_IDimage` varchar(45) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Hiwot','Chernet','0978904679','hiwot.png'),(2,'Ruth','Damtaw','0913784406','ruta.png');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `customer_account`
--

DROP TABLE IF EXISTS `customer_account`;
/*!50001 DROP VIEW IF EXISTS `customer_account`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customer_account` AS SELECT 
 1 AS `customer_id`,
 1 AS `customer_fname`,
 1 AS `customer_lname`,
 1 AS `customer_phone_no`,
 1 AS `account_no`,
 1 AS `account_balance`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transaction_order`
--

DROP TABLE IF EXISTS `transaction_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_order` (
  `order_id` varchar(45) NOT NULL,
  `order_from` bigint unsigned NOT NULL,
  `order_to` bigint unsigned NOT NULL,
  `order_amount` float NOT NULL,
  `order_status` varchar(45) NOT NULL,
  `order_time` timestamp NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_from_idx` (`order_from`),
  KEY `fk_to_idx` (`order_to`),
  CONSTRAINT `fk_from` FOREIGN KEY (`order_from`) REFERENCES `account` (`account_no`),
  CONSTRAINT `fk_to` FOREIGN KEY (`order_to`) REFERENCES `account` (`account_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_order`
--

LOCK TABLES `transaction_order` WRITE;
/*!40000 ALTER TABLE `transaction_order` DISABLE KEYS */;
INSERT INTO `transaction_order` VALUES ('TA100000',10000001,10000002,1000,'successful','2023-03-04 08:27:42'),('TA100001',10000001,10000002,500,'successful','2023-03-04 13:01:27'),('TA100002',10000001,10000002,9999,'successful','2023-03-21 19:15:39');
/*!40000 ALTER TABLE `transaction_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transfer`
--

DROP TABLE IF EXISTS `transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transfer` (
  `transfer_id` int NOT NULL AUTO_INCREMENT,
  `transfer_from_account` bigint unsigned NOT NULL,
  `transfer_to_account` bigint unsigned NOT NULL,
  `amount` float NOT NULL,
  `transfer_timestamp` timestamp NOT NULL,
  PRIMARY KEY (`transfer_id`),
  KEY `fk_from_account_idx` (`transfer_from_account`),
  KEY `fk_to_account_idx` (`transfer_to_account`),
  CONSTRAINT `fk_from_account` FOREIGN KEY (`transfer_from_account`) REFERENCES `account` (`account_no`),
  CONSTRAINT `fk_to_account` FOREIGN KEY (`transfer_to_account`) REFERENCES `account` (`account_no`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfer`
--

LOCK TABLES `transfer` WRITE;
/*!40000 ALTER TABLE `transfer` DISABLE KEYS */;
INSERT INTO `transfer` VALUES (1,10000001,10000002,1000,'2023-03-04 08:54:56'),(2,10000001,10000002,500,'2023-03-04 13:03:04'),(3,10000001,10000002,9999,'2023-03-21 19:25:47'),(4,10000001,10000002,9999,'2023-03-21 19:31:27');
/*!40000 ALTER TABLE `transfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_account`
--

DROP TABLE IF EXISTS `user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_account` (
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `fk_cid_idx` (`customer_id`),
  CONSTRAINT `fk_ccid` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_account`
--

LOCK TABLES `user_account` WRITE;
/*!40000 ALTER TABLE `user_account` DISABLE KEYS */;
INSERT INTO `user_account` VALUES ('hiwot11','12345678',1);
/*!40000 ALTER TABLE `user_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'meinab_bank'
--
/*!50003 DROP PROCEDURE IF EXISTS `authentication` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `authentication`(in usernamee varchar(45), in passwordd varchar(45))
BEGIN
declare customer_phone_noo varchar(45);
declare account_noo bigint;
declare c_id int;
if((select count(*) from user_account where username = usernamee and password = passwordd)=1)
then 
set c_id = (select customer_id from user_account where username = usernamee and password = passwordd);
select customer_phone_no, account_no INTO customer_phone_noo, account_noo from customer_account where customer_id = c_id;
else
signal sqlstate '45000' set message_text = "invalid username and password";
end if;
select customer_phone_noo as customer_phone_no, account_noo as account_no;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `transaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `transaction`(in amount double,sender_account BIGINT,receiver_account BIGINT)
BEGIN

declare sender_previous_amount double;
declare receiver_previous_amount double;
declare sender_amount double;
declare receiver_amount double;
declare id int;
# START TRANSACTION; 
set sender_previous_amount = (select account_balance from account where account_no = sender_account);
if(sender_previous_amount>=amount)
then
# set sender_amount = sender_previous_amount-amount;
# update account set account_balance = sender_amount where account_no = sender_account;
# set receiver_previous_amount = (select account_balance from account where account_no = receiver_account);
# set receiver_amount = receiver_previous_amount + amount;
# update account set account_balance = receiver_amount where account_no = receiver_account;
set id = (select count(*) from transaction_order);
insert into transaction_order (order_id,order_from,order_to,order_amount,order_status, order_time) values
(concat('TA',100000+ id),sender_account,receiver_account,amount,'pending',CURRENT_TIMESTAMP());
select concat('TA',100000+ id) as order_id;
# commit;
else
signal sqlstate '45000' set message_text = "insufficent balance";
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `transfer_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `transfer_order`(in o_id varchar(45))
BEGIN
declare sender_account bigint;
declare receiver_account bigint;
declare amount double;
declare sender_previous_amount double;
declare receiver_previous_amount double;
declare sender_amount double;
declare receiver_amount double;
START transaction;
SELECT order_from, order_to, order_amount INTO sender_account, receiver_account, amount FROM transaction_order where order_id = o_id;
set sender_previous_amount = (select account_balance from account where account_no = sender_account);
set sender_amount = sender_previous_amount-amount;
update account set account_balance = sender_amount where account_no = sender_account;
set receiver_previous_amount = (select account_balance from account where account_no = receiver_account);
set receiver_amount = receiver_previous_amount + amount;
update account set account_balance = receiver_amount where account_no = receiver_account;
insert into transfer (transfer_from_account,transfer_to_account,amount,transfer_timestamp) values
(sender_account,receiver_account,amount,CURRENT_TIMESTAMP());
update transaction_order set order_status = 'successful' where order_id = o_id;
COMMIT;
SELECT * from transaction_order where order_id = o_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `customer_account`
--

/*!50001 DROP VIEW IF EXISTS `customer_account`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customer_account` AS select `customer`.`customer_id` AS `customer_id`,`customer`.`customer_fname` AS `customer_fname`,`customer`.`customer_lname` AS `customer_lname`,`customer`.`customer_phone_no` AS `customer_phone_no`,`account`.`account_no` AS `account_no`,`account`.`account_balance` AS `account_balance` from (`customer` join `account` on((`customer`.`customer_id` = `account`.`customer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-13 16:40:46
