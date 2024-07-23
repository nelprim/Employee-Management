CREATE DATABASE  IF NOT EXISTS `dbsales2.6` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dbsales2.6`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dbsales2.6
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `banks`
--

DROP TABLE IF EXISTS `banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banks` (
  `bank` int NOT NULL,
  `bankname` varchar(45) DEFAULT NULL,
  `branch` varchar(45) DEFAULT NULL,
  `branchaddress` varchar(45) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`bank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banks`
--

LOCK TABLES `banks` WRITE;
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `banks_BEFORE_INSERT` BEFORE INSERT ON `banks` FOR EACH ROW BEGIN

	DECLARE newbank INT;
	SELECT MAX(bank) + 1 INTO newbank FROM banks_audit;
	IF (newbank is NULL) THEN
		SET newbank := 1001;
	END IF;
		SET new.bank = newbank;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `banks_AFTER_INSERT` AFTER INSERT ON `banks` FOR EACH ROW BEGIN
	INSERT INTO banks_audit VALUES(new.bank, now(), 'C' ,NULL, NULL, NULL, new.bankname, new.branch, new.branchaddress, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `banks_AFTER_UPDATE` AFTER UPDATE ON `banks` FOR EACH ROW BEGIN
	IF (old.bank <> new.bank) THEN
		SIGNAL SQLSTATE  '45000' SET MESSAGE_TEXT = 'BANK ID cannot be modified';
	END IF;
	INSERT INTO banks_audit VALUES(new.bank, now(), 'U', old.bankname, old.branch, old.branchaddress, new.bankname, new.branch, new.branchaddress, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `banks_BEFORE_DELETE` BEFORE DELETE ON `banks` FOR EACH ROW BEGIN
	INSERT INTO banks_audit VALUES(old.bank, now(), 'D', old.bankname, old.branch, old.branchaddress, NULL, NULL, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `banks_audit`
--

DROP TABLE IF EXISTS `banks_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banks_audit` (
  `bank` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_bankname` varchar(45) DEFAULT NULL,
  `old_branch` varchar(45) DEFAULT NULL,
  `old_branchaddress` varchar(45) DEFAULT NULL,
  `new_bankname` varchar(45) DEFAULT NULL,
  `new_branch` varchar(45) DEFAULT NULL,
  `new_branchaddress` varchar(45) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`bank`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banks_audit`
--

LOCK TABLES `banks_audit` WRITE;
/*!40000 ALTER TABLE `banks_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `banks_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `check_payments`
--

DROP TABLE IF EXISTS `check_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `check_payments` (
  `customerNumber` int NOT NULL,
  `paymentTimestamp` datetime NOT NULL,
  `checkno` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customerNumber`,`paymentTimestamp`),
  KEY `FK-31_002_idx` (`checkno`),
  CONSTRAINT `FK-31_001` FOREIGN KEY (`customerNumber`, `paymentTimestamp`) REFERENCES `payments` (`customerNumber`, `paymentTimestamp`),
  CONSTRAINT `FK-31_002` FOREIGN KEY (`checkno`) REFERENCES `ref_checkno` (`checkno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `check_payments`
--

LOCK TABLES `check_payments` WRITE;
/*!40000 ALTER TABLE `check_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `check_payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_payments_BEFORE_INSERT` BEFORE INSERT ON `check_payments` FOR EACH ROW BEGIN
	SET new.paymentTimestamp := now();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_payments_AFTER_INSERT` AFTER INSERT ON `check_payments` FOR EACH ROW BEGIN
	INSERT INTO check_payments_audit VALUES(new.customerNumber, new.paymentTimestamp, now(), 'C', NULL, new.checkno, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_payments_AFTER_UPDATE` AFTER UPDATE ON `check_payments` FOR EACH ROW BEGIN
	IF (old.customerNumber <> new.customerNumber OR old.paymentTimestamp <> new.paymentTimestamp) THEN
		SIGNAL  SQLSTATE  '45000' SET MESSAGE_TEXT = 'customerNumber or paymentTimestamp cannot be modified';
	END IF;
	INSERT INTO check_payments_audit VALUES(new.customerNumber, new.paymentTimestamp, now(), 'U', old.checkno,  new.checkno, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_payments_BEFORE_DELETE` BEFORE DELETE ON `check_payments` FOR EACH ROW BEGIN
	INSERT INTO check_payments_audit VALUES(old.customerNumber, old.paymentTimestamp, now(), 'D', old.checkno, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `check_payments_audit`
--

DROP TABLE IF EXISTS `check_payments_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `check_payments_audit` (
  `customerNumber` int NOT NULL,
  `paymentTimestamp` datetime NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_checkno` int DEFAULT NULL,
  `new_checkno` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customerNumber`,`paymentTimestamp`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `check_payments_audit`
--

LOCK TABLES `check_payments_audit` WRITE;
/*!40000 ALTER TABLE `check_payments_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `check_payments_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `couriers`
--

DROP TABLE IF EXISTS `couriers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `couriers` (
  `courierName` varchar(100) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`courierName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `couriers`
--

LOCK TABLES `couriers` WRITE;
/*!40000 ALTER TABLE `couriers` DISABLE KEYS */;
INSERT INTO `couriers` VALUES ('Gogo Xpress','Makati City',NULL,NULL),('Grab','Makati City',NULL,NULL),('Lalamove',' Paranaque City',NULL,NULL);
/*!40000 ALTER TABLE `couriers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `couriers_AFTER_INSERT` AFTER INSERT ON `couriers` FOR EACH ROW BEGIN
	INSERT INTO couriers_audit VALUES(new.courierName, now(), 'C' , NULL, new.address, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `couriers_AFTER_UPDATE` AFTER UPDATE ON `couriers` FOR EACH ROW BEGIN
	IF (old.courierName <> new.courierName) THEN
		SIGNAL SQLSTATE  '45000' SET MESSAGE_TEXT = 'courierName cannot be modified';
	END IF;
	INSERT INTO couriers_audit VALUES(new.courierName, now(), 'U', old.address, new.address, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `couriers_BEFORE_DELETE` BEFORE DELETE ON `couriers` FOR EACH ROW BEGIN
	INSERT INTO couriers_audit VALUES(old.courierName, now(), 'D', old.address, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `couriers_audit`
--

DROP TABLE IF EXISTS `couriers_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `couriers_audit` (
  `courierName` varchar(100) NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_address` varchar(100) DEFAULT NULL,
  `new_address` varchar(100) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`courierName`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `couriers_audit`
--

LOCK TABLES `couriers_audit` WRITE;
/*!40000 ALTER TABLE `couriers_audit` DISABLE KEYS */;
INSERT INTO `couriers_audit` VALUES ('Gogo Xpress','2024-07-20 03:43:22','C',NULL,'Makati City',NULL,NULL),('Grab','2024-07-20 03:43:22','C',NULL,'Makati City',NULL,NULL),('Lalamove','2024-07-20 03:43:22','C',NULL,' Paranaque City',NULL,NULL);
/*!40000 ALTER TABLE `couriers_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_payments`
--

DROP TABLE IF EXISTS `credit_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_payments` (
  `customerNumber` int NOT NULL,
  `paymentTimestamp` datetime NOT NULL,
  `postingDate` date DEFAULT NULL,
  `paymentReferenceNo` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customerNumber`,`paymentTimestamp`),
  KEY `FK-50_001_idx` (`paymentReferenceNo`),
  CONSTRAINT `FK-50_001` FOREIGN KEY (`paymentReferenceNo`) REFERENCES `ref_paymentreferenceno` (`referenceNo`),
  CONSTRAINT `FK-50_002` FOREIGN KEY (`customerNumber`, `paymentTimestamp`) REFERENCES `payments` (`customerNumber`, `paymentTimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_payments`
--

LOCK TABLES `credit_payments` WRITE;
/*!40000 ALTER TABLE `credit_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `credit_payments_BEFORE_INSERT` BEFORE INSERT ON `credit_payments` FOR EACH ROW BEGIN
	SET new.paymentTimestamp := now();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `credit_payments_AFTER_INSERT` AFTER INSERT ON `credit_payments` FOR EACH ROW BEGIN
	INSERT INTO credit_payments_audit VALUES(new.customerNumber, new.paymentTimestamp, now(), 'C', NULL, NULL, new.postingDate, new.paymentReferenceNo, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `credit_payments_AFTER_UPDATE` AFTER UPDATE ON `credit_payments` FOR EACH ROW BEGIN
	IF (old.customerNumber <> new.customerNumber OR old.paymentTimestamp <> new.paymentTimestamp) THEN
		SIGNAL  SQLSTATE  '45000' SET MESSAGE_TEXT = 'customerNumber or paymentTimestamp cannot be modified';
	END IF;
	INSERT INTO credit_payments_audit VALUES(new.customerNumber, new.paymentTimestamp, now(), 'U', old.postingDate, old.paymentReferenceNo, new.postingDate, new.paymentReferenceNo, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `credit_payments_BEFORE_DELETE` BEFORE DELETE ON `credit_payments` FOR EACH ROW BEGIN
	INSERT INTO credit_payments_audit VALUES(old.customerNumber, old.paymentTimestamp, now(), 'D', old.postingDate, old.paymentReferenceNo, NULL, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `credit_payments_audit`
--

DROP TABLE IF EXISTS `credit_payments_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_payments_audit` (
  `customerNumber` int NOT NULL,
  `paymentTimestamp` datetime NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_postingDate` date DEFAULT NULL,
  `old_paymentReferenceNo` int DEFAULT NULL,
  `new_postingDate` date DEFAULT NULL,
  `new_paymentReferenceNo` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customerNumber`,`paymentTimestamp`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_payments_audit`
--

LOCK TABLES `credit_payments_audit` WRITE;
/*!40000 ALTER TABLE `credit_payments_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_payments_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `current_products`
--

DROP TABLE IF EXISTS `current_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `current_products` (
  `productCode` varchar(15) NOT NULL,
  `product_type` enum('R','W') DEFAULT NULL,
  `quantityInStock` smallint DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`),
  CONSTRAINT `FK90_001` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `current_products`
--

LOCK TABLES `current_products` WRITE;
/*!40000 ALTER TABLE `current_products` DISABLE KEYS */;
INSERT INTO `current_products` VALUES ('100009','R',1000,'test4ba','test4ba'),('100010','W',1000,'test4ba','test4ba'),('S10_1678','W',8933,'System','Order Cancelled'),('S10_1949','W',9079,'System','Order Cancelled'),('S10_2016','W',9001,NULL,NULL),('S10_4698','W',9015,NULL,NULL),('S10_4757','W',8970,NULL,NULL),('S10_4962','W',9075,NULL,NULL),('S12_1099','W',9045,NULL,NULL),('S12_1108','W',8959,NULL,NULL),('S12_1666','W',9077,NULL,NULL),('S12_2823','W',8941,NULL,NULL),('S12_3148','W',8953,NULL,NULL),('S12_3380','W',8988,NULL,NULL),('S12_3891','W',8953,NULL,NULL),('S12_3990','W',9076,NULL,NULL),('S12_4473','W',8955,NULL,NULL),('S12_4675','W',8986,NULL,NULL),('S18_1097','W',9055,NULL,NULL),('S18_1129','W',9029,NULL,NULL),('S18_1342','W',8909,NULL,NULL),('S18_1367','W',9034,NULL,NULL),('S18_1589','W',9062,NULL,NULL),('S18_1662','W',8938,NULL,NULL),('S18_1749','W',9068,NULL,NULL),('S18_1889','W',9028,NULL,NULL),('S18_1984','W',9083,NULL,NULL),('S18_2238','W',9042,NULL,NULL),('S18_2248','W',9182,NULL,NULL),('S18_2319','W',8985,NULL,NULL),('S18_2325','W',9088,NULL,NULL),('S18_2432','W',9021,NULL,NULL),('S18_2581','W',9083,NULL,NULL),('S18_2625','W',9055,NULL,NULL),('S18_2795','W',9155,NULL,NULL),('S18_2870','W',9145,NULL,NULL),('S18_2949','W',8972,NULL,NULL),('S18_2957','W',9046,NULL,NULL),('S18_3029','W',9034,NULL,NULL),('S18_3136','W',9114,NULL,NULL),('S18_3140','W',9117,NULL,NULL),('S18_3232','W',8220,NULL,NULL),('S18_3233','W',10000,NULL,NULL),('S18_3259','W',9082,NULL,NULL),('S18_3278','W',9026,NULL,NULL),('S18_3320','W',9029,NULL,NULL),('S18_3482','W',9085,NULL,NULL),('S18_3685','W',9052,NULL,NULL),('S18_3782','W',9041,NULL,NULL),('S18_3856','W',8924,NULL,NULL),('S18_4027','W',9055,NULL,NULL),('S18_4409','W',9200,NULL,NULL),('S18_4522','W',9010,NULL,NULL),('S18_4600','W',8977,NULL,NULL),('S18_4668','W',9031,NULL,NULL),('S18_4721','W',8987,NULL,NULL),('S18_4933','W',9269,NULL,NULL),('S24_1046','W',9257,NULL,NULL),('S24_1444','W',9059,NULL,NULL),('S24_1578','W',8967,NULL,NULL),('S24_1628','W',9122,NULL,NULL),('S24_1785','W',9028,NULL,NULL),('S24_1937','W',9108,NULL,NULL),('S24_2000','W',8985,NULL,NULL),('S24_2011','W',8989,NULL,NULL),('S24_2022','W',9085,NULL,NULL),('S24_2300','W',9020,NULL,NULL),('S24_2360','W',9053,NULL,NULL),('S24_2766','W',9090,NULL,NULL),('S24_2840','W',9048,NULL,NULL),('S24_2841','W',9060,NULL,NULL),('S24_2887','W',9182,NULL,NULL),('S24_2972','W',9088,NULL,NULL),('S24_3151','W',9009,NULL,NULL),('S24_3191','W',9165,NULL,NULL),('S24_3371','W',9031,NULL,NULL),('S24_3420','W',9116,NULL,NULL),('S24_3432','W',9132,NULL,NULL),('S24_3816','W',9075,NULL,NULL),('S24_3856','W',8948,NULL,NULL),('S24_3949','W',8949,NULL,NULL),('S24_3969','W',9167,NULL,NULL),('S24_4048','W',9133,NULL,NULL),('S24_4258','W',9045,NULL,NULL),('S24_4278','W',8991,NULL,NULL),('S24_4620','W',9059,NULL,NULL),('S32_1268','W',9130,NULL,NULL),('S32_1374','W',8986,NULL,NULL),('S32_2206','W',9094,NULL,NULL),('S32_2509','W',9056,NULL,NULL),('S32_3207','W',9066,NULL,NULL),('S32_3522','W',9056,NULL,NULL),('S32_4289','W',9028,NULL,NULL),('S32_4485','W',9099,NULL,NULL),('S50_1341','W',8926,NULL,NULL),('S50_1392','W',9011,'System','Order Cancelled'),('S50_1514','W',9034,NULL,NULL),('S50_4713','W',9008,NULL,NULL),('S700_1138','W',9066,NULL,NULL),('S700_1691','W',9106,NULL,NULL),('S700_1938','W',9102,NULL,NULL),('S700_2047','W',9103,NULL,NULL),('S700_2466','W',9016,NULL,NULL),('S700_2610','W',8980,NULL,NULL),('S700_2824','W',9049,NULL,NULL),('S700_2834','W',9027,NULL,NULL),('S700_3167','R',8915,NULL,NULL),('S700_3505','R',9048,NULL,NULL),('S700_3962','R',9104,NULL,NULL),('XX00001','R',10000,NULL,NULL),('XX00002','R',10000,NULL,NULL),('XX00004','R',2000,'mark@toys.com','new product'),('XX00005','R',200,'mark1@toys.com','Add new product'),('XX00006','R',160,'mark1@toys.com','Add new product'),('XX00007','W',2000,'mike1@toys.com','new product'),('XX00008','W',1990,'mike1@toys.com','new product');
/*!40000 ALTER TABLE `current_products` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `current_products_BEFORE_INSERT` BEFORE INSERT ON `current_products` FOR EACH ROW BEGIN
	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `current_products_AFTER_INSERT` AFTER INSERT ON `current_products` FOR EACH ROW BEGIN
	
	INSERT INTO current_products_audit VALUES(new.productCode, now(), 'C', NULL, NULL, new.product_type, new.quantityInStock, new.end_username,  new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `current_products_BEFORE_UPDATE` BEFORE UPDATE ON `current_products` FOR EACH ROW BEGIN
	IF (old.productCode <> new.productCode) THEN
		SIGNAL  SQLSTATE  '45000' SET MESSAGE_TEXT = 'ERROR 80C2: productCode cannot be modified';
	END IF;
    
	IF new.product_type <> old.product_type THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERROR 80C1: Product type cannot be modified';
    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `current_products_AFTER_UPDATE` AFTER UPDATE ON `current_products` FOR EACH ROW BEGIN
	INSERT INTO current_products_audit VALUES(new.productCode, now(), 'U', old.product_type, old.quantityInStock, new.product_type, new.quantityInStock, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `current_products_BEFORE_DELETE` BEFORE DELETE ON `current_products` FOR EACH ROW BEGIN
	INSERT INTO current_products_audit VALUES(old.productCode, now(), 'D', old.product_type, old.quantityInStock, NULL, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `current_products_audit`
--

DROP TABLE IF EXISTS `current_products_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `current_products_audit` (
  `productCode` varchar(15) NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_product_type` enum('R','W') DEFAULT NULL,
  `old_quantityInStock` smallint DEFAULT NULL,
  `new_product_type` enum('R','W') DEFAULT NULL,
  `new_quantityInStock` smallint DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `current_products_audit`
--

LOCK TABLES `current_products_audit` WRITE;
/*!40000 ALTER TABLE `current_products_audit` DISABLE KEYS */;
INSERT INTO `current_products_audit` VALUES ('100009','2024-07-20 03:43:22','C',NULL,NULL,'R',1000,'test4ba','test4ba'),('100010','2024-07-20 03:43:22','C',NULL,NULL,'W',1000,'test4ba','test4ba'),('S10_1678','2024-07-20 03:43:22','C',NULL,NULL,'W',8933,'System','Order Cancelled'),('S10_1949','2024-07-20 03:43:22','C',NULL,NULL,'W',9079,'System','Order Cancelled'),('S10_2016','2024-07-20 03:43:22','C',NULL,NULL,'W',9001,NULL,NULL),('S10_4698','2024-07-20 03:43:22','C',NULL,NULL,'W',9015,NULL,NULL),('S10_4757','2024-07-20 03:43:22','C',NULL,NULL,'W',8970,NULL,NULL),('S10_4962','2024-07-20 03:43:22','C',NULL,NULL,'W',9075,NULL,NULL),('S12_1099','2024-07-20 03:43:22','C',NULL,NULL,'W',9045,NULL,NULL),('S12_1108','2024-07-20 03:43:22','C',NULL,NULL,'W',8959,NULL,NULL),('S12_1666','2024-07-20 03:43:22','C',NULL,NULL,'W',9077,NULL,NULL),('S12_2823','2024-07-20 03:43:22','C',NULL,NULL,'W',8941,NULL,NULL),('S12_3148','2024-07-20 03:43:22','C',NULL,NULL,'W',8953,NULL,NULL),('S12_3380','2024-07-20 03:43:22','C',NULL,NULL,'W',8988,NULL,NULL),('S12_3891','2024-07-20 03:43:22','C',NULL,NULL,'W',8953,NULL,NULL),('S12_3990','2024-07-20 03:43:22','C',NULL,NULL,'W',9076,NULL,NULL),('S12_4473','2024-07-20 03:43:22','C',NULL,NULL,'W',8955,NULL,NULL),('S12_4675','2024-07-20 03:43:22','C',NULL,NULL,'W',8986,NULL,NULL),('S18_1097','2024-07-20 03:43:22','C',NULL,NULL,'W',9055,NULL,NULL),('S18_1129','2024-07-20 03:43:22','C',NULL,NULL,'W',9029,NULL,NULL),('S18_1342','2024-07-20 03:43:22','C',NULL,NULL,'W',8909,NULL,NULL),('S18_1367','2024-07-20 03:43:22','C',NULL,NULL,'W',9034,NULL,NULL),('S18_1589','2024-07-20 03:43:22','C',NULL,NULL,'W',9062,NULL,NULL),('S18_1662','2024-07-20 03:43:22','C',NULL,NULL,'W',8938,NULL,NULL),('S18_1749','2024-07-20 03:43:22','C',NULL,NULL,'W',9068,NULL,NULL),('S18_1889','2024-07-20 03:43:22','C',NULL,NULL,'W',9028,NULL,NULL),('S18_1984','2024-07-20 03:43:22','C',NULL,NULL,'W',9083,NULL,NULL),('S18_2238','2024-07-20 03:43:22','C',NULL,NULL,'W',9042,NULL,NULL),('S18_2248','2024-07-20 03:43:22','C',NULL,NULL,'W',9182,NULL,NULL),('S18_2319','2024-07-20 03:43:22','C',NULL,NULL,'W',8985,NULL,NULL),('S18_2325','2024-07-20 03:43:22','C',NULL,NULL,'W',9088,NULL,NULL),('S18_2432','2024-07-20 03:43:22','C',NULL,NULL,'W',9021,NULL,NULL),('S18_2581','2024-07-20 03:43:22','C',NULL,NULL,'W',9083,NULL,NULL),('S18_2625','2024-07-20 03:43:22','C',NULL,NULL,'W',9055,NULL,NULL),('S18_2795','2024-07-20 03:43:22','C',NULL,NULL,'W',9155,NULL,NULL),('S18_2870','2024-07-20 03:43:22','C',NULL,NULL,'W',9145,NULL,NULL),('S18_2949','2024-07-20 03:43:22','C',NULL,NULL,'W',8972,NULL,NULL),('S18_2957','2024-07-20 03:43:22','C',NULL,NULL,'W',9046,NULL,NULL),('S18_3029','2024-07-20 03:43:22','C',NULL,NULL,'W',9034,NULL,NULL),('S18_3136','2024-07-20 03:43:22','C',NULL,NULL,'W',9114,NULL,NULL),('S18_3140','2024-07-20 03:43:22','C',NULL,NULL,'W',9117,NULL,NULL),('S18_3232','2024-07-20 03:43:22','C',NULL,NULL,'W',8220,NULL,NULL),('S18_3233','2024-07-20 03:43:22','C',NULL,NULL,'W',10000,NULL,NULL),('S18_3259','2024-07-20 03:43:22','C',NULL,NULL,'W',9082,NULL,NULL),('S18_3278','2024-07-20 03:43:22','C',NULL,NULL,'W',9026,NULL,NULL),('S18_3320','2024-07-20 03:43:22','C',NULL,NULL,'W',9029,NULL,NULL),('S18_3482','2024-07-20 03:43:22','C',NULL,NULL,'W',9085,NULL,NULL),('S18_3685','2024-07-20 03:43:22','C',NULL,NULL,'W',9052,NULL,NULL),('S18_3782','2024-07-20 03:43:22','C',NULL,NULL,'W',9041,NULL,NULL),('S18_3856','2024-07-20 03:43:22','C',NULL,NULL,'W',8924,NULL,NULL),('S18_4027','2024-07-20 03:43:22','C',NULL,NULL,'W',9055,NULL,NULL),('S18_4409','2024-07-20 03:43:22','C',NULL,NULL,'W',9200,NULL,NULL),('S18_4522','2024-07-20 03:43:22','C',NULL,NULL,'W',9010,NULL,NULL),('S18_4600','2024-07-20 03:43:22','C',NULL,NULL,'W',8977,NULL,NULL),('S18_4668','2024-07-20 03:43:22','C',NULL,NULL,'W',9031,NULL,NULL),('S18_4721','2024-07-20 03:43:22','C',NULL,NULL,'W',8987,NULL,NULL),('S18_4933','2024-07-20 03:43:22','C',NULL,NULL,'W',9269,NULL,NULL),('S24_1046','2024-07-20 03:43:22','C',NULL,NULL,'W',9257,NULL,NULL),('S24_1444','2024-07-20 03:43:22','C',NULL,NULL,'W',9059,NULL,NULL),('S24_1578','2024-07-20 03:43:22','C',NULL,NULL,'W',8967,NULL,NULL),('S24_1628','2024-07-20 03:43:22','C',NULL,NULL,'W',9122,NULL,NULL),('S24_1785','2024-07-20 03:43:22','C',NULL,NULL,'W',9028,NULL,NULL),('S24_1937','2024-07-20 03:43:22','C',NULL,NULL,'W',9108,NULL,NULL),('S24_2000','2024-07-20 03:43:22','C',NULL,NULL,'W',8985,NULL,NULL),('S24_2011','2024-07-20 03:43:22','C',NULL,NULL,'W',8989,NULL,NULL),('S24_2022','2024-07-20 03:43:22','C',NULL,NULL,'W',9085,NULL,NULL),('S24_2300','2024-07-20 03:43:22','C',NULL,NULL,'W',9020,NULL,NULL),('S24_2360','2024-07-20 03:43:22','C',NULL,NULL,'W',9053,NULL,NULL),('S24_2766','2024-07-20 03:43:22','C',NULL,NULL,'W',9090,NULL,NULL),('S24_2840','2024-07-20 03:43:22','C',NULL,NULL,'W',9048,NULL,NULL),('S24_2841','2024-07-20 03:43:22','C',NULL,NULL,'W',9060,NULL,NULL),('S24_2887','2024-07-20 03:43:22','C',NULL,NULL,'W',9182,NULL,NULL),('S24_2972','2024-07-20 03:43:22','C',NULL,NULL,'W',9088,NULL,NULL),('S24_3151','2024-07-20 03:43:22','C',NULL,NULL,'W',9009,NULL,NULL),('S24_3191','2024-07-20 03:43:22','C',NULL,NULL,'W',9165,NULL,NULL),('S24_3371','2024-07-20 03:43:22','C',NULL,NULL,'W',9031,NULL,NULL),('S24_3420','2024-07-20 03:43:22','C',NULL,NULL,'W',9116,NULL,NULL),('S24_3432','2024-07-20 03:43:22','C',NULL,NULL,'W',9132,NULL,NULL),('S24_3816','2024-07-20 03:43:22','C',NULL,NULL,'W',9075,NULL,NULL),('S24_3856','2024-07-20 03:43:22','C',NULL,NULL,'W',8948,NULL,NULL),('S24_3949','2024-07-20 03:43:22','C',NULL,NULL,'W',8949,NULL,NULL),('S24_3969','2024-07-20 03:43:22','C',NULL,NULL,'W',9167,NULL,NULL),('S24_4048','2024-07-20 03:43:22','C',NULL,NULL,'W',9133,NULL,NULL),('S24_4258','2024-07-20 03:43:22','C',NULL,NULL,'W',9045,NULL,NULL),('S24_4278','2024-07-20 03:43:22','C',NULL,NULL,'W',8991,NULL,NULL),('S24_4620','2024-07-20 03:43:22','C',NULL,NULL,'W',9059,NULL,NULL),('S32_1268','2024-07-20 03:43:22','C',NULL,NULL,'W',9130,NULL,NULL),('S32_1374','2024-07-20 03:43:22','C',NULL,NULL,'W',8986,NULL,NULL),('S32_2206','2024-07-20 03:43:22','C',NULL,NULL,'W',9094,NULL,NULL),('S32_2509','2024-07-20 03:43:22','C',NULL,NULL,'W',9056,NULL,NULL),('S32_3207','2024-07-20 03:43:22','C',NULL,NULL,'W',9066,NULL,NULL),('S32_3522','2024-07-20 03:43:22','C',NULL,NULL,'W',9056,NULL,NULL),('S32_4289','2024-07-20 03:43:22','C',NULL,NULL,'W',9028,NULL,NULL),('S32_4485','2024-07-20 03:43:22','C',NULL,NULL,'W',9099,NULL,NULL),('S50_1341','2024-07-20 03:43:22','C',NULL,NULL,'W',8926,NULL,NULL),('S50_1392','2024-07-20 03:43:22','C',NULL,NULL,'W',9011,'System','Order Cancelled'),('S50_1514','2024-07-20 03:43:22','C',NULL,NULL,'W',9034,NULL,NULL),('S50_4713','2024-07-20 03:43:22','C',NULL,NULL,'W',9008,NULL,NULL),('S700_1138','2024-07-20 03:43:22','C',NULL,NULL,'W',9066,NULL,NULL),('S700_1691','2024-07-20 03:43:22','C',NULL,NULL,'W',9106,NULL,NULL),('S700_1938','2024-07-20 03:43:22','C',NULL,NULL,'W',9102,NULL,NULL),('S700_2047','2024-07-20 03:43:22','C',NULL,NULL,'W',9103,NULL,NULL),('S700_2466','2024-07-20 03:43:22','C',NULL,NULL,'W',9016,NULL,NULL),('S700_2610','2024-07-20 03:43:22','C',NULL,NULL,'W',8980,NULL,NULL),('S700_2824','2024-07-20 03:43:22','C',NULL,NULL,'W',9049,NULL,NULL),('S700_2834','2024-07-20 03:43:22','C',NULL,NULL,'W',9027,NULL,NULL),('S700_3167','2024-07-20 03:43:22','C',NULL,NULL,'R',8915,NULL,NULL),('S700_3505','2024-07-20 03:43:22','C',NULL,NULL,'R',9048,NULL,NULL),('S700_3962','2024-07-20 03:43:22','C',NULL,NULL,'R',9104,NULL,NULL),('XX00001','2024-07-20 03:43:22','C',NULL,NULL,'R',10000,NULL,NULL),('XX00002','2024-07-20 03:43:22','C',NULL,NULL,'R',10000,NULL,NULL),('XX00004','2024-07-20 03:43:22','C',NULL,NULL,'R',2000,'mark@toys.com','new product'),('XX00005','2024-07-20 03:43:22','C',NULL,NULL,'R',200,'mark1@toys.com','Add new product'),('XX00006','2024-07-20 03:43:22','C',NULL,NULL,'R',160,'mark1@toys.com','Add new product'),('XX00007','2024-07-20 03:43:22','C',NULL,NULL,'W',2000,'mike1@toys.com','new product'),('XX00008','2024-07-20 03:43:22','C',NULL,NULL,'W',1990,'mike1@toys.com','new product');
/*!40000 ALTER TABLE `current_products_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `customer_credit_data`
--

DROP TABLE IF EXISTS `customer_credit_data`;
/*!50001 DROP VIEW IF EXISTS `customer_credit_data`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customer_credit_data` AS SELECT 
 1 AS `customerNumber`,
 1 AS `totalOrders`,
 1 AS `orderCount`,
 1 AS `maxOrder`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customerNumber` int NOT NULL,
  `customerName` varchar(50) NOT NULL,
  `contactLastName` varchar(50) NOT NULL,
  `contactFirstName` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postalCode` varchar(15) DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `salesRepEmployeeNumber` int DEFAULT NULL,
  `creditLimit` double DEFAULT NULL,
  `officeCode` varchar(10) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customerNumber`),
  KEY `FK88_901_idx` (`salesRepEmployeeNumber`),
  KEY `FK99_9993_idx` (`salesRepEmployeeNumber`,`officeCode`,`startDate`),
  CONSTRAINT `FK99_9993` FOREIGN KEY (`salesRepEmployeeNumber`, `officeCode`, `startDate`) REFERENCES `salesrepassignments` (`employeeNumber`, `officeCode`, `startDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (20241001,'Atelier graphique','Schmitt','Carine ','40.32.2555','54, rue Royale',NULL,'Nantes',NULL,'44000','France',1370,0,'4','2003-01-01',NULL,NULL),(20241002,'Signal Gift Stores','King','Jean','7025551838','8489 Strong St.',NULL,'Las Vegas','NV','83030','USA',1166,0,'1','2003-01-01',NULL,NULL),(20241003,'Australian Collectors, Co.','Ferguson','Peter','03 9520 4555','636 St Kilda Road','Level 3','Melbourne','Victoria','3004','Australia',1611,0,'6','2003-01-01',NULL,NULL),(20241004,'La Rochelle Gifts','Labrune','Janine ','40.67.8555','67, rue des Cinquante Otages',NULL,'Nantes',NULL,'44000','France',1370,0,'4','2003-01-01',NULL,NULL),(20241005,'Baane Mini Imports','Bergulfsen','Jonas ','07-98 9555','Erling Skakkes gate 78',NULL,'Stavern',NULL,'4110','Norway',1504,0,'7','2003-01-01',NULL,NULL),(20241006,'Mini Gifts Distributors Ltd.','Nelson','Susan','4155551450','5677 Strong St.',NULL,'San Rafael','CA','97562','USA',1165,0,'1','2003-01-01',NULL,NULL),(20241007,'Havel & Zbyszek Co','Piestrzeniewicz','Zbyszek ','(26) 642-7555','ul. Filtrowa 68',NULL,'Warszawa',NULL,'01-012','Poland',NULL,0,NULL,NULL,NULL,NULL),(20241008,'Blauer See Auto, Co.','Keitel','Roland','+49 69 66 90 2555','Lyonerstr. 34',NULL,'Frankfurt',NULL,'60528','Germany',1504,0,'7','2003-01-01',NULL,NULL),(20241009,'Mini Wheels Co.','Murphy','Julie','6505555787','5557 North Pendale Street',NULL,'San Francisco','CA','94217','USA',1165,0,'1','2003-01-01',NULL,NULL),(20241010,'Land of Toys Inc.','Lee','Kwai','2125557818','897 Long Airport Avenue',NULL,'NYC','NY','10022','USA',1323,0,'3','2003-01-01',NULL,NULL),(20241011,'Euro+ Shopping Channel','Freyre','Diego ','(91) 555 94 44','C/ Moralzarzal, 86',NULL,'Madrid',NULL,'28034','Spain',1370,0,'4','2003-01-01',NULL,NULL),(20241012,'Volvo Model Replicas, Co','Berglund','Christina ','0921-12 3555','Berguvsvägen  8',NULL,'Luleå',NULL,'S-958 22','Sweden',1504,0,'7','2003-01-01',NULL,NULL),(20241013,'Danish Wholesale Imports','Petersen','Jytte ','31 12 3555','Vinbæltet 34',NULL,'Kobenhavn',NULL,'1734','Denmark',1401,0,'4','2003-01-01',NULL,NULL),(20241014,'Saveley & Henriot, Co.','Saveley','Mary ','78.32.5555','2, rue du Commerce',NULL,'Lyon',NULL,'69004','France',1337,0,'4','2003-01-01',NULL,NULL),(20241015,'Dragon Souveniers, Ltd.','Natividad','Eric','+65 221 7555','Bronz Sok.','Bronz Apt. 3/6 Tesvikiye','Singapore',NULL,'079903','Singapore',1621,0,'5','2003-01-01',NULL,NULL),(20241016,'Muscle Machine Inc','Young','Jeff','2125557413','4092 Furth Circle','Suite 400','NYC','NY','10022','USA',1286,0,'3','2003-01-01',NULL,NULL),(20241017,'Diecast Classics Inc.','Leong','Kelvin','2155551555','7586 Pompton St.',NULL,'Allentown','PA','70267','USA',1216,0,'2','2003-01-01',NULL,NULL),(20241018,'Technics Stores Inc.','Hashimoto','Juri','6505556809','9408 Furth Circle',NULL,'Burlingame','CA','94217','USA',1165,0,'1','2003-01-01',NULL,NULL),(20241019,'Handji Gifts& Co','Victorino','Wendy','+65 224 1555','106 Linden Road Sandown','2nd Floor','Singapore',NULL,'069045','Singapore',1612,0,'6','2003-01-01',NULL,NULL),(20241020,'Herkku Gifts','Oeztan','Veysel','+47 2267 3215','Brehmen St. 121','PR 334 Sentrum','Bergen',NULL,'N 5804','Norway  ',1504,0,'7','2003-01-01',NULL,NULL),(20241021,'American Souvenirs Inc','Franco','Keith','2035557845','149 Spinnaker Dr.','Suite 101','New Haven','CT','97823','USA',1286,0,'3','2003-01-01',NULL,NULL),(20241022,'Porto Imports Co.','de Castro','Isabel ','(1) 356-5555','Estrada da saúde n. 58',NULL,'Lisboa',NULL,'1756','Portugal',NULL,0,NULL,NULL,NULL,NULL),(20241023,'Daedalus Designs Imports','Rancé','Martine ','20.16.1555','184, chaussée de Tournai',NULL,'Lille',NULL,'59000','France',1370,0,'4','2003-01-01',NULL,NULL),(20241024,'La Corne D\'abondance, Co.','Bertrand','Marie','(1) 42.34.2555','265, boulevard Charonne',NULL,'Paris',NULL,'75012','France',1337,0,'4','2003-01-01',NULL,NULL),(20241025,'Cambridge Collectables Co.','Tseng','Jerry','6175555555','4658 Baden Av.',NULL,'Cambridge','MA','51247','USA',1188,0,'2','2003-01-01',NULL,NULL),(20241026,'Gift Depot Inc.','King','Julie','2035552570','25593 South Bay Ln.',NULL,'Bridgewater','CT','97562','USA',1323,0,'3','2003-01-01',NULL,NULL),(20241027,'Osaka Souveniers Co.','Kentary','Mory','+81 06 6342 5555','1-6-20 Dojima',NULL,'Kita-ku','Osaka',' 530-0003','Japan',1621,0,'5','2003-01-01',NULL,NULL),(20241028,'Vitachrome Inc.','Frick','Michael','2125551500','2678 Kingston Rd.','Suite 101','NYC','NY','10022','USA',1286,0,'3','2003-01-01',NULL,NULL),(20241029,'Toys of Finland, Co.','Karttunen','Matti','90-224 8555','Keskuskatu 45',NULL,'Helsinki',NULL,'21240','Finland',1501,0,'7','2003-01-01',NULL,NULL),(20241030,'AV Stores, Co.','Ashworth','Rachel','(171) 555-1555','Fauntleroy Circus',NULL,'Manchester',NULL,'EC2 5NT','UK',1501,0,'7','2003-01-01',NULL,NULL),(20241031,'Clover Collections, Co.','Cassidy','Dean','+353 1862 1555','25 Maiden Lane','Floor No. 4','Dublin',NULL,'2','Ireland',1504,0,'7','2003-01-01',NULL,NULL),(20241032,'Auto-Moto Classics Inc.','Taylor','Leslie','6175558428','16780 Pompton St.',NULL,'Brickhaven','MA','58339','USA',1216,0,'2','2003-01-01',NULL,NULL),(20241033,'UK Collectables, Ltd.','Devon','Elizabeth','(171) 555-2282','12, Berkeley Gardens Blvd',NULL,'Liverpool',NULL,'WX1 6LT','UK',1501,0,'7','2003-01-01',NULL,NULL),(20241034,'Canadian Gift Exchange Network','Tamuri','Yoshi ','(604) 555-3392','1900 Oak St.',NULL,'Vancouver','BC','V3F 2K1','Canada',1323,0,'3','2003-01-01',NULL,NULL),(20241035,'Online Mini Collectables','Barajas','Miguel','6175557555','7635 Spinnaker Dr.',NULL,'Brickhaven','MA','58339','USA',1188,0,'2','2003-01-01',NULL,NULL),(20241036,'Toys4GrownUps.com','Young','Julie','6265557265','78934 Hillside Dr.',NULL,'Pasadena','CA','90003','USA',1166,0,'1','2003-01-01',NULL,NULL),(20241037,'Asian Shopping Network, Co','Walker','Brydey','+612 9411 1555','Suntec Tower Three','8 Temasek','Singapore',NULL,'038988','Singapore',NULL,0,NULL,NULL,NULL,NULL),(20241038,'Mini Caravy','Citeaux','Frédérique ','88.60.1555','24, place Kléber',NULL,'Strasbourg',NULL,'67000','France',1370,0,'4','2003-01-01',NULL,NULL),(20241039,'King Kong Collectables, Co.','Gao','Mike','+852 2251 1555','Bank of China Tower','1 Garden Road','Central Hong Kong',NULL,NULL,'Hong Kong',1621,0,'5','2003-01-01',NULL,NULL),(20241040,'Enaco Distributors','Saavedra','Eduardo ','(93) 203 4555','Rambla de Cataluña, 23',NULL,'Barcelona',NULL,'08022','Spain',1702,0,'4','2003-01-01',NULL,NULL),(20241041,'Boards & Toys Co.','Young','Mary','3105552373','4097 Douglas Av.',NULL,'Glendale','CA','92561','USA',1166,0,'1','2003-01-01',NULL,NULL),(20241042,'Natürlich Autos','Kloss','Horst ','0372-555188','Taucherstraße 10',NULL,'Cunewalde',NULL,'01307','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241043,'Heintze Collectables','Ibsen','Palle','86 21 3555','Smagsloget 45',NULL,'Århus',NULL,'8200','Denmark',1401,0,'4','2003-01-01',NULL,NULL),(20241044,'Québec Home Shopping Network','Fresnière','Jean ','(514) 555-8054','43 rue St. Laurent',NULL,'Montréal','Québec','H1J 1C3','Canada',1286,0,'3','2003-01-01',NULL,NULL),(20241045,'ANG Resellers','Camino','Alejandra ','(91) 745 6555','Gran Vía, 1',NULL,'Madrid',NULL,'28001','Spain',NULL,0,NULL,NULL,NULL,NULL),(20241046,'Collectable Mini Designs Co.','Thompson','Valarie','7605558146','361 Furth Circle',NULL,'San Diego','CA','91217','USA',1166,0,'1','2003-01-01',NULL,NULL),(20241047,'giftsbymail.co.uk','Bennett','Helen ','(198) 555-8888','Garden House','Crowther Way 23','Cowes','Isle of Wight','PO31 7PJ','UK',1501,0,'7','2003-01-01',NULL,NULL),(20241048,'Alpha Cognac','Roulet','Annette ','61.77.6555','1 rue Alsace-Lorraine',NULL,'Toulouse',NULL,'31000','France',1370,0,'4','2003-01-01',NULL,NULL),(20241049,'Messner Shopping Network','Messner','Renate ','069-0555984','Magazinweg 7',NULL,'Frankfurt',NULL,'60528','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241050,'Amica Models & Co.','Accorti','Paolo ','011-4988555','Via Monte Bianco 34',NULL,'Torino',NULL,'10100','Italy',1401,0,'4','2003-01-01',NULL,NULL),(20241051,'Lyon Souveniers','Da Silva','Daniel','+33 1 46 62 7555','27 rue du Colonel Pierre Avia',NULL,'Paris',NULL,'75508','France',1337,0,'4','2003-01-01',NULL,NULL),(20241052,'Auto Associés & Cie.','Tonini','Daniel ','30.59.8555','67, avenue de l\'Europe',NULL,'Versailles',NULL,'78000','France',1370,0,'4','2003-01-01',NULL,NULL),(20241053,'Toms Spezialitäten, Ltd','Pfalzheim','Henriette ','0221-5554327','Mehrheimerstr. 369',NULL,'Köln',NULL,'50739','Germany',1504,0,'7','2003-01-01',NULL,NULL),(20241054,'Royal Canadian Collectables, Ltd.','Lincoln','Elizabeth ','(604) 555-4555','23 Tsawassen Blvd.',NULL,'Tsawassen','BC','T2F 8M4','Canada',1323,0,'3','2003-01-01',NULL,NULL),(20241055,'Franken Gifts, Co','Franken','Peter ','089-0877555','Berliner Platz 43',NULL,'München',NULL,'80805','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241056,'Anna\'s Decorations, Ltd','O\'Hara','Anna','02 9936 8555','201 Miller Street','Level 15','North Sydney','NSW','2060','Australia',1611,0,'6','2003-01-01',NULL,NULL),(20241057,'Rovelli Gifts','Rovelli','Giovanni ','035-640555','Via Ludovico il Moro 22',NULL,'Bergamo',NULL,'24100','Italy',1401,0,'4','2003-01-01',NULL,NULL),(20241058,'Souveniers And Things Co.','Huxley','Adrian','+61 2 9495 8555','Monitor Money Building','815 Pacific Hwy','Chatswood','NSW','2067','Australia',1611,0,'6','2003-01-01',NULL,NULL),(20241059,'Marta\'s Replicas Co.','Hernandez','Marta','6175558555','39323 Spinnaker Dr.',NULL,'Cambridge','MA','51247','USA',1216,0,'2','2003-01-01',NULL,NULL),(20241060,'BG&E Collectables','Harrison','Ed','+41 26 425 50 01','Rte des Arsenaux 41 ',NULL,'Fribourg',NULL,'1700','Switzerland',NULL,0,NULL,NULL,NULL,NULL),(20241061,'Vida Sport, Ltd','Holz','Mihael','0897-034555','Grenzacherweg 237',NULL,'Genève',NULL,'1203','Switzerland',1702,0,'4','2003-01-01',NULL,NULL),(20241062,'Norway Gifts By Mail, Co.','Klaeboe','Jan','+47 2212 1555','Drammensveien 126A','PB 211 Sentrum','Oslo',NULL,'N 0106','Norway  ',1504,0,'7','2003-01-01',NULL,NULL),(20241063,'Schuyler Imports','Schuyler','Bradley','+31 20 491 9555','Kingsfordweg 151',NULL,'Amsterdam',NULL,'1043 GR','Netherlands',NULL,0,NULL,NULL,NULL,NULL),(20241064,'Der Hund Imports','Andersen','Mel','030-0074555','Obere Str. 57',NULL,'Berlin',NULL,'12209','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241065,'Oulu Toy Supplies, Inc.','Koskitalo','Pirkko','981-443655','Torikatu 38',NULL,'Oulu',NULL,'90110','Finland',1501,0,'7','2003-01-01',NULL,NULL),(20241066,'Petit Auto','Dewey','Catherine ','(02) 5554 67','Rue Joseph-Bens 532',NULL,'Bruxelles',NULL,'B-1180','Belgium',1401,0,'4','2003-01-01',NULL,NULL),(20241067,'Mini Classics','Frick','Steve','9145554562','3758 North Pendale Street',NULL,'White Plains','NY','24067','USA',1323,0,'3','2003-01-01',NULL,NULL),(20241068,'Mini Creations Ltd.','Huang','Wing','5085559555','4575 Hillside Dr.',NULL,'New Bedford','MA','50553','USA',1188,0,'2','2003-01-01',NULL,NULL),(20241069,'Corporate Gift Ideas Co.','Brown','Julie','6505551386','7734 Strong St.',NULL,'San Francisco','CA','94217','USA',1165,0,'1','2003-01-01',NULL,NULL),(20241070,'Down Under Souveniers, Inc','Graham','Mike','+64 9 312 5555','162-164 Grafton Road','Level 2','Auckland  ',NULL,NULL,'New Zealand',1612,0,'6','2003-01-01',NULL,NULL),(20241071,'Stylish Desk Decors, Co.','Brown','Ann ','(171) 555-0297','35 King George',NULL,'London',NULL,'WX3 6FW','UK',1501,0,'7','2003-01-01',NULL,NULL),(20241072,'Tekni Collectables Inc.','Brown','William','2015559350','7476 Moss Rd.',NULL,'Newark','NJ','94019','USA',1323,0,'3','2003-01-01',NULL,NULL),(20241073,'Australian Gift Network, Co','Calaghan','Ben','61-7-3844-6555','31 Duncan St. West End',NULL,'South Brisbane','Queensland','4101','Australia',1611,0,'6','2003-01-01',NULL,NULL),(20241074,'Suominen Souveniers','Suominen','Kalle','+358 9 8045 555','Software Engineering Center','SEC Oy','Espoo',NULL,'FIN-02271','Finland',1501,0,'7','2003-01-01',NULL,NULL),(20241075,'Cramer Spezialitäten, Ltd','Cramer','Philip ','0555-09555','Maubelstr. 90',NULL,'Brandenburg',NULL,'14776','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241076,'Classic Gift Ideas, Inc','Cervantes','Francisca','2155554695','782 First Street',NULL,'Philadelphia','PA','71270','USA',1188,0,'2','2003-01-01',NULL,NULL),(20241077,'CAF Imports','Fernandez','Jesus','+34 913 728 555','Merchants House','27-30 Merchant\'s Quay','Madrid',NULL,'28023','Spain',1702,0,'4','2003-01-01',NULL,NULL),(20241078,'Men \'R\' US Retailers, Ltd.','Chandler','Brian','2155554369','6047 Douglas Av.',NULL,'Los Angeles','CA','91003','USA',1166,0,'1','2003-01-01',NULL,NULL),(20241079,'Asian Treasures, Inc.','McKenna','Patricia ','2967 555','8 Johnstown Road',NULL,'Cork','Co. Cork',NULL,'Ireland',NULL,0,NULL,NULL,NULL,NULL),(20241080,'Marseille Mini Autos','Lebihan','Laurence ','91.24.4555','12, rue des Bouchers',NULL,'Marseille',NULL,'13008','France',1337,0,'4','2003-01-01',NULL,NULL),(20241081,'Reims Collectables','Henriot','Paul ','26.47.1555','59 rue de l\'Abbaye',NULL,'Reims',NULL,'51100','France',1337,0,'4','2003-01-01',NULL,NULL),(20241082,'SAR Distributors, Co','Kuger','Armand','+27 21 550 3555','1250 Pretorius Street',NULL,'Hatfield','Pretoria','0028','South Africa',NULL,0,NULL,NULL,NULL,NULL),(20241083,'GiftsForHim.com','MacKinlay','Wales','64-9-3763555','199 Great North Road',NULL,'Auckland',NULL,NULL,'New Zealand',1612,0,'6','2003-01-01',NULL,NULL),(20241084,'Kommission Auto','Josephs','Karin','0251-555259','Luisenstr. 48',NULL,'Münster',NULL,'44087','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241085,'Gifts4AllAges.com','Yoshido','Juri','6175559555','8616 Spinnaker Dr.',NULL,'Boston','MA','51003','USA',1216,0,'2','2003-01-01',NULL,NULL),(20241086,'Online Diecast Creations Co.','Young','Dorothy','6035558647','2304 Long Airport Avenue',NULL,'Nashua','NH','62005','USA',1216,0,'2','2003-01-01',NULL,NULL),(20241087,'Lisboa Souveniers, Inc','Rodriguez','Lino ','(1) 354-2555','Jardim das rosas n. 32',NULL,'Lisboa',NULL,'1675','Portugal',NULL,0,NULL,NULL,NULL,NULL),(20241088,'Precious Collectables','Urs','Braun','0452-076555','Hauptstr. 29',NULL,'Bern',NULL,'3012','Switzerland',1702,0,'4','2003-01-01',NULL,NULL),(20241089,'Collectables For Less Inc.','Nelson','Allen','6175558555','7825 Douglas Av.',NULL,'Brickhaven','MA','58339','USA',1188,0,'2','2003-01-01',NULL,NULL),(20241090,'Royale Belge','Cartrain','Pascale ','(071) 23 67 2555','Boulevard Tirou, 255',NULL,'Charleroi',NULL,'B-6000','Belgium',1401,0,'4','2003-01-01',NULL,NULL),(20241091,'Salzburg Collectables','Pipps','Georg ','6562-9555','Geislweg 14',NULL,'Salzburg',NULL,'5020','Austria',1401,0,'4','2003-01-01',NULL,NULL),(20241092,'Cruz & Sons Co.','Cruz','Arnold','+63 2 555 3587','15 McCallum Street','NatWest Center #13-03','Makati City',NULL,'1227 MM','Philippines',1621,0,'5','2003-01-01',NULL,NULL),(20241093,'L\'ordine Souveniers','Moroni','Maurizio ','0522-556555','Strada Provinciale 124',NULL,'Reggio Emilia',NULL,'42100','Italy',1401,0,'4','2003-01-01',NULL,NULL),(20241094,'Tokyo Collectables, Ltd','Shimamura','Akiko','+81 3 3584 0555','2-2-8 Roppongi',NULL,'Minato-ku','Tokyo','106-0032','Japan',1621,0,'5','2003-01-01',NULL,NULL),(20241095,'Auto Canal+ Petit','Perrier','Dominique','(1) 47.55.6555','25, rue Lauriston',NULL,'Paris',NULL,'75016','France',1337,0,'4','2003-01-01',NULL,NULL),(20241096,'Stuttgart Collectable Exchange','Müller','Rita ','0711-555361','Adenauerallee 900',NULL,'Stuttgart',NULL,'70563','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241097,'Extreme Desk Decorations, Ltd','McRoy','Sarah','04 499 9555','101 Lambton Quay','Level 11','Wellington',NULL,NULL,'New Zealand',1612,0,'6','2003-01-01',NULL,NULL),(20241098,'Bavarian Collectables Imports, Co.','Donnermeyer','Michael',' +49 89 61 08 9555','Hansastr. 15',NULL,'Munich',NULL,'80686','Germany',1504,0,'7','2003-01-01',NULL,NULL),(20241099,'Classic Legends Inc.','Hernandez','Maria','2125558493','5905 Pompton St.','Suite 750','NYC','NY','10022','USA',1286,0,'3','2003-01-01',NULL,NULL),(20241100,'Feuer Online Stores, Inc','Feuer','Alexander ','0342-555176','Heerstr. 22',NULL,'Leipzig',NULL,'04179','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241101,'Gift Ideas Corp.','Lewis','Dan','2035554407','2440 Pompton St.',NULL,'Glendale','CT','97561','USA',1323,0,'3','2003-01-01',NULL,NULL),(20241102,'Scandinavian Gift Ideas','Larsson','Martha','0695-34 6555','Åkergatan 24',NULL,'Bräcke',NULL,'S-844 67','Sweden',1504,0,'7','2003-01-01',NULL,NULL),(20241103,'The Sharp Gifts Warehouse','Frick','Sue','4085553659','3086 Ingle Ln.',NULL,'San Jose','CA','94217','USA',1165,0,'1','2003-01-01',NULL,NULL),(20241104,'Mini Auto Werke','Mendel','Roland ','7675-3555','Kirchgasse 6',NULL,'Graz',NULL,'8010','Austria',1401,0,'4','2003-01-01',NULL,NULL),(20241105,'Super Scale Inc.','Murphy','Leslie','2035559545','567 North Pendale Street',NULL,'New Haven','CT','97823','USA',1286,0,'3','2003-01-01',NULL,NULL),(20241106,'Microscale Inc.','Choi','Yu','2125551957','5290 North Pendale Street','Suite 200','NYC','NY','10022','USA',1286,0,'3','2003-01-01',NULL,NULL),(20241107,'Corrida Auto Replicas, Ltd','Sommer','Martín ','(91) 555 22 82','C/ Araquil, 67',NULL,'Madrid',NULL,'28023','Spain',1702,0,'4','2003-01-01',NULL,NULL),(20241108,'Warburg Exchange','Ottlieb','Sven ','0241-039123','Walserweg 21',NULL,'Aachen',NULL,'52066','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241109,'FunGiftIdeas.com','Benitez','Violeta','5085552555','1785 First Street',NULL,'New Bedford','MA','50553','USA',1216,0,'2','2003-01-01',NULL,NULL),(20241110,'Anton Designs, Ltd.','Anton','Carmen','+34 913 728555','c/ Gobelas, 19-1 Urb. La Florida',NULL,'Madrid',NULL,'28023','Spain',NULL,0,NULL,NULL,NULL,NULL),(20241111,'Australian Collectables, Ltd','Clenahan','Sean','61-9-3844-6555','7 Allen Street',NULL,'Glen Waverly','Victoria','3150','Australia',1611,0,'6','2003-01-01',NULL,NULL),(20241112,'Frau da Collezione','Ricotti','Franco','+39 022515555','20093 Cologno Monzese','Alessandro Volta 16','Milan',NULL,NULL,'Italy',1401,0,'4','2003-01-01',NULL,NULL),(20241113,'West Coast Collectables Co.','Thompson','Steve','3105553722','3675 Furth Circle',NULL,'Burbank','CA','94019','USA',1166,0,'1','2003-01-01',NULL,NULL),(20241114,'Mit Vergnügen & Co.','Moos','Hanna ','0621-08555','Forsterstr. 57',NULL,'Mannheim',NULL,'68306','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241115,'Kremlin Collectables, Co.','Semenov','Alexander ','+7 812 293 0521','2 Pobedy Square',NULL,'Saint Petersburg',NULL,'196143','Russia',NULL,0,NULL,NULL,NULL,NULL),(20241116,'Raanan Stores, Inc','Altagar,G M','Raanan','+ 972 9 959 8555','3 Hagalim Blv.',NULL,'Herzlia',NULL,'47625','Israel',NULL,0,NULL,NULL,NULL,NULL),(20241117,'Iberia Gift Imports, Corp.','Roel','José Pedro ','(95) 555 82 82','C/ Romero, 33',NULL,'Sevilla',NULL,'41101','Spain',1702,0,'4','2003-01-01',NULL,NULL),(20241118,'Motor Mint Distributors Inc.','Salazar','Rosa','2155559857','11328 Douglas Av.',NULL,'Philadelphia','PA','71270','USA',1323,0,'3','2003-01-01',NULL,NULL),(20241119,'Signal Collectibles Ltd.','Taylor','Sue','4155554312','2793 Furth Circle',NULL,'Brisbane','CA','94217','USA',1165,0,'1','2003-01-01',NULL,NULL),(20241120,'Double Decker Gift Stores, Ltd','Smith','Thomas ','(171) 555-7555','120 Hanover Sq.',NULL,'London',NULL,'WA1 1DP','UK',1501,0,'7','2003-01-01',NULL,NULL),(20241121,'Diecast Collectables','Franco','Valarie','6175552555','6251 Ingle Ln.',NULL,'Boston','MA','51003','USA',1188,0,'2','2003-01-01',NULL,NULL),(20241122,'Kelly\'s Gift Shop','Snowden','Tony','+64 9 5555500','Arenales 1938 3\'A\'',NULL,'Auckland  ',NULL,NULL,'New Zealand',1612,0,'6','2003-01-01',NULL,NULL),(20241123,'Ramos Toys','James','Ramos','+639297634589','2502 Taft Avenue',NULL,'Manila','NCR','1004','Philippines',1188,0,'2','2003-01-01',NULL,NULL),(20241124,'Mendoza Entertainment','Peter','Mendoza','+639057634589','2502 Buendia Avenue','','Makati','NCR','1752','Philippines',1612,0,'6','2003-01-01',NULL,NULL),(20241125,'Customer A','LastA','FirstA','1234567890','Address Line 1',NULL,'City A',NULL,NULL,'Country A',201,0,'OFF1','2024-01-01',NULL,NULL),(20241126,'Customer B','LastB','FirstB','0987654321','Address Line 2',NULL,'City B',NULL,NULL,'Country B',202,0,'OFF2','2024-01-01',NULL,NULL),(20241127,'Maria Rodriguez','Rodriguez','Maria','09123456789','Suite 007',NULL,'Manila','NCR','1000','Philippines',1401,0,'3',NULL,NULL,NULL),(20241128,'Isabella Garcia','Garcia','Isabella','09234567890','32nd Floor',NULL,'Taguig','NCR','1630','Philippines',20242728,0,'3432',NULL,NULL,NULL),(20241129,'Luigi Lopez','Lopez','Luigi','09345678901','Unit 1605',NULL,'Manila','NCR','1000','Philippines',1504,0,'1',NULL,NULL,NULL),(20241130,'Kyle Fernandez','Fernandez','Kyle','09456789012','Block 2104',NULL,'Quezon City','NCR','1100','Philippines',1323,0,'4',NULL,NULL,NULL);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `customers_BEFORE_INSERT` BEFORE INSERT ON `customers` FOR EACH ROW BEGIN
	DECLARE current_year CHAR(4);
    DECLARE fixed_part INT;
    DECLARE lastNumber  INT;
    DECLARE NumberString VARCHAR(255);
    DECLARE lastThreeChars VARCHAR(3);
    
    DECLARE newCustomerNumber INT; 
    
    SET current_year = DATE_FORMAT(CURDATE(), '%Y');
    SET fixed_part = '01';
	
	SELECT MAX(customerNumber) INTO lastNumber FROM customers_audit;
    
    SET NumberString = CAST(lastNumber AS CHAR);
    SET lastThreeChars = RIGHT(NumberString, 3);
    
    SET newCustomerNumber = CAST(CONCAT(current_year, fixed_part, lastThreeChars) AS UNSIGNED) + 1;
	IF (lastNumber is NULL) THEN
		SET newCustomerNumber := CAST(CONCAT(current_year, fixed_part, '001') AS UNSIGNED);
	END IF;
		SET new.customerNumber := newCustomerNumber;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `customers_AFTER_INSERT` AFTER INSERT ON `customers` FOR EACH ROW BEGIN
	INSERT INTO customers_audit VALUES(new.customerNumber, now(), 'C', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, new.customerName, new.contactLastName, new.contactFirstName, new.phone, new.addressLine1, new.addressLine2, new.city, new.state, new.postalCode, new.country, new.salesRepEmployeeNumber, new.creditLimit, new.officeCode, new.startDate, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `customers_AFTER_UPDATE` AFTER UPDATE ON `customers` FOR EACH ROW BEGIN
	IF (old.customerNumber <> new.customerNumber) THEN
		SIGNAL  SQLSTATE  '45000' SET MESSAGE_TEXT = 'customerNumber cannot be modified';
	END IF;
	INSERT INTO customers_audit VALUES(new.customerNumber, now(), 'U', old.customerName, old.contactLastName, old.contactFirstName, old.phone, old.addressLine1, old.addressLine2, old.city, old.state, old.postalCode, old.country, old.salesRepEmployeeNumber, old.creditLimit, old.officeCode, old.startDate, new.customerName, new.contactLastName, new.contactFirstName, new.phone, new.addressLine1, new.addressLine2, new.city, new.state, new.postalCode, new.country, new.salesRepEmployeeNumber, new.creditLimit, new.officeCode, new.startDate, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `customers_BEFORE_DELETE` BEFORE DELETE ON `customers` FOR EACH ROW BEGIN
	INSERT INTO customers_audit VALUES(old.customerNumber, now(), 'D', old.customerName, old.contactLastName, old.contactFirstName, old.phone, old.addressLine1, old.addressLine2, old.city, old.state, old.postalCode, old.country, old.salesRepEmployeeNumber, old.creditLimit, old.officeCode, old.startDate, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `customers_audit`
--

DROP TABLE IF EXISTS `customers_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers_audit` (
  `customerNumber` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_customerName` varchar(50) DEFAULT NULL,
  `old_contactLastName` varchar(50) DEFAULT NULL,
  `old_contactFirstName` varchar(50) DEFAULT NULL,
  `old_phone` varchar(50) DEFAULT NULL,
  `old_addressLine1` varchar(50) DEFAULT NULL,
  `old_addressLine2` varchar(50) DEFAULT NULL,
  `old_city` varchar(50) DEFAULT NULL,
  `old_state` varchar(50) DEFAULT NULL,
  `old_postalCode` varchar(15) DEFAULT NULL,
  `old_country` varchar(50) DEFAULT NULL,
  `old_salesRepEmployeeNumber` int DEFAULT NULL,
  `old_creditLimit` double DEFAULT NULL,
  `old_officeCode` varchar(10) DEFAULT NULL,
  `old_startDate` date DEFAULT NULL,
  `new_customerName` varchar(50) DEFAULT NULL,
  `new_contactLastName` varchar(50) DEFAULT NULL,
  `new_contactFirstName` varchar(50) DEFAULT NULL,
  `new_phone` varchar(50) DEFAULT NULL,
  `new_addressLine1` varchar(50) DEFAULT NULL,
  `new_addressLine2` varchar(50) DEFAULT NULL,
  `new_city` varchar(50) DEFAULT NULL,
  `new_state` varchar(50) DEFAULT NULL,
  `new_postalCode` varchar(15) DEFAULT NULL,
  `new_country` varchar(50) DEFAULT NULL,
  `new_salesRepEmployeeNumber` int DEFAULT NULL,
  `new_creditLimit` double DEFAULT NULL,
  `new_officeCode` varchar(10) DEFAULT NULL,
  `new_startDate` date DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customerNumber`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers_audit`
--

LOCK TABLES `customers_audit` WRITE;
/*!40000 ALTER TABLE `customers_audit` DISABLE KEYS */;
INSERT INTO `customers_audit` VALUES (20241001,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Atelier graphique','Schmitt','Carine ','40.32.2555','54, rue Royale',NULL,'Nantes',NULL,'44000','France',1370,0,'4','2003-01-01',NULL,NULL),(20241002,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Signal Gift Stores','King','Jean','7025551838','8489 Strong St.',NULL,'Las Vegas','NV','83030','USA',1166,0,'1','2003-01-01',NULL,NULL),(20241003,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Australian Collectors, Co.','Ferguson','Peter','03 9520 4555','636 St Kilda Road','Level 3','Melbourne','Victoria','3004','Australia',1611,0,'6','2003-01-01',NULL,NULL),(20241004,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'La Rochelle Gifts','Labrune','Janine ','40.67.8555','67, rue des Cinquante Otages',NULL,'Nantes',NULL,'44000','France',1370,0,'4','2003-01-01',NULL,NULL),(20241005,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Baane Mini Imports','Bergulfsen','Jonas ','07-98 9555','Erling Skakkes gate 78',NULL,'Stavern',NULL,'4110','Norway',1504,0,'7','2003-01-01',NULL,NULL),(20241006,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mini Gifts Distributors Ltd.','Nelson','Susan','4155551450','5677 Strong St.',NULL,'San Rafael','CA','97562','USA',1165,0,'1','2003-01-01',NULL,NULL),(20241007,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Havel & Zbyszek Co','Piestrzeniewicz','Zbyszek ','(26) 642-7555','ul. Filtrowa 68',NULL,'Warszawa',NULL,'01-012','Poland',NULL,0,NULL,NULL,NULL,NULL),(20241008,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Blauer See Auto, Co.','Keitel','Roland','+49 69 66 90 2555','Lyonerstr. 34',NULL,'Frankfurt',NULL,'60528','Germany',1504,0,'7','2003-01-01',NULL,NULL),(20241009,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mini Wheels Co.','Murphy','Julie','6505555787','5557 North Pendale Street',NULL,'San Francisco','CA','94217','USA',1165,0,'1','2003-01-01',NULL,NULL),(20241010,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Land of Toys Inc.','Lee','Kwai','2125557818','897 Long Airport Avenue',NULL,'NYC','NY','10022','USA',1323,0,'3','2003-01-01',NULL,NULL),(20241011,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Euro+ Shopping Channel','Freyre','Diego ','(91) 555 94 44','C/ Moralzarzal, 86',NULL,'Madrid',NULL,'28034','Spain',1370,0,'4','2003-01-01',NULL,NULL),(20241012,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Volvo Model Replicas, Co','Berglund','Christina ','0921-12 3555','Berguvsvägen  8',NULL,'Luleå',NULL,'S-958 22','Sweden',1504,0,'7','2003-01-01',NULL,NULL),(20241013,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Danish Wholesale Imports','Petersen','Jytte ','31 12 3555','Vinbæltet 34',NULL,'Kobenhavn',NULL,'1734','Denmark',1401,0,'4','2003-01-01',NULL,NULL),(20241014,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Saveley & Henriot, Co.','Saveley','Mary ','78.32.5555','2, rue du Commerce',NULL,'Lyon',NULL,'69004','France',1337,0,'4','2003-01-01',NULL,NULL),(20241015,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Dragon Souveniers, Ltd.','Natividad','Eric','+65 221 7555','Bronz Sok.','Bronz Apt. 3/6 Tesvikiye','Singapore',NULL,'079903','Singapore',1621,0,'5','2003-01-01',NULL,NULL),(20241016,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Muscle Machine Inc','Young','Jeff','2125557413','4092 Furth Circle','Suite 400','NYC','NY','10022','USA',1286,0,'3','2003-01-01',NULL,NULL),(20241017,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Diecast Classics Inc.','Leong','Kelvin','2155551555','7586 Pompton St.',NULL,'Allentown','PA','70267','USA',1216,0,'2','2003-01-01',NULL,NULL),(20241018,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Technics Stores Inc.','Hashimoto','Juri','6505556809','9408 Furth Circle',NULL,'Burlingame','CA','94217','USA',1165,0,'1','2003-01-01',NULL,NULL),(20241019,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Handji Gifts& Co','Victorino','Wendy','+65 224 1555','106 Linden Road Sandown','2nd Floor','Singapore',NULL,'069045','Singapore',1612,0,'6','2003-01-01',NULL,NULL),(20241020,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Herkku Gifts','Oeztan','Veysel','+47 2267 3215','Brehmen St. 121','PR 334 Sentrum','Bergen',NULL,'N 5804','Norway  ',1504,0,'7','2003-01-01',NULL,NULL),(20241021,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'American Souvenirs Inc','Franco','Keith','2035557845','149 Spinnaker Dr.','Suite 101','New Haven','CT','97823','USA',1286,0,'3','2003-01-01',NULL,NULL),(20241022,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Porto Imports Co.','de Castro','Isabel ','(1) 356-5555','Estrada da saúde n. 58',NULL,'Lisboa',NULL,'1756','Portugal',NULL,0,NULL,NULL,NULL,NULL),(20241023,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Daedalus Designs Imports','Rancé','Martine ','20.16.1555','184, chaussée de Tournai',NULL,'Lille',NULL,'59000','France',1370,0,'4','2003-01-01',NULL,NULL),(20241024,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'La Corne D\'abondance, Co.','Bertrand','Marie','(1) 42.34.2555','265, boulevard Charonne',NULL,'Paris',NULL,'75012','France',1337,0,'4','2003-01-01',NULL,NULL),(20241025,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cambridge Collectables Co.','Tseng','Jerry','6175555555','4658 Baden Av.',NULL,'Cambridge','MA','51247','USA',1188,0,'2','2003-01-01',NULL,NULL),(20241026,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Gift Depot Inc.','King','Julie','2035552570','25593 South Bay Ln.',NULL,'Bridgewater','CT','97562','USA',1323,0,'3','2003-01-01',NULL,NULL),(20241027,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Osaka Souveniers Co.','Kentary','Mory','+81 06 6342 5555','1-6-20 Dojima',NULL,'Kita-ku','Osaka',' 530-0003','Japan',1621,0,'5','2003-01-01',NULL,NULL),(20241028,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Vitachrome Inc.','Frick','Michael','2125551500','2678 Kingston Rd.','Suite 101','NYC','NY','10022','USA',1286,0,'3','2003-01-01',NULL,NULL),(20241029,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Toys of Finland, Co.','Karttunen','Matti','90-224 8555','Keskuskatu 45',NULL,'Helsinki',NULL,'21240','Finland',1501,0,'7','2003-01-01',NULL,NULL),(20241030,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'AV Stores, Co.','Ashworth','Rachel','(171) 555-1555','Fauntleroy Circus',NULL,'Manchester',NULL,'EC2 5NT','UK',1501,0,'7','2003-01-01',NULL,NULL),(20241031,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Clover Collections, Co.','Cassidy','Dean','+353 1862 1555','25 Maiden Lane','Floor No. 4','Dublin',NULL,'2','Ireland',1504,0,'7','2003-01-01',NULL,NULL),(20241032,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Auto-Moto Classics Inc.','Taylor','Leslie','6175558428','16780 Pompton St.',NULL,'Brickhaven','MA','58339','USA',1216,0,'2','2003-01-01',NULL,NULL),(20241033,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UK Collectables, Ltd.','Devon','Elizabeth','(171) 555-2282','12, Berkeley Gardens Blvd',NULL,'Liverpool',NULL,'WX1 6LT','UK',1501,0,'7','2003-01-01',NULL,NULL),(20241034,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Canadian Gift Exchange Network','Tamuri','Yoshi ','(604) 555-3392','1900 Oak St.',NULL,'Vancouver','BC','V3F 2K1','Canada',1323,0,'3','2003-01-01',NULL,NULL),(20241035,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Online Mini Collectables','Barajas','Miguel','6175557555','7635 Spinnaker Dr.',NULL,'Brickhaven','MA','58339','USA',1188,0,'2','2003-01-01',NULL,NULL),(20241036,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Toys4GrownUps.com','Young','Julie','6265557265','78934 Hillside Dr.',NULL,'Pasadena','CA','90003','USA',1166,0,'1','2003-01-01',NULL,NULL),(20241037,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Asian Shopping Network, Co','Walker','Brydey','+612 9411 1555','Suntec Tower Three','8 Temasek','Singapore',NULL,'038988','Singapore',NULL,0,NULL,NULL,NULL,NULL),(20241038,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mini Caravy','Citeaux','Frédérique ','88.60.1555','24, place Kléber',NULL,'Strasbourg',NULL,'67000','France',1370,0,'4','2003-01-01',NULL,NULL),(20241039,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'King Kong Collectables, Co.','Gao','Mike','+852 2251 1555','Bank of China Tower','1 Garden Road','Central Hong Kong',NULL,NULL,'Hong Kong',1621,0,'5','2003-01-01',NULL,NULL),(20241040,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Enaco Distributors','Saavedra','Eduardo ','(93) 203 4555','Rambla de Cataluña, 23',NULL,'Barcelona',NULL,'08022','Spain',1702,0,'4','2003-01-01',NULL,NULL),(20241041,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Boards & Toys Co.','Young','Mary','3105552373','4097 Douglas Av.',NULL,'Glendale','CA','92561','USA',1166,0,'1','2003-01-01',NULL,NULL),(20241042,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Natürlich Autos','Kloss','Horst ','0372-555188','Taucherstraße 10',NULL,'Cunewalde',NULL,'01307','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241043,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Heintze Collectables','Ibsen','Palle','86 21 3555','Smagsloget 45',NULL,'Århus',NULL,'8200','Denmark',1401,0,'4','2003-01-01',NULL,NULL),(20241044,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Québec Home Shopping Network','Fresnière','Jean ','(514) 555-8054','43 rue St. Laurent',NULL,'Montréal','Québec','H1J 1C3','Canada',1286,0,'3','2003-01-01',NULL,NULL),(20241045,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ANG Resellers','Camino','Alejandra ','(91) 745 6555','Gran Vía, 1',NULL,'Madrid',NULL,'28001','Spain',NULL,0,NULL,NULL,NULL,NULL),(20241046,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Collectable Mini Designs Co.','Thompson','Valarie','7605558146','361 Furth Circle',NULL,'San Diego','CA','91217','USA',1166,0,'1','2003-01-01',NULL,NULL),(20241047,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'giftsbymail.co.uk','Bennett','Helen ','(198) 555-8888','Garden House','Crowther Way 23','Cowes','Isle of Wight','PO31 7PJ','UK',1501,0,'7','2003-01-01',NULL,NULL),(20241048,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Alpha Cognac','Roulet','Annette ','61.77.6555','1 rue Alsace-Lorraine',NULL,'Toulouse',NULL,'31000','France',1370,0,'4','2003-01-01',NULL,NULL),(20241049,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Messner Shopping Network','Messner','Renate ','069-0555984','Magazinweg 7',NULL,'Frankfurt',NULL,'60528','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241050,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Amica Models & Co.','Accorti','Paolo ','011-4988555','Via Monte Bianco 34',NULL,'Torino',NULL,'10100','Italy',1401,0,'4','2003-01-01',NULL,NULL),(20241051,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Lyon Souveniers','Da Silva','Daniel','+33 1 46 62 7555','27 rue du Colonel Pierre Avia',NULL,'Paris',NULL,'75508','France',1337,0,'4','2003-01-01',NULL,NULL),(20241052,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Auto Associés & Cie.','Tonini','Daniel ','30.59.8555','67, avenue de l\'Europe',NULL,'Versailles',NULL,'78000','France',1370,0,'4','2003-01-01',NULL,NULL),(20241053,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Toms Spezialitäten, Ltd','Pfalzheim','Henriette ','0221-5554327','Mehrheimerstr. 369',NULL,'Köln',NULL,'50739','Germany',1504,0,'7','2003-01-01',NULL,NULL),(20241054,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Royal Canadian Collectables, Ltd.','Lincoln','Elizabeth ','(604) 555-4555','23 Tsawassen Blvd.',NULL,'Tsawassen','BC','T2F 8M4','Canada',1323,0,'3','2003-01-01',NULL,NULL),(20241055,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Franken Gifts, Co','Franken','Peter ','089-0877555','Berliner Platz 43',NULL,'München',NULL,'80805','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241056,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Anna\'s Decorations, Ltd','O\'Hara','Anna','02 9936 8555','201 Miller Street','Level 15','North Sydney','NSW','2060','Australia',1611,0,'6','2003-01-01',NULL,NULL),(20241057,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Rovelli Gifts','Rovelli','Giovanni ','035-640555','Via Ludovico il Moro 22',NULL,'Bergamo',NULL,'24100','Italy',1401,0,'4','2003-01-01',NULL,NULL),(20241058,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Souveniers And Things Co.','Huxley','Adrian','+61 2 9495 8555','Monitor Money Building','815 Pacific Hwy','Chatswood','NSW','2067','Australia',1611,0,'6','2003-01-01',NULL,NULL),(20241059,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Marta\'s Replicas Co.','Hernandez','Marta','6175558555','39323 Spinnaker Dr.',NULL,'Cambridge','MA','51247','USA',1216,0,'2','2003-01-01',NULL,NULL),(20241060,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'BG&E Collectables','Harrison','Ed','+41 26 425 50 01','Rte des Arsenaux 41 ',NULL,'Fribourg',NULL,'1700','Switzerland',NULL,0,NULL,NULL,NULL,NULL),(20241061,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Vida Sport, Ltd','Holz','Mihael','0897-034555','Grenzacherweg 237',NULL,'Genève',NULL,'1203','Switzerland',1702,0,'4','2003-01-01',NULL,NULL),(20241062,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Norway Gifts By Mail, Co.','Klaeboe','Jan','+47 2212 1555','Drammensveien 126A','PB 211 Sentrum','Oslo',NULL,'N 0106','Norway  ',1504,0,'7','2003-01-01',NULL,NULL),(20241063,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Schuyler Imports','Schuyler','Bradley','+31 20 491 9555','Kingsfordweg 151',NULL,'Amsterdam',NULL,'1043 GR','Netherlands',NULL,0,NULL,NULL,NULL,NULL),(20241064,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Der Hund Imports','Andersen','Mel','030-0074555','Obere Str. 57',NULL,'Berlin',NULL,'12209','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241065,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Oulu Toy Supplies, Inc.','Koskitalo','Pirkko','981-443655','Torikatu 38',NULL,'Oulu',NULL,'90110','Finland',1501,0,'7','2003-01-01',NULL,NULL),(20241066,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Petit Auto','Dewey','Catherine ','(02) 5554 67','Rue Joseph-Bens 532',NULL,'Bruxelles',NULL,'B-1180','Belgium',1401,0,'4','2003-01-01',NULL,NULL),(20241067,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mini Classics','Frick','Steve','9145554562','3758 North Pendale Street',NULL,'White Plains','NY','24067','USA',1323,0,'3','2003-01-01',NULL,NULL),(20241068,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mini Creations Ltd.','Huang','Wing','5085559555','4575 Hillside Dr.',NULL,'New Bedford','MA','50553','USA',1188,0,'2','2003-01-01',NULL,NULL),(20241069,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Corporate Gift Ideas Co.','Brown','Julie','6505551386','7734 Strong St.',NULL,'San Francisco','CA','94217','USA',1165,0,'1','2003-01-01',NULL,NULL),(20241070,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Down Under Souveniers, Inc','Graham','Mike','+64 9 312 5555','162-164 Grafton Road','Level 2','Auckland  ',NULL,NULL,'New Zealand',1612,0,'6','2003-01-01',NULL,NULL),(20241071,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Stylish Desk Decors, Co.','Brown','Ann ','(171) 555-0297','35 King George',NULL,'London',NULL,'WX3 6FW','UK',1501,0,'7','2003-01-01',NULL,NULL),(20241072,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tekni Collectables Inc.','Brown','William','2015559350','7476 Moss Rd.',NULL,'Newark','NJ','94019','USA',1323,0,'3','2003-01-01',NULL,NULL),(20241073,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Australian Gift Network, Co','Calaghan','Ben','61-7-3844-6555','31 Duncan St. West End',NULL,'South Brisbane','Queensland','4101','Australia',1611,0,'6','2003-01-01',NULL,NULL),(20241074,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Suominen Souveniers','Suominen','Kalle','+358 9 8045 555','Software Engineering Center','SEC Oy','Espoo',NULL,'FIN-02271','Finland',1501,0,'7','2003-01-01',NULL,NULL),(20241075,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cramer Spezialitäten, Ltd','Cramer','Philip ','0555-09555','Maubelstr. 90',NULL,'Brandenburg',NULL,'14776','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241076,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Classic Gift Ideas, Inc','Cervantes','Francisca','2155554695','782 First Street',NULL,'Philadelphia','PA','71270','USA',1188,0,'2','2003-01-01',NULL,NULL),(20241077,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CAF Imports','Fernandez','Jesus','+34 913 728 555','Merchants House','27-30 Merchant\'s Quay','Madrid',NULL,'28023','Spain',1702,0,'4','2003-01-01',NULL,NULL),(20241078,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Men \'R\' US Retailers, Ltd.','Chandler','Brian','2155554369','6047 Douglas Av.',NULL,'Los Angeles','CA','91003','USA',1166,0,'1','2003-01-01',NULL,NULL),(20241079,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Asian Treasures, Inc.','McKenna','Patricia ','2967 555','8 Johnstown Road',NULL,'Cork','Co. Cork',NULL,'Ireland',NULL,0,NULL,NULL,NULL,NULL),(20241080,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Marseille Mini Autos','Lebihan','Laurence ','91.24.4555','12, rue des Bouchers',NULL,'Marseille',NULL,'13008','France',1337,0,'4','2003-01-01',NULL,NULL),(20241081,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Reims Collectables','Henriot','Paul ','26.47.1555','59 rue de l\'Abbaye',NULL,'Reims',NULL,'51100','France',1337,0,'4','2003-01-01',NULL,NULL),(20241082,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SAR Distributors, Co','Kuger','Armand','+27 21 550 3555','1250 Pretorius Street',NULL,'Hatfield','Pretoria','0028','South Africa',NULL,0,NULL,NULL,NULL,NULL),(20241083,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GiftsForHim.com','MacKinlay','Wales','64-9-3763555','199 Great North Road',NULL,'Auckland',NULL,NULL,'New Zealand',1612,0,'6','2003-01-01',NULL,NULL),(20241084,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Kommission Auto','Josephs','Karin','0251-555259','Luisenstr. 48',NULL,'Münster',NULL,'44087','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241085,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Gifts4AllAges.com','Yoshido','Juri','6175559555','8616 Spinnaker Dr.',NULL,'Boston','MA','51003','USA',1216,0,'2','2003-01-01',NULL,NULL),(20241086,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Online Diecast Creations Co.','Young','Dorothy','6035558647','2304 Long Airport Avenue',NULL,'Nashua','NH','62005','USA',1216,0,'2','2003-01-01',NULL,NULL),(20241087,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Lisboa Souveniers, Inc','Rodriguez','Lino ','(1) 354-2555','Jardim das rosas n. 32',NULL,'Lisboa',NULL,'1675','Portugal',NULL,0,NULL,NULL,NULL,NULL),(20241088,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Precious Collectables','Urs','Braun','0452-076555','Hauptstr. 29',NULL,'Bern',NULL,'3012','Switzerland',1702,0,'4','2003-01-01',NULL,NULL),(20241089,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Collectables For Less Inc.','Nelson','Allen','6175558555','7825 Douglas Av.',NULL,'Brickhaven','MA','58339','USA',1188,0,'2','2003-01-01',NULL,NULL),(20241090,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Royale Belge','Cartrain','Pascale ','(071) 23 67 2555','Boulevard Tirou, 255',NULL,'Charleroi',NULL,'B-6000','Belgium',1401,0,'4','2003-01-01',NULL,NULL),(20241091,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Salzburg Collectables','Pipps','Georg ','6562-9555','Geislweg 14',NULL,'Salzburg',NULL,'5020','Austria',1401,0,'4','2003-01-01',NULL,NULL),(20241092,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Cruz & Sons Co.','Cruz','Arnold','+63 2 555 3587','15 McCallum Street','NatWest Center #13-03','Makati City',NULL,'1227 MM','Philippines',1621,0,'5','2003-01-01',NULL,NULL),(20241093,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'L\'ordine Souveniers','Moroni','Maurizio ','0522-556555','Strada Provinciale 124',NULL,'Reggio Emilia',NULL,'42100','Italy',1401,0,'4','2003-01-01',NULL,NULL),(20241094,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tokyo Collectables, Ltd','Shimamura','Akiko','+81 3 3584 0555','2-2-8 Roppongi',NULL,'Minato-ku','Tokyo','106-0032','Japan',1621,0,'5','2003-01-01',NULL,NULL),(20241095,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Auto Canal+ Petit','Perrier','Dominique','(1) 47.55.6555','25, rue Lauriston',NULL,'Paris',NULL,'75016','France',1337,0,'4','2003-01-01',NULL,NULL),(20241096,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Stuttgart Collectable Exchange','Müller','Rita ','0711-555361','Adenauerallee 900',NULL,'Stuttgart',NULL,'70563','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241097,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Extreme Desk Decorations, Ltd','McRoy','Sarah','04 499 9555','101 Lambton Quay','Level 11','Wellington',NULL,NULL,'New Zealand',1612,0,'6','2003-01-01',NULL,NULL),(20241098,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Bavarian Collectables Imports, Co.','Donnermeyer','Michael',' +49 89 61 08 9555','Hansastr. 15',NULL,'Munich',NULL,'80686','Germany',1504,0,'7','2003-01-01',NULL,NULL),(20241099,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Classic Legends Inc.','Hernandez','Maria','2125558493','5905 Pompton St.','Suite 750','NYC','NY','10022','USA',1286,0,'3','2003-01-01',NULL,NULL),(20241100,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Feuer Online Stores, Inc','Feuer','Alexander ','0342-555176','Heerstr. 22',NULL,'Leipzig',NULL,'04179','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241101,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Gift Ideas Corp.','Lewis','Dan','2035554407','2440 Pompton St.',NULL,'Glendale','CT','97561','USA',1323,0,'3','2003-01-01',NULL,NULL),(20241102,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scandinavian Gift Ideas','Larsson','Martha','0695-34 6555','Åkergatan 24',NULL,'Bräcke',NULL,'S-844 67','Sweden',1504,0,'7','2003-01-01',NULL,NULL),(20241103,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'The Sharp Gifts Warehouse','Frick','Sue','4085553659','3086 Ingle Ln.',NULL,'San Jose','CA','94217','USA',1165,0,'1','2003-01-01',NULL,NULL),(20241104,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mini Auto Werke','Mendel','Roland ','7675-3555','Kirchgasse 6',NULL,'Graz',NULL,'8010','Austria',1401,0,'4','2003-01-01',NULL,NULL),(20241105,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Super Scale Inc.','Murphy','Leslie','2035559545','567 North Pendale Street',NULL,'New Haven','CT','97823','USA',1286,0,'3','2003-01-01',NULL,NULL),(20241106,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Microscale Inc.','Choi','Yu','2125551957','5290 North Pendale Street','Suite 200','NYC','NY','10022','USA',1286,0,'3','2003-01-01',NULL,NULL),(20241107,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Corrida Auto Replicas, Ltd','Sommer','Martín ','(91) 555 22 82','C/ Araquil, 67',NULL,'Madrid',NULL,'28023','Spain',1702,0,'4','2003-01-01',NULL,NULL),(20241108,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Warburg Exchange','Ottlieb','Sven ','0241-039123','Walserweg 21',NULL,'Aachen',NULL,'52066','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241109,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'FunGiftIdeas.com','Benitez','Violeta','5085552555','1785 First Street',NULL,'New Bedford','MA','50553','USA',1216,0,'2','2003-01-01',NULL,NULL),(20241110,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Anton Designs, Ltd.','Anton','Carmen','+34 913 728555','c/ Gobelas, 19-1 Urb. La Florida',NULL,'Madrid',NULL,'28023','Spain',NULL,0,NULL,NULL,NULL,NULL),(20241111,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Australian Collectables, Ltd','Clenahan','Sean','61-9-3844-6555','7 Allen Street',NULL,'Glen Waverly','Victoria','3150','Australia',1611,0,'6','2003-01-01',NULL,NULL),(20241112,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Frau da Collezione','Ricotti','Franco','+39 022515555','20093 Cologno Monzese','Alessandro Volta 16','Milan',NULL,NULL,'Italy',1401,0,'4','2003-01-01',NULL,NULL),(20241113,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'West Coast Collectables Co.','Thompson','Steve','3105553722','3675 Furth Circle',NULL,'Burbank','CA','94019','USA',1166,0,'1','2003-01-01',NULL,NULL),(20241114,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mit Vergnügen & Co.','Moos','Hanna ','0621-08555','Forsterstr. 57',NULL,'Mannheim',NULL,'68306','Germany',NULL,0,NULL,NULL,NULL,NULL),(20241115,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Kremlin Collectables, Co.','Semenov','Alexander ','+7 812 293 0521','2 Pobedy Square',NULL,'Saint Petersburg',NULL,'196143','Russia',NULL,0,NULL,NULL,NULL,NULL),(20241116,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Raanan Stores, Inc','Altagar,G M','Raanan','+ 972 9 959 8555','3 Hagalim Blv.',NULL,'Herzlia',NULL,'47625','Israel',NULL,0,NULL,NULL,NULL,NULL),(20241117,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Iberia Gift Imports, Corp.','Roel','José Pedro ','(95) 555 82 82','C/ Romero, 33',NULL,'Sevilla',NULL,'41101','Spain',1702,0,'4','2003-01-01',NULL,NULL),(20241118,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Motor Mint Distributors Inc.','Salazar','Rosa','2155559857','11328 Douglas Av.',NULL,'Philadelphia','PA','71270','USA',1323,0,'3','2003-01-01',NULL,NULL),(20241119,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Signal Collectibles Ltd.','Taylor','Sue','4155554312','2793 Furth Circle',NULL,'Brisbane','CA','94217','USA',1165,0,'1','2003-01-01',NULL,NULL),(20241120,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Double Decker Gift Stores, Ltd','Smith','Thomas ','(171) 555-7555','120 Hanover Sq.',NULL,'London',NULL,'WA1 1DP','UK',1501,0,'7','2003-01-01',NULL,NULL),(20241121,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Diecast Collectables','Franco','Valarie','6175552555','6251 Ingle Ln.',NULL,'Boston','MA','51003','USA',1188,0,'2','2003-01-01',NULL,NULL),(20241122,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Kelly\'s Gift Shop','Snowden','Tony','+64 9 5555500','Arenales 1938 3\'A\'',NULL,'Auckland  ',NULL,NULL,'New Zealand',1612,0,'6','2003-01-01',NULL,NULL),(20241123,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ramos Toys','James','Ramos','+639297634589','2502 Taft Avenue',NULL,'Manila','NCR','1004','Philippines',1188,0,'2','2003-01-01',NULL,NULL),(20241124,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mendoza Entertainment','Peter','Mendoza','+639057634589','2502 Buendia Avenue','','Makati','NCR','1752','Philippines',1612,0,'6','2003-01-01',NULL,NULL),(20241125,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Customer A','LastA','FirstA','1234567890','Address Line 1',NULL,'City A',NULL,NULL,'Country A',201,0,'OFF1','2024-01-01',NULL,NULL),(20241126,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Customer B','LastB','FirstB','0987654321','Address Line 2',NULL,'City B',NULL,NULL,'Country B',202,0,'OFF2','2024-01-01',NULL,NULL),(20241127,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Maria Rodriguez','Rodriguez','Maria','09123456789','Suite 007',NULL,'Manila','NCR','1000','Philippines',1401,0,'3',NULL,NULL,NULL),(20241128,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Isabella Garcia','Garcia','Isabella','09234567890','32nd Floor',NULL,'Taguig','NCR','1630','Philippines',20242728,0,'3432',NULL,NULL,NULL),(20241129,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Luigi Lopez','Lopez','Luigi','09345678901','Unit 1605',NULL,'Manila','NCR','1000','Philippines',1504,0,'1',NULL,NULL,NULL),(20241130,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Kyle Fernandez','Fernandez','Kyle','09456789012','Block 2104',NULL,'Quezon City','NCR','1100','Philippines',1323,0,'4',NULL,NULL,NULL);
/*!40000 ALTER TABLE `customers_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `deptCode` int NOT NULL,
  `deptName` varchar(45) DEFAULT NULL,
  `deptManagerNumber` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`deptCode`),
  KEY `FK-84_001_idx` (`deptManagerNumber`),
  CONSTRAINT `FK-84_001` FOREIGN KEY (`deptManagerNumber`) REFERENCES `employees` (`employeeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (2001,'Sales',1056,NULL,NULL),(2002,'Marketing',1076,NULL,NULL),(2003,'Administration',1002,NULL,NULL),(2004,'HR',20242703,NULL,NULL),(2005,'Manufacturing',20242706,NULL,NULL),(2006,'shipping',20242710,NULL,NULL);
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `departments_BEFORE_INSERT` BEFORE INSERT ON `departments` FOR EACH ROW BEGIN
	DECLARE newdeptCode INT;
	SELECT MAX(deptCode) + 1 INTO newdeptCode FROM departments_audit;
	IF (newdeptCode is NULL) THEN
		SET newdeptCode := 2001;
	END IF;
		SET new.deptCode := newdeptCode;
        
	IF getEmployeeType(NEW.deptManagerNumber) = 1 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 89A1: deptManagerNumber is not non sales representative';
    END IF;
    
    IF isDeactivated(NEW.deptManagerNumber) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 89A1: deptManagerNumber account is deactivated';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `departments_AFTER_INSERT` AFTER INSERT ON `departments` FOR EACH ROW BEGIN
	INSERT INTO departments_audit VALUES(new.deptCode, now(), 'C', NULL, NULL, new.deptName, new.deptManagerNumber, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `departments_BEFORE_UPDATE` BEFORE UPDATE ON `departments` FOR EACH ROW BEGIN
	IF isDeactivated(NEW.deptManagerNumber) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 89A1: deptManagerNumber account is deactivated';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `departments_AFTER_UPDATE` AFTER UPDATE ON `departments` FOR EACH ROW BEGIN
	IF (old.deptCode <> new.deptCode) THEN
		SIGNAL  SQLSTATE  '45000' SET MESSAGE_TEXT = 'deptCode cannot be modified';
	END IF;
	INSERT INTO departments_audit VALUES(new.deptCode, now(), 'U', old.deptName, old.deptManagerNumber, new.deptName, new.deptManagerNumber, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `departments_BEFORE_DELETE` BEFORE DELETE ON `departments` FOR EACH ROW BEGIN
	INSERT INTO departments_audit VALUES(old.deptCode, now(), 'D', old.deptName, old.deptManagerNumber, NULL, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `departments_audit`
--

DROP TABLE IF EXISTS `departments_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments_audit` (
  `deptCode` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_deptName` varchar(45) DEFAULT NULL,
  `old_deptManagerNumber` int DEFAULT NULL,
  `new_deptName` varchar(45) DEFAULT NULL,
  `new_deptManagerNumber` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`deptCode`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments_audit`
--

LOCK TABLES `departments_audit` WRITE;
/*!40000 ALTER TABLE `departments_audit` DISABLE KEYS */;
INSERT INTO `departments_audit` VALUES (2001,'2024-07-20 03:43:22','C',NULL,NULL,'Sales',1056,NULL,NULL),(2002,'2024-07-20 03:43:22','C',NULL,NULL,'Marketing',1076,NULL,NULL),(2003,'2024-07-20 03:43:22','C',NULL,NULL,'Administration',1002,NULL,NULL),(2004,'2024-07-20 03:43:22','C',NULL,NULL,'HR',20242703,NULL,NULL),(2005,'2024-07-20 03:43:22','C',NULL,NULL,'Manufacturing',20242706,NULL,NULL),(2006,'2024-07-20 03:43:22','C',NULL,NULL,'shipping',20242710,NULL,NULL);
/*!40000 ALTER TABLE `departments_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discontinued_products`
--

DROP TABLE IF EXISTS `discontinued_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discontinued_products` (
  `productCode` varchar(15) NOT NULL,
  `reason` varchar(45) DEFAULT NULL,
  `inventory_manager` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`),
  KEY `FK-91_002_idx` (`inventory_manager`),
  CONSTRAINT `FK-91_001` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`),
  CONSTRAINT `FK-91_002` FOREIGN KEY (`inventory_manager`) REFERENCES `employees` (`employeeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discontinued_products`
--

LOCK TABLES `discontinued_products` WRITE;
/*!40000 ALTER TABLE `discontinued_products` DISABLE KEYS */;
INSERT INTO `discontinued_products` VALUES ('S18_1749','low sales',20242703,'test4be','test4be'),('S700_4002','Removed from Market',1056,NULL,NULL),('S72_1253','Removed from Market',1056,NULL,NULL),('S72_3212','Removed from Market',1056,NULL,NULL),('XX00003','Removed from Market',1056,NULL,NULL),('XX00004','low sales',1056,'mark@toys.com','discontinue product'),('XX00007','low sales',1056,'mark@toys.com','discontinue product'),('XX00008','low sales',20242709,'','');
/*!40000 ALTER TABLE `discontinued_products` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `discontinued_products_BEFORE_INSERT` BEFORE INSERT ON `discontinued_products` FOR EACH ROW BEGIN
	IF getEmployeeType(NEW.inventory_manager) != 3 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 30A6: Employee is not inventory manager';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `discontinued_products_AFTER_INSERT` AFTER INSERT ON `discontinued_products` FOR EACH ROW BEGIN
	INSERT INTO discontinued_products_audit VALUES(new.productCode, now(), 'C', NULL, NULL, new.reason, new.inventory_manager, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `discontinued_products_BEFORE_UPDATE` BEFORE UPDATE ON `discontinued_products` FOR EACH ROW BEGIN
	IF getEmployeeType(NEW.inventory_manager) != 3 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 30A6: Employee is not inventory manager';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `discontinued_products_AFTER_UPDATE` AFTER UPDATE ON `discontinued_products` FOR EACH ROW BEGIN
	IF (old.productCode <> new.productCode) THEN
		SIGNAL  SQLSTATE  '45000' SET MESSAGE_TEXT = 'productCode cannot be modified';
	END IF;
	INSERT INTO discontinued_products_audit VALUES(new.productCode, now(), 'U', old.reason, old.inventory_manager, new.reason, new.inventory_manager, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `discontinued_products_BEFORE_DELETE` BEFORE DELETE ON `discontinued_products` FOR EACH ROW BEGIN
	INSERT INTO discontinued_products_audit VALUES(old.productCode, now(), 'D', old.reason, old.inventory_manager, NULL, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `discontinued_products_audit`
--

DROP TABLE IF EXISTS `discontinued_products_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discontinued_products_audit` (
  `productCode` varchar(15) NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_reason` varchar(45) DEFAULT NULL,
  `old_inventory_manager` int DEFAULT NULL,
  `new_reason` varchar(45) DEFAULT NULL,
  `new_inventory_manager` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discontinued_products_audit`
--

LOCK TABLES `discontinued_products_audit` WRITE;
/*!40000 ALTER TABLE `discontinued_products_audit` DISABLE KEYS */;
INSERT INTO `discontinued_products_audit` VALUES ('S18_1749','2024-07-20 03:43:22','C',NULL,NULL,'low sales',20242703,'test4be','test4be'),('S700_4002','2024-07-20 03:43:22','C',NULL,NULL,'Removed from Market',1056,NULL,NULL),('S72_1253','2024-07-20 03:43:22','C',NULL,NULL,'Removed from Market',1056,NULL,NULL),('S72_3212','2024-07-20 03:43:22','C',NULL,NULL,'Removed from Market',1056,NULL,NULL),('XX00003','2024-07-20 03:43:22','C',NULL,NULL,'Removed from Market',1056,NULL,NULL),('XX00004','2024-07-20 03:43:22','C',NULL,NULL,'low sales',1056,'mark@toys.com','discontinue product'),('XX00007','2024-07-20 03:43:22','C',NULL,NULL,'low sales',1056,'mark@toys.com','discontinue product'),('XX00008','2024-07-20 03:43:22','C',NULL,NULL,'low sales',20242709,'','');
/*!40000 ALTER TABLE `discontinued_products_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employeeNumber` int NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `jobTitle` varchar(50) NOT NULL,
  `employee_type` enum('S','N') NOT NULL,
  `is_deactivated` tinyint NOT NULL DEFAULT '0',
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeNumber`),
  KEY `FK00010_idx` (`jobTitle`),
  CONSTRAINT `FK00010` FOREIGN KEY (`jobTitle`) REFERENCES `employees_jobtitles` (`jobTitle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (20242001,'Murphy','Diane','x5801','dmurpy@classicmodelcars.com','President','N',0,NULL,NULL),(20242002,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','VP Sales','N',0,NULL,NULL),(20242003,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','VP Marketing','N',0,NULL,NULL),(20242004,'Patterson','William','x4871','wpatterson@classicmodelcars.com','Sales Manager (APAC)','N',0,NULL,NULL),(20242005,'Bondur','Gerard','x5408','gbondur@classicmodelcars.com','Sale Manager (EMEA)','N',0,NULL,NULL),(20242006,'Bow','Anthony','x5428','abow@classicmodelcars.com','Sales Manager (NA)','N',0,NULL,NULL),(20242007,'Jennings','Leslie','x3291','ljennings@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242008,'Thompson','Leslie','x4065','lthompson@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242009,'Firrelli','Julie','x2173','jfirrelli@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242010,'Patterson','Steve','x4334','spatterson@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242011,'Tseng','Foon Yue','x2248','ftseng@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242012,'Vanauf','George','x4102','gvanauf@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242013,'Bondur','Loui','x6493','lbondur@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242014,'Hernandez','Gerard','x2028','ghernande@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242015,'Castillo','Pamela','x2759','pcastillo@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242016,'Bott','Larry','x2311','lbott@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242017,'Jones','Barry','x102','bjones@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242018,'Fixter','Andy','x101','afixter@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242019,'Marsh','Peter','x102','pmarsh@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242020,'King','Tom','x103','tking@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242021,'Nishi','Mami','x101','mnishi@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242022,'Kato','Yoshimi','x102','ykato@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242023,'Gerard','Martin','x2312','mgerard@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242024,'Doe','John','x2312','jdoe@classicmodelcars.com','Sales Rep','N',0,NULL,NULL),(20242025,'Rogers','Steve','x2312','stve@classicmodelcars.com','Sales Manager (NA)','S',0,NULL,NULL),(20242026,'Stark','Tony','x2312','tony@classicmodelcars.com','Sales Manager (NA)','N',0,NULL,NULL),(20242027,'Stephen','Hawkins','x2312','steph@classicmodelcars.com','Sales Rep','N',0,NULL,NULL),(20242028,'Widow','black','x2312','bw@classicmodelcars.com','Sales Rep','S',0,NULL,NULL),(20242029,'odinson','Thor','x2312','thor@classicmodelcars.com','Sales Rep','N',0,NULL,NULL),(20242030,'coulson','phil','x4543','coul@classicmodelcars.com','Sales Manager (NA)','S',0,'test delete','dhhg'),(20242031,'banner','bruce','x4543','banner@classicmodelcars.com','Sales Manager (NA)','N',0,NULL,NULL),(20242032,'maximof','wanda','x4543','wanda@classicmodelcars.com','Sales Manager (NA)','N',0,NULL,NULL),(20242033,'Ceejay','Pascasio','x2312','ceej@classicmodelcars.com','Sales Rep','S',0,'test delete','dhhg'),(20242034,'parker','peter','x7645','parker@gmail.com','Sales Rep','S',0,'test4caadd','test4caadd'),(20242035,'parker','peter','x7645','parker@gmail.com','Sales Rep','S',0,'test4caadd','test4caadd'),(20242036,'wilson','sam','x7645','sam@gmail.com','Sales Rep','S',0,'test4caadd','test4caadd'),(20242037,'Danvers','Carol','x3847','carol@gmail.com','Sales Rep','N',0,'test4ca2','test4ca2'),(20242038,'Danvers','Carol','x3847','carol@gmail.com','Sales Rep','N',0,'test4ca2','test4ca2'),(20242039,'Danvers','Carol','x3847','carol@gmail.com','Sales Rep','N',0,'test4ca2','test4ca2'),(20242040,'cage','luke','x847358','hsfk@gmail.com','VP Marketing','S',0,'',''),(20242041,'cage2','luke','x847358','hsfk@gmail.com','VP Marketing','N',0,'',''),(20242042,'cage','Representative','x847358','hsfk@gmail.com','VP Marketing','S',0,'',''),(20242043,'panther','Representative','x847358','hsfk@gmail.com','VP Marketing','N',0,'mark1@gmail.com','resigned'),(20242044,'uy','ken','x4857','ken@gmail.com','VP Marketing','N',0,'test4ca','test4ca'),(20242045,'pascasio','cj','x2323','cj@classicmodelcars.com','VP Sales','S',0,'new','new'),(20242046,'pascasioouuo','casdsd','x2323','cjaa@classicmodelcars.com','VP Sales','N',0,'new','new'),(20242047,'pascasioouuo','casdsd','x2323','cjaa@classicmodelcars.com','VP Sales','N',0,'new','new'),(20242048,'pascasiooo','cjjj','x2323','cjaa@classicmodelcars.com','VP Sales','N',0,'resignatoin','resign');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employees_BEFORE_INSERT` BEFORE INSERT ON `employees` FOR EACH ROW BEGIN
	-- System Generated Identifier
    DECLARE current_year CHAR(4);
    DECLARE fixed_part INT;
    DECLARE lastNumber  INT;
    DECLARE NumberString VARCHAR(255);
    DECLARE lastThreeChars VARCHAR(3);
    
    DECLARE newemployeeNumber INT; 
    
    SET current_year = DATE_FORMAT(CURDATE(), '%Y');
    SET fixed_part = '02';
	
	SELECT MAX(employeeNumber) INTO lastNumber FROM employees_audit;
    
    SET NumberString = CAST(lastNumber AS CHAR);
    SET lastThreeChars = RIGHT(NumberString, 3);
    
    SET newemployeeNumber = CAST(CONCAT(current_year, fixed_part, lastThreeChars) AS UNSIGNED) + 1;
	IF (lastNumber is NULL) THEN
		SET newemployeeNumber := CAST(CONCAT(current_year, fixed_part, '001') AS UNSIGNED);
	END IF;
		SET new.employeeNumber := newemployeeNumber;
        
	SET new.is_deactivated := 0;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employees_AFTER_INSERT` AFTER INSERT ON `employees` FOR EACH ROW BEGIN
	INSERT INTO employees_audit VALUES(new.employeeNumber, now(), 'C', NULL, NULL, NULL, NULL, NULL, NULL, new.lastName, new.firstName, new.extension, new.email, new.jobTitle, new.employee_type, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employees_BEFORE_UPDATE` BEFORE UPDATE ON `employees` FOR EACH ROW BEGIN
	-- Ensures that deactivated accounts cannot be modified
	IF (old.is_deactivated = 1) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deactivated Records cannot be modified!';
        
	-- Checks if employeeNumber, firstName, or lastName is modified.
	ELSEIF (old.lastName!=new.lastName) OR (old.firstName!=new.firstName) OR (old.employeeNumber!=new.employeeNumber) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee Last Name, First Name, Number cannot be modified!';
	END IF;
    
    IF OLD.employee_type != NEW.employee_type THEN
        IF isWithin_dateRange(OLD.employeeNumber) = 1 THEN
            UPDATE salesRepAssignments 
            SET `endDate` = CURDATE() 
            WHERE employeeNumber = OLD.employeeNumber;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employees_AFTER_UPDATE` AFTER UPDATE ON `employees` FOR EACH ROW BEGIN
	IF(old.employeeNumber<>new.employeeNumber) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee Number cannot be modified!';
	END IF;
	INSERT INTO employees_audit VALUES(new.employeeNumber, now(), 'U', old.lastName, old.firstName, old.extension, old.email, old.jobTitle, old.employee_type, new.lastName, new.firstName, new.extension, new.email, new.jobTitle, new.employee_type, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employees_BEFORE_DELETE` BEFORE DELETE ON `employees` FOR EACH ROW BEGIN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deletion of records is not allowed';
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `employees_audit`
--

DROP TABLE IF EXISTS `employees_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees_audit` (
  `employeeNumber` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_lastName` varchar(50) DEFAULT NULL,
  `old_firstName` varchar(50) DEFAULT NULL,
  `old_extension` varchar(10) DEFAULT NULL,
  `old_email` varchar(100) DEFAULT NULL,
  `old_jobTitle` varchar(50) DEFAULT NULL,
  `old_employee_type` enum('S','N','R') DEFAULT NULL,
  `new_lastName` varchar(50) DEFAULT NULL,
  `new_firstName` varchar(50) DEFAULT NULL,
  `new_extension` varchar(10) DEFAULT NULL,
  `new_email` varchar(100) DEFAULT NULL,
  `new_jobTitle` varchar(50) DEFAULT NULL,
  `new_employee_type` enum('S','N','R') DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeNumber`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees_audit`
--

LOCK TABLES `employees_audit` WRITE;
/*!40000 ALTER TABLE `employees_audit` DISABLE KEYS */;
INSERT INTO `employees_audit` VALUES (20242001,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Murphy','Diane','x5801','dmurpy@classicmodelcars.com','President','N',NULL,NULL),(20242002,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','VP Sales','N',NULL,NULL),(20242003,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','VP Marketing','N',NULL,NULL),(20242004,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Patterson','William','x4871','wpatterson@classicmodelcars.com','Sales Manager (APAC)','N',NULL,NULL),(20242005,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Bondur','Gerard','x5408','gbondur@classicmodelcars.com','Sale Manager (EMEA)','N',NULL,NULL),(20242006,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Bow','Anthony','x5428','abow@classicmodelcars.com','Sales Manager (NA)','N',NULL,NULL),(20242007,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Jennings','Leslie','x3291','ljennings@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242008,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Thompson','Leslie','x4065','lthompson@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242009,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Firrelli','Julie','x2173','jfirrelli@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242010,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Patterson','Steve','x4334','spatterson@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242011,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Tseng','Foon Yue','x2248','ftseng@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242012,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Vanauf','George','x4102','gvanauf@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242013,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Bondur','Loui','x6493','lbondur@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242014,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Hernandez','Gerard','x2028','ghernande@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242015,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Castillo','Pamela','x2759','pcastillo@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242016,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Bott','Larry','x2311','lbott@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242017,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Jones','Barry','x102','bjones@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242018,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Fixter','Andy','x101','afixter@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242019,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Marsh','Peter','x102','pmarsh@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242020,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'King','Tom','x103','tking@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242021,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Nishi','Mami','x101','mnishi@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242022,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Kato','Yoshimi','x102','ykato@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242023,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Gerard','Martin','x2312','mgerard@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242024,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Doe','John','x2312','jdoe@classicmodelcars.com','Sales Rep','N',NULL,NULL),(20242025,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Rogers','Steve','x2312','stve@classicmodelcars.com','Sales Manager (NA)','S',NULL,NULL),(20242026,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Stark','Tony','x2312','tony@classicmodelcars.com','Sales Manager (NA)','N',NULL,NULL),(20242027,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Stephen','Hawkins','x2312','steph@classicmodelcars.com','Sales Rep','N',NULL,NULL),(20242028,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Widow','black','x2312','bw@classicmodelcars.com','Sales Rep','S',NULL,NULL),(20242029,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'odinson','Thor','x2312','thor@classicmodelcars.com','Sales Rep','N',NULL,NULL),(20242030,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'coulson','phil','x4543','coul@classicmodelcars.com','Sales Manager (NA)','S','test delete','dhhg'),(20242031,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'banner','bruce','x4543','banner@classicmodelcars.com','Sales Manager (NA)','N',NULL,NULL),(20242032,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'maximof','wanda','x4543','wanda@classicmodelcars.com','Sales Manager (NA)','N',NULL,NULL),(20242033,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Ceejay','Pascasio','x2312','ceej@classicmodelcars.com','Sales Rep','S','test delete','dhhg'),(20242034,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'parker','peter','x7645','parker@gmail.com','Sales Rep','S','test4caadd','test4caadd'),(20242035,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'parker','peter','x7645','parker@gmail.com','Sales Rep','S','test4caadd','test4caadd'),(20242036,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'wilson','sam','x7645','sam@gmail.com','Sales Rep','S','test4caadd','test4caadd'),(20242037,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Danvers','Carol','x3847','carol@gmail.com','Sales Rep','N','test4ca2','test4ca2'),(20242038,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Danvers','Carol','x3847','carol@gmail.com','Sales Rep','N','test4ca2','test4ca2'),(20242039,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'Danvers','Carol','x3847','carol@gmail.com','Sales Rep','N','test4ca2','test4ca2'),(20242040,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'cage','luke','x847358','hsfk@gmail.com','VP Marketing','S','',''),(20242041,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'cage2','luke','x847358','hsfk@gmail.com','VP Marketing','N','',''),(20242042,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'cage','Representative','x847358','hsfk@gmail.com','VP Marketing','S','',''),(20242043,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'panther','Representative','x847358','hsfk@gmail.com','VP Marketing','N','mark1@gmail.com','resigned'),(20242044,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'uy','ken','x4857','ken@gmail.com','VP Marketing','N','test4ca','test4ca'),(20242045,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'pascasio','cj','x2323','cj@classicmodelcars.com','VP Sales','S','new','new'),(20242046,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'pascasioouuo','casdsd','x2323','cjaa@classicmodelcars.com','VP Sales','N','new','new'),(20242047,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'pascasioouuo','casdsd','x2323','cjaa@classicmodelcars.com','VP Sales','N','new','new'),(20242048,'2024-07-20 03:43:22','C',NULL,NULL,NULL,NULL,NULL,NULL,'pascasiooo','cjjj','x2323','cjaa@classicmodelcars.com','VP Sales','N','resignatoin','resign');
/*!40000 ALTER TABLE `employees_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees_jobtitles`
--

DROP TABLE IF EXISTS `employees_jobtitles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees_jobtitles` (
  `jobTitle` varchar(50) NOT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`jobTitle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees_jobtitles`
--

LOCK TABLES `employees_jobtitles` WRITE;
/*!40000 ALTER TABLE `employees_jobtitles` DISABLE KEYS */;
INSERT INTO `employees_jobtitles` VALUES ('President',NULL,NULL),('Sale Manager (EMEA)',NULL,NULL),('Sales Manager (APAC)',NULL,NULL),('Sales Manager (NA)',NULL,NULL),('Sales Rep',NULL,NULL),('VP Marketing',NULL,NULL),('VP Sales',NULL,NULL);
/*!40000 ALTER TABLE `employees_jobtitles` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employees_jobTitles_AFTER_INSERT` AFTER INSERT ON `employees_jobtitles` FOR EACH ROW BEGIN
	INSERT INTO employees_jobTitles_audit VALUES (new.jobTitle, now(), new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employees_jobTitles_BEFORE_UPDATE` BEFORE UPDATE ON `employees_jobtitles` FOR EACH ROW BEGIN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee Job Title cannot be modified!';
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employees_jobTitles_AFTER_UPDATE` AFTER UPDATE ON `employees_jobtitles` FOR EACH ROW BEGIN
	INSERT INTO employees_jobTitles_audit VALUES (new.jobTitle, now(), new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employees_jobTitles_BEFORE_DELETE` BEFORE DELETE ON `employees_jobtitles` FOR EACH ROW BEGIN
	INSERT INTO employees_jobTitles_audit VALUES (old.jobTitle, now(), NULL, "Deleted");
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `employees_jobtitles_audit`
--

DROP TABLE IF EXISTS `employees_jobtitles_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees_jobtitles_audit` (
  `jobTitle` varchar(50) NOT NULL,
  `audit_timestamp` datetime DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`jobTitle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees_jobtitles_audit`
--

LOCK TABLES `employees_jobtitles_audit` WRITE;
/*!40000 ALTER TABLE `employees_jobtitles_audit` DISABLE KEYS */;
INSERT INTO `employees_jobtitles_audit` VALUES ('President','2024-07-20 03:43:22',NULL,NULL),('Sale Manager (EMEA)','2024-07-20 03:43:22',NULL,NULL),('Sales Manager (APAC)','2024-07-20 03:43:22',NULL,NULL),('Sales Manager (NA)','2024-07-20 03:43:22',NULL,NULL),('Sales Rep','2024-07-20 03:43:22',NULL,NULL),('VP Marketing','2024-07-20 03:43:22',NULL,NULL),('VP Sales','2024-07-20 03:43:22',NULL,NULL);
/*!40000 ALTER TABLE `employees_jobtitles_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `expiring_assignments`
--

DROP TABLE IF EXISTS `expiring_assignments`;
/*!50001 DROP VIEW IF EXISTS `expiring_assignments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `expiring_assignments` AS SELECT 
 1 AS `employeeNumber`,
 1 AS `maxEndDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `expiring_assignments1`
--

DROP TABLE IF EXISTS `expiring_assignments1`;
/*!50001 DROP VIEW IF EXISTS `expiring_assignments1`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `expiring_assignments1` AS SELECT 
 1 AS `employeeNumber`,
 1 AS `maxEndDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `expiring_assignments_details`
--

DROP TABLE IF EXISTS `expiring_assignments_details`;
/*!50001 DROP VIEW IF EXISTS `expiring_assignments_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `expiring_assignments_details` AS SELECT 
 1 AS `employeeNumber`,
 1 AS `officeCode`,
 1 AS `quota`,
 1 AS `endDate`,
 1 AS `startDate`,
 1 AS `salesManagerNumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `inventory_managers`
--

DROP TABLE IF EXISTS `inventory_managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_managers` (
  `employeeNumber` int NOT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeNumber`),
  CONSTRAINT `FK-92_001` FOREIGN KEY (`employeeNumber`) REFERENCES `non_salesrepresentatives` (`employeeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_managers`
--

LOCK TABLES `inventory_managers` WRITE;
/*!40000 ALTER TABLE `inventory_managers` DISABLE KEYS */;
INSERT INTO `inventory_managers` VALUES (1056,NULL,NULL),(20242703,NULL,NULL),(20242706,NULL,NULL),(20242732,NULL,NULL),(20242733,NULL,NULL);
/*!40000 ALTER TABLE `inventory_managers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `inventory_managers_BEFORE_INSERT` BEFORE INSERT ON `inventory_managers` FOR EACH ROW BEGIN
	IF isDeactivated(NEW.employeeNumber) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 30A4: Employee Record is Deactivated';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `inventory_managers_AFTER_INSERT` AFTER INSERT ON `inventory_managers` FOR EACH ROW BEGIN
	INSERT INTO inventory_managers_audit VALUES (new.employeeNumber, now(), 'C', new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `inventory_managers_AFTER_UPDATE` AFTER UPDATE ON `inventory_managers` FOR EACH ROW BEGIN
	-- IF(old.employeeNumber<>new.employeeNumber) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee Number cannot be modified!';
	-- END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `inventory_managers_BEFORE_DELETE` BEFORE DELETE ON `inventory_managers` FOR EACH ROW BEGIN
	INSERT INTO inventory_managers_audit VALUES (old.employeeNumber, now(), 'D', NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `inventory_managers_audit`
--

DROP TABLE IF EXISTS `inventory_managers_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_managers_audit` (
  `employeeNumber` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','D') DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeNumber`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_managers_audit`
--

LOCK TABLES `inventory_managers_audit` WRITE;
/*!40000 ALTER TABLE `inventory_managers_audit` DISABLE KEYS */;
INSERT INTO `inventory_managers_audit` VALUES (1056,'2024-07-20 03:43:22','C',NULL,NULL),(20242703,'2024-07-20 03:43:22','C',NULL,NULL),(20242706,'2024-07-20 03:43:22','C',NULL,NULL),(20242732,'2024-07-20 03:43:22','C',NULL,NULL),(20242733,'2024-07-20 03:43:22','C',NULL,NULL);
/*!40000 ALTER TABLE `inventory_managers_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `non_salesrepresentatives`
--

DROP TABLE IF EXISTS `non_salesrepresentatives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `non_salesrepresentatives` (
  `employeeNumber` int NOT NULL,
  `deptCode` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeNumber`),
  KEY `FK-83_001_idx` (`deptCode`),
  CONSTRAINT `FK-83_001` FOREIGN KEY (`deptCode`) REFERENCES `departments` (`deptCode`),
  CONSTRAINT `FK-83_002` FOREIGN KEY (`employeeNumber`) REFERENCES `employees` (`employeeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `non_salesrepresentatives`
--

LOCK TABLES `non_salesrepresentatives` WRITE;
/*!40000 ALTER TABLE `non_salesrepresentatives` DISABLE KEYS */;
INSERT INTO `non_salesrepresentatives` VALUES (1002,403,NULL,NULL),(1056,401,NULL,NULL),(1076,402,NULL,NULL),(1088,401,NULL,NULL),(1102,401,NULL,NULL),(1143,401,NULL,NULL),(20242703,401,NULL,NULL),(20242706,401,NULL,NULL),(20242708,401,NULL,NULL),(20242711,2001,NULL,NULL),(20242716,2001,NULL,NULL),(20242725,2001,NULL,NULL),(20242727,2002,NULL,NULL),(20242730,2002,NULL,NULL),(20242732,2001,NULL,NULL),(20242733,2001,NULL,NULL);
/*!40000 ALTER TABLE `non_salesrepresentatives` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Non_SalesRepresentatives_BEFORE_INSERT` BEFORE INSERT ON `non_salesrepresentatives` FOR EACH ROW BEGIN
	IF isDeactivated(NEW.employeeNumber) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 30A4: Employee Record is Deactivated';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Non_SalesRepresentatives_AFTER_INSERT` AFTER INSERT ON `non_salesrepresentatives` FOR EACH ROW BEGIN
	INSERT INTO Non_SalesRepresentatives_audit VALUES (new.employeeNumber, now(), 'C', NULL, new.deptCode, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Non_SalesRepresentatives_AFTER_UPDATE` AFTER UPDATE ON `non_salesrepresentatives` FOR EACH ROW BEGIN
	IF (old.employeeNumber <> new.employeeNumber) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bank ID cannot be modified';
	END IF;
	INSERT INTO Non_SalesRepresentatives_audit VALUES (new.employeeNumber, now(), 'U', old.deptCode, new.deptCode, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Non_SalesRepresentatives_BEFORE_DELETE` BEFORE DELETE ON `non_salesrepresentatives` FOR EACH ROW BEGIN
	INSERT INTO Non_SalesRepresentatives_audit VALUES (old.employeeNumber, now(), 'D', old.deptCode, NULL, NULL, 'Deletion of Record');

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `non_salesrepresentatives_audit`
--

DROP TABLE IF EXISTS `non_salesrepresentatives_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `non_salesrepresentatives_audit` (
  `employeeNumber` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_deptCode` int DEFAULT NULL,
  `new_deptCode` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeNumber`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `non_salesrepresentatives_audit`
--

LOCK TABLES `non_salesrepresentatives_audit` WRITE;
/*!40000 ALTER TABLE `non_salesrepresentatives_audit` DISABLE KEYS */;
INSERT INTO `non_salesrepresentatives_audit` VALUES (1002,'2024-07-20 03:43:22','C',NULL,403,NULL,NULL),(1056,'2024-07-20 03:43:22','C',NULL,401,NULL,NULL),(1076,'2024-07-20 03:43:22','C',NULL,402,NULL,NULL),(1088,'2024-07-20 03:43:22','C',NULL,401,NULL,NULL),(1102,'2024-07-20 03:43:22','C',NULL,401,NULL,NULL),(1143,'2024-07-20 03:43:22','C',NULL,401,NULL,NULL),(20242703,'2024-07-20 03:43:22','C',NULL,401,NULL,NULL),(20242706,'2024-07-20 03:43:22','C',NULL,401,NULL,NULL),(20242708,'2024-07-20 03:43:22','C',NULL,401,NULL,NULL),(20242711,'2024-07-20 03:43:22','C',NULL,2001,NULL,NULL),(20242716,'2024-07-20 03:43:22','C',NULL,2001,NULL,NULL),(20242725,'2024-07-20 03:43:22','C',NULL,2001,NULL,NULL),(20242727,'2024-07-20 03:43:22','C',NULL,2002,NULL,NULL),(20242730,'2024-07-20 03:43:22','C',NULL,2002,NULL,NULL),(20242732,'2024-07-20 03:43:22','C',NULL,2001,NULL,NULL),(20242733,'2024-07-20 03:43:22','C',NULL,2001,NULL,NULL);
/*!40000 ALTER TABLE `non_salesrepresentatives_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offices`
--

DROP TABLE IF EXISTS `offices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offices` (
  `officeCode` varchar(10) NOT NULL,
  `city` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `postalCode` varchar(15) NOT NULL,
  `territory` varchar(10) NOT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`officeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offices`
--

LOCK TABLES `offices` WRITE;
/*!40000 ALTER TABLE `offices` DISABLE KEYS */;
INSERT INTO `offices` VALUES ('1','San Francisco','+1 650 219 4782','100 Market Street','Suite 300','CA','USA','94080','NA',NULL,NULL),('10','Boston','+1 215 837 0825','1550 Court Place','Suite 102','MA','USA','02107','NA',NULL,NULL),('2','NYC','+1 212 555 3000','523 East 53rd Street','apt. 5A','NY','USA','10022','NA',NULL,NULL),('3','Manila','435435656','20 Las Vegas St','L1','NCR','PH','1742','SEA',NULL,NULL),('3456','Las Pinas','+33 14 723 4404','30 Peso Lane','G1','NCR','PH','75017','SEA',NULL,NULL),('4','Paris','+33 14 723 4404','43 Rue Jouffroy D\'abbans',NULL,NULL,'France','75017','EMEA',NULL,NULL),('4560','Tokyo','+81 33 224 5000','4-1 Kioicho',NULL,'Chiyoda-Ku','Japan','102-8578','Japan',NULL,NULL),('4564','Sydney','+61 2 9264 2451','5-11 Wentworth Avenue','Floor #2',NULL,'Australia','NSW 2010','APAC',NULL,NULL),('4566','London','+44 20 7877 2041','25 Old Broad Street','Level 7',NULL,'UK','EC2N 1HN','EMEA',NULL,NULL);
/*!40000 ALTER TABLE `offices` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `offices_BEFORE_INSERT` BEFORE INSERT ON `offices` FOR EACH ROW BEGIN
	-- System Generated Controlled Value Identifier
    DECLARE newofficeCode VARCHAR(10);
    SELECT MIN(officeCode) INTO newofficeCode FROM offices_refidentifiers WHERE status = 'U';
    IF (newofficeCode IS NULL) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot generate new Office Code, reference IDs were already exhausted';
    END IF;
    UPDATE offices_refidentifiers SET status ='D' WHERE officeCode = newofficeCode;
    SET new.officeCode = newofficeCode;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `offices_AFTER_INSERT` AFTER INSERT ON `offices` FOR EACH ROW BEGIN
	INSERT INTO offices_audit VALUES(new.officeCode, now(), 'C', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, new.city, new.phone, new.addressLine1, new.addressLine2, new.state, new.country, new.postalCode, new.territory, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `offices_AFTER_UPDATE` AFTER UPDATE ON `offices` FOR EACH ROW BEGIN
	IF(old.officeCode <> new.officeCode) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'OfficeCode cannot be modified';
	END IF;
    INSERT INTO offices_audit VALUES(new.officeCode, now(), 'U', old.city, old.phone, old.addressLine1, old.addressLine2, old.state, old.country, old.postalCode, old.territory, new.city, new.phone, new.addressLine1, new.addressLine2, new.state, new.country, new.postalCode, new.territory, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `offices_BEFORE_DELETE` BEFORE DELETE ON `offices` FOR EACH ROW BEGIN
	INSERT INTO offices_audit VALUES(old.officeCode, now(), 'D', old.city, old.phone, old.addressLine1, old.addressLine2, old.state, old.country, old.postalCode, old.territory, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `offices_audit`
--

DROP TABLE IF EXISTS `offices_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offices_audit` (
  `officeCode` varchar(10) NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_city` varchar(50) DEFAULT NULL,
  `old_phone` varchar(50) DEFAULT NULL,
  `old_addressLine1` varchar(50) DEFAULT NULL,
  `old_addressLine2` varchar(50) DEFAULT NULL,
  `old_state` varchar(50) DEFAULT NULL,
  `old_country` varchar(50) DEFAULT NULL,
  `old_postalCode` varchar(15) DEFAULT NULL,
  `old_territory` varchar(10) DEFAULT NULL,
  `new_city` varchar(50) DEFAULT NULL,
  `new_phone` varchar(50) DEFAULT NULL,
  `new_addressLine1` varchar(50) DEFAULT NULL,
  `new_addressLine2` varchar(50) DEFAULT NULL,
  `new_state` varchar(50) DEFAULT NULL,
  `new_country` varchar(50) DEFAULT NULL,
  `new_postalCode` varchar(15) DEFAULT NULL,
  `new_territory` varchar(10) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`officeCode`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offices_audit`
--

LOCK TABLES `offices_audit` WRITE;
/*!40000 ALTER TABLE `offices_audit` DISABLE KEYS */;
INSERT INTO `offices_audit` VALUES ('1','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'San Francisco','+1 650 219 4782','100 Market Street','Suite 300','CA','USA','94080','NA',NULL,NULL),('10','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Boston','+1 215 837 0825','1550 Court Place','Suite 102','MA','USA','02107','NA',NULL,NULL),('2','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NYC','+1 212 555 3000','523 East 53rd Street','apt. 5A','NY','USA','10022','NA',NULL,NULL),('3','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Manila','435435656','20 Las Vegas St','L1','NCR','PH','1742','SEA',NULL,NULL),('3456','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Las Pinas','+33 14 723 4404','30 Peso Lane','G1','NCR','PH','75017','SEA',NULL,NULL),('4','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Paris','+33 14 723 4404','43 Rue Jouffroy D\'abbans',NULL,NULL,'France','75017','EMEA',NULL,NULL),('4560','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tokyo','+81 33 224 5000','4-1 Kioicho',NULL,'Chiyoda-Ku','Japan','102-8578','Japan',NULL,NULL),('4564','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sydney','+61 2 9264 2451','5-11 Wentworth Avenue','Floor #2',NULL,'Australia','NSW 2010','APAC',NULL,NULL),('4566','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'London','+44 20 7877 2041','25 Old Broad Street','Level 7',NULL,'UK','EC2N 1HN','EMEA',NULL,NULL);
/*!40000 ALTER TABLE `offices_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offices_refidentifiers`
--

DROP TABLE IF EXISTS `offices_refidentifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offices_refidentifiers` (
  `officeCode` varchar(10) NOT NULL,
  `status` enum('U','D') DEFAULT NULL,
  PRIMARY KEY (`officeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offices_refidentifiers`
--

LOCK TABLES `offices_refidentifiers` WRITE;
/*!40000 ALTER TABLE `offices_refidentifiers` DISABLE KEYS */;
INSERT INTO `offices_refidentifiers` VALUES ('1','D'),('10','D'),('2','D'),('3','D'),('3432','D'),('3455','D'),('3456','D'),('4','D'),('4560','D'),('4564','D'),('4566','D'),('5','U'),('5464','U'),('6','U'),('6756','U'),('7','U'),('8','U'),('9','U');
/*!40000 ALTER TABLE `offices_refidentifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails` (
  `orderNumber` int NOT NULL,
  `productCode` varchar(15) NOT NULL,
  `quantityOrdered` int NOT NULL,
  `priceEach` double NOT NULL,
  `orderLineNumber` smallint NOT NULL,
  `referenceNo` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`orderNumber`,`productCode`),
  KEY `FK0008_idx` (`productCode`),
  KEY `FK1009_idx` (`referenceNo`),
  CONSTRAINT `FK0001` FOREIGN KEY (`orderNumber`) REFERENCES `orders` (`orderNumber`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK0008` FOREIGN KEY (`productCode`) REFERENCES `current_products` (`productCode`),
  CONSTRAINT `FK1009` FOREIGN KEY (`referenceNo`) REFERENCES `shipments` (`referenceNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `orderdetails_BEFORE_INSERT` BEFORE INSERT ON `orderdetails` FOR EACH ROW BEGIN
	  -- Reference No must be empty
    SET new.referenceNo := NULL;
    
    -- Generate Line Number
    SET new.orderLineNumber := generateLineNumber(new.orderNumber);
    
    -- Check for Inventory
    IF (expectedQuantity(new.productCode, 0, new.quantityOrdered) < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "ERROR 90A1: Ordered quantity will cause below zero inventory quantity";
    END IF; 
    
    -- Check for Price Range
    IF (checkPrice(new.ProductCode, new.priceEach) = 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "ERROR 90A2: Price indicated is beyond price Range allowed for the product";
	END IF; 
    
    -- Once an order is completed then no activity on the order and the products ordered can be allowed.
    -- IF checkStatus(new.orderNumber, 'Completed') THEN
        -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 9007: No updates allowed after order is completed.';
    -- END IF;
	IF checkStatus(new.orderNumber, 'Cancelled') THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 90A5: Order has already been cancelled.';
	END IF;
    
	IF NOT checkStatus(new.orderNumber, 'In Process') THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 90A3: No updates allowed after order is shipped.';
	END IF;
    
    IF checkDiscontinued(new.productCode) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 90A4: Product is Discontinued.';
	END IF;
 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `orderdetails_AFTER_INSERT` AFTER INSERT ON `orderdetails` FOR EACH ROW BEGIN
    -- Update Inventory
    UPDATE current_products SET quantityInStock = quantityInStock - new.quantityOrdered 
    WHERE productCode = new.productCode;
    
    -- Create Audit Record
    INSERT INTO orderdetails_audit VALUES (new.orderNumber, new.productCode, NOW(), 'C',
										   NULL, NULL, NULL, NULL,
										   new.quantityOrdered, new.priceEach, new.orderLineNumber, new.referenceNo,
                                           new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `orderdetails_BEFORE_UPDATE` BEFORE UPDATE ON `orderdetails` FOR EACH ROW BEGIN
    
    IF checkStatus(new.orderNumber, 'Cancelled') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 90C1: Cannot update cancelled orders.';
    END IF;
    
    -- No updates on LineNumbers
    SET new.orderLineNumber := old.orderLineNumber;

    -- Restrict changes to Identifiers
    IF (new.orderNumber != old.orderNumber) OR (new.productCode != old.productCode) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "ERROR 90C2: Order Number and Product Code cannot be updated";
    END IF;
    
    -- Check for Price Range
	IF (checkPrice(new.ProductCode, new.priceEach) = 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "ERROR 90C3: Price indicated is beyond price Range allowed for the product";
        -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = new.priceEach;
	END IF;

    -- Determine difference of updated quantity
    IF (expectedQuantity(new.productCode, old.quantityOrdered, new.quantityOrdered) < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "ERROR 90C4: Ordered quantity will cause below zero inventory quantity";
    END IF;    
    
    IF (NEW.referenceNo != OLD.referenceNo) OR (NEW.referenceNo IS NOT NULL AND OLD.referenceNo IS NULL) THEN
		IF NOT checkStatus(old.orderNumber, 'Shipped') THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 90C7: Reference number can only be updated when the order status is shipped.';
        END IF;
    ELSEIF NOT checkStatus(old.orderNumber, 'In Process') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 90C6: No updates allowed after order is shipped.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `orderdetails_AFTER_UPDATE` AFTER UPDATE ON `orderdetails` FOR EACH ROW BEGIN
    
   -- Update Inventory when order cancelled.
    IF (NEW.end_userreason = 'Order Cancelled') THEN
        UPDATE current_products
        SET quantityInStock = computeNewStock(OLD.productCode, OLD.quantityOrdered), 
			end_username = "System", end_userreason = "Order Cancelled"
        WHERE productCode = NEW.productCode;
	ELSE
    -- Update Inventory
    UPDATE current_products SET quantityInStock = expectedQuantity(new.productCode, old.quantityOrdered, new.quantityOrdered)
    WHERE productCode = new.productCode;
    
    END IF;

	-- Create Audit Record
    INSERT INTO orderdetails_audit VALUES (new.orderNumber, new.productCode, NOW(), 'U',
										   old.quantityOrdered, old.priceEach, old.orderLineNumber, old.referenceNo,
										   new.quantityOrdered, new.priceEach, new.orderLineNumber, new.referenceNo,
                                           new.end_username, new.end_userreason); 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `orderdetails_BEFORE_DELETE` BEFORE DELETE ON `orderdetails` FOR EACH ROW BEGIN
    -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 90E0: Cannot delete order details'; 
    
    
    -- Unable to delete if status is Cancelled
    -- SELECT status INTO orderStatus FROM orders WHERE old.orderNumber = orderNumber;
    
    /*IF orderStatus = 'Cancelled' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERROR 90E1: Cannot delete cancelled orders.';
    END IF;
    
    
    IF NOT checkStatus(old.orderNumber, 'In Process')	THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 90E2: Cannot delete shipped products'; 
	END IF;
        
	-- Create Audit Record
    INSERT INTO orderdetails_audit VALUES (old.orderNumber, old.productCode, NOW(), 'D',
										   old.quantityOrdered, old.priceEach, old.orderLineNumber, old.referenceNo,
										   NULL, NULL, NULL, NULL,
                                           old.end_username, 'Cancelled'); */
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `orderdetails_audit`
--

DROP TABLE IF EXISTS `orderdetails_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails_audit` (
  `orderNumber` int NOT NULL,
  `productCode` varchar(45) NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_quantityOrdered` int DEFAULT NULL,
  `old_priceEach` double DEFAULT NULL,
  `old_orderLineNumber` smallint DEFAULT NULL,
  `old_referenceNo` int DEFAULT NULL,
  `new_quantityOrdered` int DEFAULT NULL,
  `new_priceEach` double DEFAULT NULL,
  `new_orderLineNumber` smallint DEFAULT NULL,
  `new_referenceNo` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`orderNumber`,`productCode`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails_audit`
--

LOCK TABLES `orderdetails_audit` WRITE;
/*!40000 ALTER TABLE `orderdetails_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderdetails_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `orderNumber` int NOT NULL,
  `orderDate` datetime NOT NULL,
  `requiredDate` datetime NOT NULL,
  `shippedDate` datetime DEFAULT NULL,
  `status` varchar(15) NOT NULL,
  `comments` text,
  `customerNumber` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`orderNumber`),
  KEY `FK0002_idx` (`customerNumber`),
  CONSTRAINT `FK0002` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `orders_BEFORE_INSERT` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN

	-- OrderNumber Generation
    DECLARE new_ordernumber	INT;
    SELECT MAX(orderNumber)+1 INTO new_ordernumber FROM orders_audit;
    IF (new_ordernumber IS NULL) THEN
		SET new_ordernumber := 700001;
    END IF;
    SET new.orderNumber := new_ordernumber;
    
    -- OrderDate must be System Date
    SET new.orderDate := NOW();
    
    -- Check for Delivery Date
    IF (DATEDIFF(new.requiredDate, new.orderdate) < 3) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Error 91A1: Required Date must be at least three days";
    END IF;
    
    -- Status must be in Process
    SET new.status := 'In Process';
	
    -- When the status of the order is “shipped” should a shipped date be allowed to have a value. 
    SET new.shippedDate := NULL;
 
        
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `orders_AFTER_INSERT` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
	-- Create Audit Record
	INSERT INTO orders_audit VALUES (new.orderNumber, NOW(), 'C',
									 NULL, NULL, NULL, NULL, NULL, NULL,
                                     new.orderDate, new.requiredDate, new.shippedDate, new.status, new.comments, new.customerNumber, 
                                     new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `orders_BEFORE_DELETE` BEFORE DELETE ON `orders` FOR EACH ROW BEGIN
	-- Create Audit Record
    -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 91E0: Cannot delete order records'; 
    
	/*IF checkStatus(old.orderNumber, 'Completed') THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'ERROR 91E1: Cannot delete shipped products'; 
	END IF;*/
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `orders_audit`
--

DROP TABLE IF EXISTS `orders_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_audit` (
  `orderNumber` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_orderDate` datetime DEFAULT NULL,
  `old_requiredDate` datetime DEFAULT NULL,
  `old_shippedDate` datetime DEFAULT NULL,
  `old_status` varchar(15) DEFAULT NULL,
  `old_comments` text,
  `old_customerNumber` int DEFAULT NULL,
  `new_orderDate` datetime DEFAULT NULL,
  `new_requiredDate` datetime DEFAULT NULL,
  `new_shippedDate` datetime DEFAULT NULL,
  `new_status` varchar(15) DEFAULT NULL,
  `new_comments` text,
  `new_customerNumber` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`orderNumber`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_audit`
--

LOCK TABLES `orders_audit` WRITE;
/*!40000 ALTER TABLE `orders_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_orders`
--

DROP TABLE IF EXISTS `payment_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_orders` (
  `customerNumber` int NOT NULL,
  `paymentTimestamp` datetime NOT NULL,
  `orderNumber` int NOT NULL,
  `amountpaid` decimal(9,2) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customerNumber`,`paymentTimestamp`,`orderNumber`),
  KEY `FK-69_001_idx` (`orderNumber`),
  CONSTRAINT `FK-69_001` FOREIGN KEY (`orderNumber`) REFERENCES `orders` (`orderNumber`),
  CONSTRAINT `FK-69_002` FOREIGN KEY (`customerNumber`, `paymentTimestamp`) REFERENCES `payments` (`customerNumber`, `paymentTimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_orders`
--

LOCK TABLES `payment_orders` WRITE;
/*!40000 ALTER TABLE `payment_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `payment_orders_BEFORE_INSERT` BEFORE INSERT ON `payment_orders` FOR EACH ROW BEGIN
	-- System Generated Identifier
    SET new.paymentTimestamp := NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `payment_orders_AFTER_INSERT` AFTER INSERT ON `payment_orders` FOR EACH ROW BEGIN
    -- Inserting into audit table
	INSERT INTO payment_orders_audit VALUES(new.customerNumber, new.paymentTimestamp, new.orderNumber, now(), 'C', NULL, new.amountpaid, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `payment_orders_AFTER_UPDATE` AFTER UPDATE ON `payment_orders` FOR EACH ROW BEGIN
	IF(new.customerNumber<>old.customerNumber) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer Number cannot be modified!';
    END IF;
    IF(new.paymentTimestamp<>old.paymentTimestamp) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Payment Timestamp cannot be modified!';
	END IF;
    IF(new.orderNumber<>old.orderNumber) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order Number cannot be modified!';
	END IF;
	INSERT INTO payment_orders_audit VALUES(new.customerNumber, new.paymentTimestamp, new.orderNumber, now(), 'U', old.amountpaid, new.amountpaid, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `payment_orders_BEFORE_DELETE` BEFORE DELETE ON `payment_orders` FOR EACH ROW BEGIN
	INSERT INTO payment_orders_audit VALUES(old.customerNumber, old.paymentTimestamp, old.orderNumber, now(), 'D', old.amountpaid, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `payment_orders_audit`
--

DROP TABLE IF EXISTS `payment_orders_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_orders_audit` (
  `customerNumber` int NOT NULL,
  `paymentTimestamp` datetime NOT NULL,
  `orderNumber` int NOT NULL,
  `audit_timestamp` datetime DEFAULT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_amountpaid` decimal(9,2) DEFAULT NULL,
  `new_amountpaid` decimal(9,2) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customerNumber`,`paymentTimestamp`,`orderNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_orders_audit`
--

LOCK TABLES `payment_orders_audit` WRITE;
/*!40000 ALTER TABLE `payment_orders_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_orders_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `customerNumber` int NOT NULL,
  `paymentTimestamp` datetime NOT NULL,
  `paymentType` enum('S','H','C') NOT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customerNumber`,`paymentTimestamp`),
  CONSTRAINT `FK0007` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `payments_BEFORE_INSERT` BEFORE INSERT ON `payments` FOR EACH ROW BEGIN
	-- System Generated Identifier
    SET new.paymentTimestamp := NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `payments_AFTER_INSERT` AFTER INSERT ON `payments` FOR EACH ROW BEGIN
	INSERT INTO payments_audit VALUES(new.customerNumber, new.paymentTimestamp, now(), 'C', NULL, new.paymentType, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `payments_AFTER_UPDATE` AFTER UPDATE ON `payments` FOR EACH ROW BEGIN
	IF(old.customerNumber<>new.customerNumber) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer Number cannot be modified!';
	END IF;
    IF(old.paymentTimestamp<>new.paymentTimestamp) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Payment Timestamp cannot be modified!';
	END IF;
    INSERT INTO payments_audit VALUES(new.customerNumber, new.paymentTimestamp, now(), 'U', old.paymentType, new.paymentType, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `payments_BEFORE_DELETE` BEFORE DELETE ON `payments` FOR EACH ROW BEGIN
	INSERT INTO payments_audit VALUES(old.customerNumber, old.paymentTimestamp, now(), 'D', old.paymentType, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `payments_audit`
--

DROP TABLE IF EXISTS `payments_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments_audit` (
  `customerNumber` int NOT NULL,
  `paymentTimestamp` datetime NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_paymentType` enum('S','H','C') DEFAULT NULL,
  `new_paymentType` enum('S','H','C') DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customerNumber`,`paymentTimestamp`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments_audit`
--

LOCK TABLES `payments_audit` WRITE;
/*!40000 ALTER TABLE `payments_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_pricing`
--

DROP TABLE IF EXISTS `product_pricing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_pricing` (
  `productCode` varchar(15) NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date DEFAULT NULL,
  `MSRP` decimal(9,2) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`,`startdate`),
  CONSTRAINT `FK-96_001` FOREIGN KEY (`productCode`) REFERENCES `product_retail` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_pricing`
--

LOCK TABLES `product_pricing` WRITE;
/*!40000 ALTER TABLE `product_pricing` DISABLE KEYS */;
INSERT INTO `product_pricing` VALUES ('100009','2024-07-20','2024-07-17',100.00,'test4ba','test4ba'),('S700_3167','2024-07-20','2024-10-30',100.00,NULL,NULL),('S700_3505','2024-07-20','2024-10-30',123.00,NULL,NULL),('S700_3962','2024-07-20','2024-10-30',164.00,NULL,NULL),('XX00001','2024-07-20','2024-10-05',165.00,NULL,NULL),('XX00002','2024-07-20','2024-10-30',193.00,NULL,NULL),('XX00004','2024-07-20','2024-07-13',200.00,'mark@toys.com','new product'),('XX00005','2024-07-20','2024-07-13',200.00,'mark1@toys.com','Add new product'),('XX00006','2024-07-20','2024-10-13',200.00,'mark1@toys.com','Add new product');
/*!40000 ALTER TABLE `product_pricing` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_pricing_BEFORE_INSERT` BEFORE INSERT ON `product_pricing` FOR EACH ROW BEGIN
	SET new.startDate := now();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_pricing_AFTER_INSERT` AFTER INSERT ON `product_pricing` FOR EACH ROW BEGIN
	INSERT INTO product_pricing_audit VALUES(new.productCode, new.startdate, now(), 'C', NULL, NULL, new.endDate, new.MSRP, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_pricing_AFTER_UPDATE` AFTER UPDATE ON `product_pricing` FOR EACH ROW BEGIN
	IF (old.productCode <> new.productCode OR old.startdate <> new.startdate) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "productCode or startdate cannot be modified";
	END IF;
	INSERT INTO product_pricing_audit VALUES(new.productCode, new.startdate, now(), 'U', old.endDate, old.MSRP, new.endDate, new.MSRP, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_pricing_BEFORE_DELETE` BEFORE DELETE ON `product_pricing` FOR EACH ROW BEGIN
	INSERT INTO product_pricing_audit VALUES(old.productCode, old.startdate, now(), 'D', old.endDate, old.MSRP , NULL, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `product_pricing_audit`
--

DROP TABLE IF EXISTS `product_pricing_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_pricing_audit` (
  `productCode` varchar(15) NOT NULL,
  `startDate` date NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_endDate` date DEFAULT NULL,
  `old_MSRP` decimal(9,2) DEFAULT NULL,
  `new_endDate` date DEFAULT NULL,
  `new_MSRP` decimal(9,2) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`,`startDate`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_pricing_audit`
--

LOCK TABLES `product_pricing_audit` WRITE;
/*!40000 ALTER TABLE `product_pricing_audit` DISABLE KEYS */;
INSERT INTO `product_pricing_audit` VALUES ('100009','2024-07-20','2024-07-20 03:43:23','C',NULL,NULL,'2024-07-17',100.00,'test4ba','test4ba'),('S700_3167','2024-07-20','2024-07-20 03:43:23','C',NULL,NULL,'2024-10-30',100.00,NULL,NULL),('S700_3505','2024-07-20','2024-07-20 03:43:23','C',NULL,NULL,'2024-10-30',123.00,NULL,NULL),('S700_3962','2024-07-20','2024-07-20 03:43:23','C',NULL,NULL,'2024-10-30',164.00,NULL,NULL),('XX00001','2024-07-20','2024-07-20 03:43:23','C',NULL,NULL,'2024-10-05',165.00,NULL,NULL),('XX00002','2024-07-20','2024-07-20 03:43:23','C',NULL,NULL,'2024-10-30',193.00,NULL,NULL),('XX00004','2024-07-20','2024-07-20 03:43:23','C',NULL,NULL,'2024-07-13',200.00,'mark@toys.com','new product'),('XX00005','2024-07-20','2024-07-20 03:43:23','C',NULL,NULL,'2024-07-13',200.00,'mark1@toys.com','Add new product'),('XX00006','2024-07-20','2024-07-20 03:43:23','C',NULL,NULL,'2024-10-13',200.00,'mark1@toys.com','Add new product');
/*!40000 ALTER TABLE `product_pricing_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_productlines`
--

DROP TABLE IF EXISTS `product_productlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_productlines` (
  `productCode` varchar(15) NOT NULL,
  `productLine` varchar(50) NOT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`,`productLine`),
  KEY `FK-97_002_idx` (`productLine`),
  CONSTRAINT `FK-97_001` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`),
  CONSTRAINT `FK-97_002` FOREIGN KEY (`productLine`) REFERENCES `productlines` (`productLine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_productlines`
--

LOCK TABLES `product_productlines` WRITE;
/*!40000 ALTER TABLE `product_productlines` DISABLE KEYS */;
INSERT INTO `product_productlines` VALUES ('100009','Classic Cars','test4ba','test4ba'),('100010','Classic Cars','test4ba','test4ba'),('S10_1678','Motorcycles',NULL,NULL),('S10_1949','Classic Cars',NULL,NULL),('S10_2016','Motorcycles',NULL,NULL),('S10_4698','Motorcycles',NULL,NULL),('S10_4757','Classic Cars',NULL,NULL),('S10_4962','Classic Cars',NULL,NULL),('S12_1099','Classic Cars',NULL,NULL),('S12_1108','Classic Cars',NULL,NULL),('S12_1666','Trucks and Buses',NULL,NULL),('S12_2823','Motorcycles',NULL,NULL),('S12_3148','Classic Cars',NULL,NULL),('S12_3380','Classic Cars',NULL,NULL),('S12_3891','Classic Cars',NULL,NULL),('S12_3990','Classic Cars',NULL,NULL),('S12_4473','Trucks and Buses',NULL,NULL),('S12_4675','Classic Cars',NULL,NULL),('S18_1097','Trucks and Buses',NULL,NULL),('S18_1129','Classic Cars',NULL,NULL),('S18_1342','Vintage Cars',NULL,NULL),('S18_1367','Vintage Cars',NULL,NULL),('S18_1589','Classic Cars',NULL,NULL),('S18_1662','Planes',NULL,NULL),('S18_1749','Vintage Cars',NULL,NULL),('S18_1889','Classic Cars',NULL,NULL),('S18_1984','Classic Cars',NULL,NULL),('S18_2238','Classic Cars',NULL,NULL),('S18_2248','Vintage Cars',NULL,NULL),('S18_2319','Trucks and Buses',NULL,NULL),('S18_2325','Vintage Cars',NULL,NULL),('S18_2432','Trucks and Buses',NULL,NULL),('S18_2581','Planes',NULL,NULL),('S18_2625','Motorcycles',NULL,NULL),('S18_2795','Vintage Cars',NULL,NULL),('S18_2870','Classic Cars',NULL,NULL),('S18_2949','Vintage Cars',NULL,NULL),('S18_2957','Vintage Cars',NULL,NULL),('S18_3029','Ships',NULL,NULL),('S18_3136','Vintage Cars',NULL,NULL),('S18_3140','Vintage Cars',NULL,NULL),('S18_3232','Classic Cars',NULL,NULL),('S18_3233','Classic Cars',NULL,NULL),('S18_3259','Trains',NULL,NULL),('S18_3278','Classic Cars',NULL,NULL),('S18_3320','Vintage Cars',NULL,NULL),('S18_3482','Classic Cars',NULL,NULL),('S18_3685','Classic Cars',NULL,NULL),('S18_3782','Motorcycles',NULL,NULL),('S18_3856','Vintage Cars',NULL,NULL),('S18_4027','Classic Cars',NULL,NULL),('S18_4409','Vintage Cars',NULL,NULL),('S18_4522','Vintage Cars',NULL,NULL),('S18_4600','Trucks and Buses',NULL,NULL),('S18_4668','Vintage Cars',NULL,NULL),('S18_4721','Classic Cars',NULL,NULL),('S18_4933','Classic Cars',NULL,NULL),('S24_1046','Classic Cars',NULL,NULL),('S24_1444','Classic Cars',NULL,NULL),('S24_1578','Motorcycles',NULL,NULL),('S24_1628','Classic Cars',NULL,NULL),('S24_1785','Planes',NULL,NULL),('S24_1937','Vintage Cars',NULL,NULL),('S24_2000','Motorcycles',NULL,NULL),('S24_2011','Ships',NULL,NULL),('S24_2022','Vintage Cars',NULL,NULL),('S24_2300','Trucks and Buses',NULL,NULL),('S24_2360','Motorcycles',NULL,NULL),('S24_2766','Classic Cars',NULL,NULL),('S24_2840','Classic Cars',NULL,NULL),('S24_2841','Planes',NULL,NULL),('S24_2887','Classic Cars',NULL,NULL),('S24_2972','Classic Cars',NULL,NULL),('S24_3151','Vintage Cars',NULL,NULL),('S24_3191','Classic Cars',NULL,NULL),('S24_3371','Classic Cars',NULL,NULL),('S24_3420','Vintage Cars',NULL,NULL),('S24_3432','Classic Cars',NULL,NULL),('S24_3816','Vintage Cars',NULL,NULL),('S24_3856','Classic Cars',NULL,NULL),('S24_3949','Planes',NULL,NULL),('S24_3969','Vintage Cars',NULL,NULL),('S24_4048','Classic Cars',NULL,NULL),('S24_4258','Vintage Cars',NULL,NULL),('S24_4278','Planes',NULL,NULL),('S24_4620','Classic Cars',NULL,NULL),('S32_1268','Trucks and Buses',NULL,NULL),('S32_1374','Motorcycles',NULL,NULL),('S32_2206','Motorcycles',NULL,NULL),('S32_2509','Trucks and Buses',NULL,NULL),('S32_3207','Trains',NULL,NULL),('S32_3522','Trucks and Buses',NULL,NULL),('S32_4289','Vintage Cars',NULL,NULL),('S32_4485','Motorcycles',NULL,NULL),('S50_1341','Vintage Cars',NULL,NULL),('S50_1392','Trucks and Buses',NULL,NULL),('S50_1514','Trains',NULL,NULL),('S50_4713','Motorcycles',NULL,NULL),('S700_1138','Ships',NULL,NULL),('S700_1691','Planes',NULL,NULL),('S700_1938','Ships',NULL,NULL),('S700_2047','Ships',NULL,NULL),('S700_2466','Planes',NULL,NULL),('S700_2610','Ships',NULL,NULL),('S700_2824','Classic Cars',NULL,NULL),('S700_2834','Planes',NULL,NULL),('S700_3167','Planes',NULL,NULL),('S700_3505','Ships',NULL,NULL),('S700_3962','Ships',NULL,NULL),('S700_4002','Planes',NULL,NULL),('S72_1253','Planes',NULL,NULL),('S72_3212','Ships',NULL,NULL),('XX00001','Life Size Replicas',NULL,NULL),('XX00002','Life Size Replicas',NULL,NULL),('XX00003','Life Size Replicas',NULL,NULL),('XX00004','bricks','mark@toys.com','new product'),('XX00005','Classic Cars','mark1@toys.com','Add new product'),('XX00006','Classic Cars','mark1@toys.com','Additional productline'),('XX00006','Muscle Cars','mark1@toys.com','Add new product'),('XX00007','Pickup Trucks','mike1@toys.com','new product');
/*!40000 ALTER TABLE `product_productlines` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_productlines_AFTER_INSERT` AFTER INSERT ON `product_productlines` FOR EACH ROW BEGIN
	INSERT INTO product_productlines_audit VALUES(new.productCode, new.productLine, now(), 'C', new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_productlines_AFTER_UPDATE` AFTER UPDATE ON `product_productlines` FOR EACH ROW BEGIN
	-- IF (old.productCode <> new.productCode OR old.productLine <> new.productLine ) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "productCode or productLine cannot be modified";
	-- END IF;

	-- INSERT INTO product_productlines_audit VALUES(new.productCode, new.productLine, now(), 'U');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_productlines_BEFORE_DELETE` BEFORE DELETE ON `product_productlines` FOR EACH ROW BEGIN
	INSERT INTO product_productlines_audit VALUES(old.productCode, old.productLine, now(), 'D', NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `product_productlines_audit`
--

DROP TABLE IF EXISTS `product_productlines_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_productlines_audit` (
  `productCode` varchar(15) NOT NULL,
  `productLine` varchar(50) NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`,`productLine`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_productlines_audit`
--

LOCK TABLES `product_productlines_audit` WRITE;
/*!40000 ALTER TABLE `product_productlines_audit` DISABLE KEYS */;
INSERT INTO `product_productlines_audit` VALUES ('100009','Classic Cars','2024-07-20 03:43:23','C','test4ba','test4ba'),('100010','Classic Cars','2024-07-20 03:43:23','C','test4ba','test4ba'),('S10_1678','Motorcycles','2024-07-20 03:43:23','C',NULL,NULL),('S10_1949','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S10_2016','Motorcycles','2024-07-20 03:43:23','C',NULL,NULL),('S10_4698','Motorcycles','2024-07-20 03:43:23','C',NULL,NULL),('S10_4757','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S10_4962','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S12_1099','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S12_1108','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S12_1666','Trucks and Buses','2024-07-20 03:43:23','C',NULL,NULL),('S12_2823','Motorcycles','2024-07-20 03:43:23','C',NULL,NULL),('S12_3148','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S12_3380','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S12_3891','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S12_3990','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S12_4473','Trucks and Buses','2024-07-20 03:43:23','C',NULL,NULL),('S12_4675','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_1097','Trucks and Buses','2024-07-20 03:43:23','C',NULL,NULL),('S18_1129','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_1342','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_1367','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_1589','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_1662','Planes','2024-07-20 03:43:23','C',NULL,NULL),('S18_1749','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_1889','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_1984','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_2238','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_2248','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_2319','Trucks and Buses','2024-07-20 03:43:23','C',NULL,NULL),('S18_2325','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_2432','Trucks and Buses','2024-07-20 03:43:23','C',NULL,NULL),('S18_2581','Planes','2024-07-20 03:43:23','C',NULL,NULL),('S18_2625','Motorcycles','2024-07-20 03:43:23','C',NULL,NULL),('S18_2795','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_2870','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_2949','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_2957','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_3029','Ships','2024-07-20 03:43:23','C',NULL,NULL),('S18_3136','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_3140','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_3232','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_3233','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_3259','Trains','2024-07-20 03:43:23','C',NULL,NULL),('S18_3278','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_3320','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_3482','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_3685','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_3782','Motorcycles','2024-07-20 03:43:23','C',NULL,NULL),('S18_3856','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_4027','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_4409','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_4522','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_4600','Trucks and Buses','2024-07-20 03:43:23','C',NULL,NULL),('S18_4668','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_4721','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S18_4933','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_1046','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_1444','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_1578','Motorcycles','2024-07-20 03:43:23','C',NULL,NULL),('S24_1628','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_1785','Planes','2024-07-20 03:43:23','C',NULL,NULL),('S24_1937','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_2000','Motorcycles','2024-07-20 03:43:23','C',NULL,NULL),('S24_2011','Ships','2024-07-20 03:43:23','C',NULL,NULL),('S24_2022','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_2300','Trucks and Buses','2024-07-20 03:43:23','C',NULL,NULL),('S24_2360','Motorcycles','2024-07-20 03:43:23','C',NULL,NULL),('S24_2766','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_2840','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_2841','Planes','2024-07-20 03:43:23','C',NULL,NULL),('S24_2887','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_2972','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_3151','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_3191','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_3371','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_3420','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_3432','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_3816','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_3856','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_3949','Planes','2024-07-20 03:43:23','C',NULL,NULL),('S24_3969','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_4048','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_4258','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S24_4278','Planes','2024-07-20 03:43:23','C',NULL,NULL),('S24_4620','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S32_1268','Trucks and Buses','2024-07-20 03:43:23','C',NULL,NULL),('S32_1374','Motorcycles','2024-07-20 03:43:23','C',NULL,NULL),('S32_2206','Motorcycles','2024-07-20 03:43:23','C',NULL,NULL),('S32_2509','Trucks and Buses','2024-07-20 03:43:23','C',NULL,NULL),('S32_3207','Trains','2024-07-20 03:43:23','C',NULL,NULL),('S32_3522','Trucks and Buses','2024-07-20 03:43:23','C',NULL,NULL),('S32_4289','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S32_4485','Motorcycles','2024-07-20 03:43:23','C',NULL,NULL),('S50_1341','Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL),('S50_1392','Trucks and Buses','2024-07-20 03:43:23','C',NULL,NULL),('S50_1514','Trains','2024-07-20 03:43:23','C',NULL,NULL),('S50_4713','Motorcycles','2024-07-20 03:43:23','C',NULL,NULL),('S700_1138','Ships','2024-07-20 03:43:23','C',NULL,NULL),('S700_1691','Planes','2024-07-20 03:43:23','C',NULL,NULL),('S700_1938','Ships','2024-07-20 03:43:23','C',NULL,NULL),('S700_2047','Ships','2024-07-20 03:43:23','C',NULL,NULL),('S700_2466','Planes','2024-07-20 03:43:23','C',NULL,NULL),('S700_2610','Ships','2024-07-20 03:43:23','C',NULL,NULL),('S700_2824','Classic Cars','2024-07-20 03:43:23','C',NULL,NULL),('S700_2834','Planes','2024-07-20 03:43:23','C',NULL,NULL),('S700_3167','Planes','2024-07-20 03:43:23','C',NULL,NULL),('S700_3505','Ships','2024-07-20 03:43:23','C',NULL,NULL),('S700_3962','Ships','2024-07-20 03:43:23','C',NULL,NULL),('S700_4002','Planes','2024-07-20 03:43:23','C',NULL,NULL),('S72_1253','Planes','2024-07-20 03:43:23','C',NULL,NULL),('S72_3212','Ships','2024-07-20 03:43:23','C',NULL,NULL),('XX00001','Life Size Replicas','2024-07-20 03:43:23','C',NULL,NULL),('XX00002','Life Size Replicas','2024-07-20 03:43:23','C',NULL,NULL),('XX00003','Life Size Replicas','2024-07-20 03:43:23','C',NULL,NULL),('XX00004','bricks','2024-07-20 03:43:23','C','mark@toys.com','new product'),('XX00005','Classic Cars','2024-07-20 03:43:23','C','mark1@toys.com','Add new product'),('XX00006','Classic Cars','2024-07-20 03:43:23','C','mark1@toys.com','Additional productline'),('XX00006','Muscle Cars','2024-07-20 03:43:23','C','mark1@toys.com','Add new product'),('XX00007','Pickup Trucks','2024-07-20 03:43:23','C','mike1@toys.com','new product');
/*!40000 ALTER TABLE `product_productlines_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_retail`
--

DROP TABLE IF EXISTS `product_retail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_retail` (
  `productCode` varchar(15) NOT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`),
  CONSTRAINT `FK-94_001` FOREIGN KEY (`productCode`) REFERENCES `current_products` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_retail`
--

LOCK TABLES `product_retail` WRITE;
/*!40000 ALTER TABLE `product_retail` DISABLE KEYS */;
INSERT INTO `product_retail` VALUES ('100009','test4ba','test4ba'),('S700_3167',NULL,NULL),('S700_3505',NULL,NULL),('S700_3962',NULL,NULL),('XX00001',NULL,NULL),('XX00002',NULL,NULL),('XX00004','mark@toys.com','new product'),('XX00005','mark1@toys.com','Add new product'),('XX00006','mark1@toys.com','Add new product');
/*!40000 ALTER TABLE `product_retail` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_retail_BEFORE_INSERT` BEFORE INSERT ON `product_retail` FOR EACH ROW BEGIN
	IF getProductType(new.productCode)='W' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERROR 24A1: Wholesale products cannot be retail.';
    END IF;
    
    -- checkWholesale(new.productCode) or (
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_retail_AFTER_INSERT` AFTER INSERT ON `product_retail` FOR EACH ROW BEGIN
	INSERT INTO product_retail_audit VALUES(new.productCode, now(), 'C', new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_retail_AFTER_UPDATE` AFTER UPDATE ON `product_retail` FOR EACH ROW BEGIN
	-- IF (old.productCode <> new.productCode) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "productCode cannot be modified";
	-- END IF;

	-- INSERT INTO product_retail_audit VALUES(new.productCode, now(), 'U');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_retail_BEFORE_DELETE` BEFORE DELETE ON `product_retail` FOR EACH ROW BEGIN
	INSERT INTO product_retail_audit VALUES(old.productCode, now(), 'D', NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `product_retail_audit`
--

DROP TABLE IF EXISTS `product_retail_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_retail_audit` (
  `productCode` varchar(15) NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_retail_audit`
--

LOCK TABLES `product_retail_audit` WRITE;
/*!40000 ALTER TABLE `product_retail_audit` DISABLE KEYS */;
INSERT INTO `product_retail_audit` VALUES ('100009','2024-07-20 03:43:23','C','test4ba','test4ba'),('S700_3167','2024-07-20 03:43:23','C',NULL,NULL),('S700_3505','2024-07-20 03:43:23','C',NULL,NULL),('S700_3962','2024-07-20 03:43:23','C',NULL,NULL),('XX00001','2024-07-20 03:43:23','C',NULL,NULL),('XX00002','2024-07-20 03:43:23','C',NULL,NULL),('XX00004','2024-07-20 03:43:23','C','mark@toys.com','new product'),('XX00005','2024-07-20 03:43:23','C','mark1@toys.com','Add new product'),('XX00006','2024-07-20 03:43:23','C','mark1@toys.com','Add new product');
/*!40000 ALTER TABLE `product_retail_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_wholesale`
--

DROP TABLE IF EXISTS `product_wholesale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_wholesale` (
  `productCode` varchar(15) NOT NULL,
  `MSRP` decimal(9,2) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`),
  CONSTRAINT `FK-95_001` FOREIGN KEY (`productCode`) REFERENCES `current_products` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_wholesale`
--

LOCK TABLES `product_wholesale` WRITE;
/*!40000 ALTER TABLE `product_wholesale` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_wholesale` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_wholesale_BEFORE_INSERT` BEFORE INSERT ON `product_wholesale` FOR EACH ROW BEGIN
	IF getProductType(new.productCode) = 'R' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "ERROR 21A1: Product type is already in Retail";
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_wholesale_AFTER_INSERT` AFTER INSERT ON `product_wholesale` FOR EACH ROW BEGIN
	INSERT INTO product_wholesale_audit VALUES(new.productCode, now(), 'C', NULL, new.MSRP, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_wholesale_AFTER_UPDATE` AFTER UPDATE ON `product_wholesale` FOR EACH ROW BEGIN
	IF (old.productCode <> new.productCode ) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "productCode cannot be modified";
	END IF;

	INSERT INTO product_wholesale_audit VALUES(new.productCode, now(), 'U', old.MSRP, new.MSRP, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `product_wholesale_BEFORE_DELETE` BEFORE DELETE ON `product_wholesale` FOR EACH ROW BEGIN
	INSERT INTO product_wholesale_audit VALUES(old.productCode, now(), 'D', old.MSRP, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `product_wholesale_audit`
--

DROP TABLE IF EXISTS `product_wholesale_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_wholesale_audit` (
  `productCode` varchar(15) NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_MSRP` decimal(9,2) DEFAULT NULL,
  `new_MSRP` decimal(9,2) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_wholesale_audit`
--

LOCK TABLES `product_wholesale_audit` WRITE;
/*!40000 ALTER TABLE `product_wholesale_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_wholesale_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productlines`
--

DROP TABLE IF EXISTS `productlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productlines` (
  `productLine` varchar(50) NOT NULL,
  `textDescription` varchar(4000) DEFAULT NULL,
  `htmlDescription` mediumtext,
  `image` mediumblob,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productLine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productlines`
--

LOCK TABLES `productlines` WRITE;
/*!40000 ALTER TABLE `productlines` DISABLE KEYS */;
INSERT INTO `productlines` VALUES ('bricks','Only the Best is Good Enough',NULL,NULL,'mark@toys.com','Added from add_products'),('Classic Cars','Attention car enthusiasts: Make your wildest car ownership dreams come true. Whether you are looking for classic muscle cars, dream sports cars or movie-inspired miniatures, you will find great choices in this category. These replicas feature superb attention to detail and craftsmanship and offer features such as working steering system, opening forward compartment, opening rear trunk with removable spare wheel, 4-wheel independent spring suspension, and so on. The models range in size from 1:10 to 1:24 scale and include numerous limited edition and several out-of-production vehicles. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.',NULL,NULL,NULL,NULL),('Life Size Replicas',NULL,NULL,NULL,NULL,NULL),('Motorcycles','Our motorcycles are state of the art replicas of classic as well as contemporary motorcycle legends such as Harley Davidson, Ducati and Vespa. Models contain stunning details such as official logos, rotating wheels, working kickstand, front suspension, gear-shift lever, footbrake lever, and drive chain. Materials used include diecast and plastic. The models range in size from 1:10 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. All models come fully assembled and ready for display in the home or office. Most include a certificate of authenticity.',NULL,NULL,NULL,NULL),('Muscle Cars',NULL,NULL,NULL,'mark1@toys.com','Added from add_products'),('Pickup Trucks',NULL,NULL,NULL,'mike1@toys.com','Added from add_products'),('Planes','Unique, diecast airplane and helicopter replicas suitable for collections, as well as home, office or classroom decorations. Models contain stunning details such as official logos and insignias, rotating jet engines and propellers, retractable wheels, and so on. Most come fully assembled and with a certificate of authenticity from their manufacturers.',NULL,NULL,NULL,NULL),('Ships','The perfect holiday or anniversary gift for executives, clients, friends, and family. These handcrafted model ships are unique, stunning works of art that will be treasured for generations! They come fully assembled and ready for display in the home or office. We guarantee the highest quality, and best value.',NULL,NULL,NULL,NULL),('Trains','Model trains are a rewarding hobby for enthusiasts of all ages. Whether you\'re looking for collectible wooden trains, electric streetcars or locomotives, you\'ll find a number of great choices for any budget within this category. The interactive aspect of trains makes toy trains perfect for young children. The wooden train sets are ideal for children under the age of 5.',NULL,NULL,NULL,NULL),('Trucks and Buses','The Truck and Bus models are realistic replicas of buses and specialized trucks produced from the early 1920s to present. The models range in size from 1:12 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. Materials used include tin, diecast and plastic. All models include a certificate of authenticity from their manufacturers and are a perfect ornament for the home and office.',NULL,NULL,NULL,NULL),('Vintage Cars','Our Vintage Car models realistically portray automobiles produced from the early 1900s through the 1940s. Materials used include Bakelite, diecast, plastic and wood. Most of the replicas are in the 1:18 and 1:24 scale sizes, which provide the optimum in detail and accuracy. Prices range from $30.00 up to $180.00 for some special limited edition replicas. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `productlines` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `productlines_AFTER_INSERT` AFTER INSERT ON `productlines` FOR EACH ROW BEGIN
	INSERT INTO productlines_audit VALUES(new.productLine, now(), 'C', NULL, NULL, NULL, new.textDescription, new.htmlDescription, new.image, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `productlines_AFTER_UPDATE` AFTER UPDATE ON `productlines` FOR EACH ROW BEGIN
	IF (old.productLine <> new.productLine ) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "productLine cannot be modified";
	END IF;

	INSERT INTO productlines_audit VALUES(new.productLine, now(), 'U', old.textDescription, old.htmlDescription, old.image, new.textDescription, new.htmlDescription, new.image, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `productlines_BEFORE_DELETE` BEFORE DELETE ON `productlines` FOR EACH ROW BEGIN
	INSERT INTO productlines_audit VALUES(old.productLine, now(), 'D', old.textDescription, old.htmlDescription, old.image, NULL, NULL, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `productlines_audit`
--

DROP TABLE IF EXISTS `productlines_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productlines_audit` (
  `productLine` varchar(50) NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_textDescription` varchar(4000) DEFAULT NULL,
  `old_htmlDescription` mediumtext,
  `old_image` mediumblob,
  `new_textDescription` varchar(4000) DEFAULT NULL,
  `new_htmlDescription` mediumtext,
  `new_image` mediumblob,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productLine`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productlines_audit`
--

LOCK TABLES `productlines_audit` WRITE;
/*!40000 ALTER TABLE `productlines_audit` DISABLE KEYS */;
INSERT INTO `productlines_audit` VALUES ('bricks','2024-07-20 03:43:23','C',NULL,NULL,NULL,'Only the Best is Good Enough',NULL,NULL,'mark@toys.com','Added from add_products'),('Classic Cars','2024-07-20 03:43:23','C',NULL,NULL,NULL,'Attention car enthusiasts: Make your wildest car ownership dreams come true. Whether you are looking for classic muscle cars, dream sports cars or movie-inspired miniatures, you will find great choices in this category. These replicas feature superb attention to detail and craftsmanship and offer features such as working steering system, opening forward compartment, opening rear trunk with removable spare wheel, 4-wheel independent spring suspension, and so on. The models range in size from 1:10 to 1:24 scale and include numerous limited edition and several out-of-production vehicles. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.',NULL,NULL,NULL,NULL),('Life Size Replicas','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('Motorcycles','2024-07-20 03:43:23','C',NULL,NULL,NULL,'Our motorcycles are state of the art replicas of classic as well as contemporary motorcycle legends such as Harley Davidson, Ducati and Vespa. Models contain stunning details such as official logos, rotating wheels, working kickstand, front suspension, gear-shift lever, footbrake lever, and drive chain. Materials used include diecast and plastic. The models range in size from 1:10 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. All models come fully assembled and ready for display in the home or office. Most include a certificate of authenticity.',NULL,NULL,NULL,NULL),('Muscle Cars','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'mark1@toys.com','Added from add_products'),('Pickup Trucks','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'mike1@toys.com','Added from add_products'),('Planes','2024-07-20 03:43:23','C',NULL,NULL,NULL,'Unique, diecast airplane and helicopter replicas suitable for collections, as well as home, office or classroom decorations. Models contain stunning details such as official logos and insignias, rotating jet engines and propellers, retractable wheels, and so on. Most come fully assembled and with a certificate of authenticity from their manufacturers.',NULL,NULL,NULL,NULL),('Ships','2024-07-20 03:43:23','C',NULL,NULL,NULL,'The perfect holiday or anniversary gift for executives, clients, friends, and family. These handcrafted model ships are unique, stunning works of art that will be treasured for generations! They come fully assembled and ready for display in the home or office. We guarantee the highest quality, and best value.',NULL,NULL,NULL,NULL),('Trains','2024-07-20 03:43:23','C',NULL,NULL,NULL,'Model trains are a rewarding hobby for enthusiasts of all ages. Whether you\'re looking for collectible wooden trains, electric streetcars or locomotives, you\'ll find a number of great choices for any budget within this category. The interactive aspect of trains makes toy trains perfect for young children. The wooden train sets are ideal for children under the age of 5.',NULL,NULL,NULL,NULL),('Trucks and Buses','2024-07-20 03:43:23','C',NULL,NULL,NULL,'The Truck and Bus models are realistic replicas of buses and specialized trucks produced from the early 1920s to present. The models range in size from 1:12 to 1:50 scale and include numerous limited edition and several out-of-production vehicles. Materials used include tin, diecast and plastic. All models include a certificate of authenticity from their manufacturers and are a perfect ornament for the home and office.',NULL,NULL,NULL,NULL),('Vintage Cars','2024-07-20 03:43:23','C',NULL,NULL,NULL,'Our Vintage Car models realistically portray automobiles produced from the early 1900s through the 1940s. Materials used include Bakelite, diecast, plastic and wood. Most of the replicas are in the 1:18 and 1:24 scale sizes, which provide the optimum in detail and accuracy. Prices range from $30.00 up to $180.00 for some special limited edition replicas. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `productlines_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `productCode` varchar(15) NOT NULL,
  `productName` varchar(70) NOT NULL,
  `productScale` varchar(10) NOT NULL,
  `productVendor` varchar(50) NOT NULL,
  `productDescription` text NOT NULL,
  `buyPrice` double NOT NULL,
  `product_category` enum('C','D') DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('100009','Jeep','1:200','Hot Wheels','small jeep',100,'C','test4ba','test4ba'),('100010','Mazda MX-5','1:200','Hot Wheels','small car',100,'C','test4ba','test4ba'),('S10_1678','1969 Harley Davidson Ultimate Chopper','1:10','Min Lin Diecast','This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.',48.81,'C',NULL,NULL),('S10_1949','1952 Alpine Renault 1300','1:10','Classic Metal Creations','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',98.58,'C',NULL,NULL),('S10_2016','1996 Moto Guzzi 1100i','1:10','Highway 66 Mini Classics','Official Moto Guzzi logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.',68.99,'C',NULL,NULL),('S10_4698','2003 Harley-Davidson Eagle Drag Bike','1:10','Red Start Diecast','Model features, official Harley Davidson logos and insignias, detachable rear wheelie bar, heavy diecast metal with resin parts, authentic multi-color tampo-printed graphics, separate engine drive belts, free-turning front fork, rotating tires and rear racing slick, certificate of authenticity, detailed engine, display stand\r\n, precision diecast replica, baked enamel finish, 1:10 scale model, removable fender, seat and tank cover piece for displaying the superior detail of the v-twin engine',91.02,'C',NULL,NULL),('S10_4757','1972 Alfa Romeo GTA','1:10','Motor City Art Classics','Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',85.68,'C',NULL,NULL),('S10_4962','1962 LanciaA Delta 16V','1:10','Second Gear Diecast','Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',103.42,'C',NULL,NULL),('S12_1099','1968 Ford Mustang','1:12','Autoart Studio Design','Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color dark green.',95.34,'C',NULL,NULL),('S12_1108','2001 Ferrari Enzo','1:12','Second Gear Diecast','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',95.59,'C',NULL,NULL),('S12_1666','1958 Setra Bus','1:12','Welly Diecast Productions','Model features 30 windows, skylights & glare resistant glass, working steering system, original logos',77.9,'C',NULL,NULL),('S12_2823','2002 Suzuki XREO','1:12','Unimax Art Galleries','Official logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.',66.27,'C',NULL,NULL),('S12_3148','1969 Corvair Monza','1:18','Welly Diecast Productions','1:18 scale die-cast about 10\" long doors open, hood opens, trunk opens and wheels roll',89.14,'C',NULL,NULL),('S12_3380','1968 Dodge Charger','1:12','Welly Diecast Productions','1:12 scale model of a 1968 Dodge Charger. Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color black',75.16,'C',NULL,NULL),('S12_3891','1969 Ford Falcon','1:12','Second Gear Diecast','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',83.05,'C',NULL,NULL),('S12_3990','1970 Plymouth Hemi Cuda','1:12','Studio M Art Models','Very detailed 1970 Plymouth Cuda model in 1:12 scale. The Cuda is generally accepted as one of the fastest original muscle cars from the 1970s. This model is a reproduction of one of the orginal 652 cars built in 1970. Red color.',31.92,'C',NULL,NULL),('S12_4473','1957 Chevy Pickup','1:12','Exoto Designs','1:12 scale die-cast about 20\" long Hood opens, Rubber wheels',55.7,'C',NULL,NULL),('S12_4675','1969 Dodge Charger','1:12','Welly Diecast Productions','Detailed model of the 1969 Dodge Charger. This model includes finely detailed interior and exterior features. Painted in red and white.',58.73,'C',NULL,NULL),('S18_1097','1940 Ford Pickup Truck','1:18','Studio M Art Models','This model features soft rubber tires, working steering, rubber mud guards, authentic Ford logos, detailed undercarriage, opening doors and hood,  removable split rear gate, full size spare mounted in bed, detailed interior with opening glove box',58.33,'C',NULL,NULL),('S18_1129','1993 Mazda RX-7','1:18','Highway 66 Mini Classics','This model features, opening hood, opening doors, detailed engine, rear spoiler, opening trunk, working steering, tinted windows, baked enamel finish. Color red.',83.51,'C',NULL,NULL),('S18_1342','1937 Lincoln Berline','1:18','Motor City Art Classics','Features opening engine cover, doors, trunk, and fuel filler cap. Color black',60.62,'C',NULL,NULL),('S18_1367','1936 Mercedes-Benz 500K Special Roadster','1:18','Studio M Art Models','This 1:18 scale replica is constructed of heavy die-cast metal and has all the features of the original: working doors and rumble seat, independent spring suspension, detailed interior, working steering system, and a bifold hood that reveals an engine so accurate that it even includes the wiring. All this is topped off with a baked enamel finish. Color white.',24.26,'C',NULL,NULL),('S18_1589','1965 Aston Martin DB5','1:18','Classic Metal Creations','Die-cast model of the silver 1965 Aston Martin DB5 in silver. This model includes full wire wheels and doors that open with fully detailed passenger compartment. In 1:18 scale, this model measures approximately 10 inches/20 cm long.',65.96,'C',NULL,NULL),('S18_1662','1980s Black Hawk Helicopter','1:18','Red Start Diecast','1:18 scale replica of actual Army\'s UH-60L BLACK HAWK Helicopter. 100% hand-assembled. Features rotating rotor blades, propeller blades and rubber wheels.',77.27,'C',NULL,NULL),('S18_1749','1917 Grand Touring Sedan','1:18','Welly Diecast Productions','This 1:18 scale replica of the 1917 Grand Touring car has all the features you would expect from museum quality reproductions: all four doors and bi-fold hood opening, detailed engine and instrument panel, chrome-look trim, and tufted upholstery, all topped off with a factory baked-enamel finish.',86.7,'D',NULL,NULL),('S18_1889','1948 Porsche 356-A Roadster','1:18','Gearbox Collectibles','This precision die-cast replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',53.9,'C',NULL,NULL),('S18_1984','1995 Honda Civic','1:18','Min Lin Diecast','This model features, opening hood, opening doors, detailed engine, rear spoiler, opening trunk, working steering, tinted windows, baked enamel finish. Color yellow.',93.89,'C',NULL,NULL),('S18_2238','1998 Chrysler Plymouth Prowler','1:18','Gearbox Collectibles','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',101.51,'C',NULL,NULL),('S18_2248','1911 Ford Town Car','1:18','Motor City Art Classics','Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system.',33.3,'C',NULL,NULL),('S18_2319','1964 Mercedes Tour Bus','1:18','Unimax Art Galleries','Exact replica. 100+ parts. working steering system, original logos',74.86,'C',NULL,NULL),('S18_2325','1932 Model A Ford J-Coupe','1:18','Autoart Studio Design','This model features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system, chrome-covered spare, opening doors, detailed and wired engine',58.48,'C',NULL,NULL),('S18_2432','1926 Ford Fire Engine','1:18','Carousel DieCast Legends','Gleaming red handsome appearance. Everything is here the fire hoses, ladder, axes, bells, lanterns, ready to fight any inferno.',24.92,'C',NULL,NULL),('S18_2581','P-51-D Mustang','1:72','Gearbox Collectibles','Has retractable wheels and comes with a stand',49,'C',NULL,NULL),('S18_2625','1936 Harley Davidson El Knucklehead','1:18','Welly Diecast Productions','Intricately detailed with chrome accents and trim, official die-struck logos and baked enamel finish.',24.23,'C',NULL,NULL),('S18_2795','1928 Mercedes-Benz SSK','1:18','Gearbox Collectibles','This 1:18 replica features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system, chrome-covered spare, opening doors, detailed and wired engine. Color black.',72.56,'C',NULL,NULL),('S18_2870','1999 Indy 500 Monte Carlo SS','1:18','Red Start Diecast','Features include opening and closing doors. Color: Red',56.76,'C',NULL,NULL),('S18_2949','1913 Ford Model T Speedster','1:18','Carousel DieCast Legends','This 250 part reproduction includes moving handbrakes, clutch, throttle and foot pedals, squeezable horn, detailed wired engine, removable water, gas, and oil cans, pivoting monocle windshield, all topped with a baked enamel red finish. Each replica comes with an Owners Title and Certificate of Authenticity. Color red.',60.78,'C',NULL,NULL),('S18_2957','1934 Ford V8 Coupe','1:18','Min Lin Diecast','Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System',34.35,'C',NULL,NULL),('S18_3029','1999 Yamaha Speed Boat','1:18','Min Lin Diecast','Exact replica. Wood and Metal. Many extras including rigging, long boats, pilot house, anchors, etc. Comes with three masts, all square-rigged.',51.61,'C',NULL,NULL),('S18_3136','18th Century Vintage Horse Carriage','1:18','Red Start Diecast','Hand crafted diecast-like metal horse carriage is re-created in about 1:18 scale of antique horse carriage. This antique style metal Stagecoach is all hand-assembled with many different parts.\r\n\r\nThis collectible metal horse carriage is painted in classic Red, and features turning steering wheel and is entirely hand-finished.',60.74,'C',NULL,NULL),('S18_3140','1903 Ford Model A','1:18','Unimax Art Galleries','Features opening trunk,  working steering system',68.3,'C',NULL,NULL),('S18_3232','1992 Ferrari 360 Spider red','1:18','Unimax Art Galleries','his replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',77.9,'C',NULL,NULL),('S18_3233','1985 Toyota Supra','1:18','Highway 66 Mini Classics','This model features soft rubber tires, working steering, rubber mud guards, authentic Ford logos, detailed undercarriage, opening doors and hood, removable split rear gate, full size spare mounted in bed, detailed interior with opening glove box',57.01,'C',NULL,NULL),('S18_3259','Collectable Wooden Train','1:18','Carousel DieCast Legends','Hand crafted wooden toy train set is in about 1:18 scale, 25 inches in total length including 2 additional carts, of actual vintage train. This antique style wooden toy train model set is all hand-assembled with 100% wood.',67.56,'C',NULL,NULL),('S18_3278','1969 Dodge Super Bee','1:18','Min Lin Diecast','This replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',49.05,'C',NULL,NULL),('S18_3320','1917 Maxwell Touring Car','1:18','Exoto Designs','Features Gold Trim, Full Size Spare Tire, Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System',57.54,'C',NULL,NULL),('S18_3482','1976 Ford Gran Torino','1:18','Gearbox Collectibles','Highly detailed 1976 Ford Gran Torino \"Starsky and Hutch\" diecast model. Very well constructed and painted in red and white patterns.',73.49,'C',NULL,NULL),('S18_3685','1948 Porsche Type 356 Roadster','1:18','Gearbox Collectibles','This model features working front and rear suspension on accurately replicated and actuating shock absorbers as well as opening engine cover, rear stabilizer flap,  and 4 opening doors.',62.16,'C',NULL,NULL),('S18_3782','1957 Vespa GS150','1:18','Studio M Art Models','Features rotating wheels , working kick stand. Comes with stand.',32.95,'C',NULL,NULL),('S18_3856','1941 Chevrolet Special Deluxe Cabriolet','1:18','Exoto Designs','Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system, leather upholstery. Color black.',64.58,'C',NULL,NULL),('S18_4027','1970 Triumph Spitfire','1:18','Min Lin Diecast','Features include opening and closing doors. Color: White.',91.92,'C',NULL,NULL),('S18_4409','1932 Alfa Romeo 8C2300 Spider Sport','1:18','Exoto Designs','This 1:18 scale precision die cast replica features the 6 front headlights of the original, plus a detailed version of the 142 horsepower straight 8 engine, dual spares and their famous comprehensive dashboard. Color black.',43.26,'C',NULL,NULL),('S18_4522','1904 Buick Runabout','1:18','Exoto Designs','Features opening trunk,  working steering system',52.66,'C',NULL,NULL),('S18_4600','1940s Ford truck','1:18','Motor City Art Classics','This 1940s Ford Pick-Up truck is re-created in 1:18 scale of original 1940s Ford truck. This antique style metal 1940s Ford Flatbed truck is all hand-assembled. This collectible 1940\'s Pick-Up truck is painted in classic dark green color, and features rotating wheels.',84.76,'C',NULL,NULL),('S18_4668','1939 Cadillac Limousine','1:18','Studio M Art Models','Features completely detailed interior including Velvet flocked drapes,deluxe wood grain floor, and a wood grain casket with seperate chrome handles',23.14,'C',NULL,NULL),('S18_4721','1957 Corvette Convertible','1:18','Classic Metal Creations','1957 die cast Corvette Convertible in Roman Red with white sides and whitewall tires. 1:18 scale quality die-cast with detailed engine and underbvody. Now you can own The Classic Corvette.',69.93,'C',NULL,NULL),('S18_4933','1957 Ford Thunderbird','1:18','Studio M Art Models','This 1:18 scale precision die-cast replica, with its optional porthole hardtop and factory baked-enamel Thunderbird Bronze finish, is a 100% accurate rendition of this American classic.',34.21,'C',NULL,NULL),('S24_1046','1970 Chevy Chevelle SS 454','1:24','Unimax Art Galleries','This model features rotating wheels, working streering system and opening doors. All parts are particularly delicate due to their precise scale and require special care and attention. It should not be picked up by the doors, roof, hood or trunk.',49.24,'C',NULL,NULL),('S24_1444','1970 Dodge Coronet','1:24','Highway 66 Mini Classics','1:24 scale die-cast about 18\" long doors open, hood opens and rubber wheels',32.37,'C',NULL,NULL),('S24_1578','1997 BMW R 1100 S','1:24','Autoart Studio Design','Detailed scale replica with working suspension and constructed from over 70 parts',60.86,'C',NULL,NULL),('S24_1628','1966 Shelby Cobra 427 S/C','1:24','Carousel DieCast Legends','This diecast model of the 1966 Shelby Cobra 427 S/C includes many authentic details and operating parts. The 1:24 scale model of this iconic lighweight sports car from the 1960s comes in silver and it\'s own display case.',29.18,'C',NULL,NULL),('S24_1785','1928 British Royal Navy Airplane','1:24','Classic Metal Creations','Official logos and insignias',66.74,'C',NULL,NULL),('S24_1937','1939 Chevrolet Deluxe Coupe','1:24','Motor City Art Classics','This 1:24 scale die-cast replica of the 1939 Chevrolet Deluxe Coupe has the same classy look as the original. Features opening trunk, hood and doors and a showroom quality baked enamel finish.',22.57,'C',NULL,NULL),('S24_2000','1960 BSA Gold Star DBD34','1:24','Highway 66 Mini Classics','Detailed scale replica with working suspension and constructed from over 70 parts',37.32,'C',NULL,NULL),('S24_2011','18th century schooner','1:24','Carousel DieCast Legends','All wood with canvas sails. Many extras including rigging, long boats, pilot house, anchors, etc. Comes with 4 masts, all square-rigged.',82.34,'C',NULL,NULL),('S24_2022','1938 Cadillac V-16 Presidential Limousine','1:24','Classic Metal Creations','This 1:24 scale precision die cast replica of the 1938 Cadillac V-16 Presidential Limousine has all the details of the original, from the flags on the front to an opening back seat compartment complete with telephone and rifle. Features factory baked-enamel black finish, hood goddess ornament, working jump seats.',20.61,'C',NULL,NULL),('S24_2300','1962 Volkswagen Microbus','1:24','Autoart Studio Design','This 1:18 scale die cast replica of the 1962 Microbus is loaded with features: A working steering system, opening front doors and tailgate, and famous two-tone factory baked enamel finish, are all topped of by the sliding, real fabric, sunroof.',61.34,'C',NULL,NULL),('S24_2360','1982 Ducati 900 Monster','1:24','Highway 66 Mini Classics','Features two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand',47.1,'C',NULL,NULL),('S24_2766','1949 Jaguar XK 120','1:24','Classic Metal Creations','Precision-engineered from original Jaguar specification in perfect scale ratio. Features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',47.25,'C',NULL,NULL),('S24_2840','1958 Chevy Corvette Limited Edition','1:24','Carousel DieCast Legends','The operating parts of this 1958 Chevy Corvette Limited Edition are particularly delicate due to their precise scale and require special care and attention. Features rotating wheels, working streering, opening doors and trunk. Color dark green.',15.91,'C',NULL,NULL),('S24_2841','1900s Vintage Bi-Plane','1:24','Autoart Studio Design','Hand crafted diecast-like metal bi-plane is re-created in about 1:24 scale of antique pioneer airplane. All hand-assembled with many different parts. Hand-painted in classic yellow and features correct markings of original airplane.',34.25,'C',NULL,NULL),('S24_2887','1952 Citroen-15CV','1:24','Exoto Designs','Precision crafted hand-assembled 1:18 scale reproduction of the 1952 15CV, with its independent spring suspension, working steering system, opening doors and hood, detailed engine and instrument panel, all topped of with a factory fresh baked enamel finish.',72.82,'C',NULL,NULL),('S24_2972','1982 Lamborghini Diablo','1:24','Second Gear Diecast','This replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',16.24,'C',NULL,NULL),('S24_3151','1912 Ford Model T Delivery Wagon','1:24','Min Lin Diecast','This model features chrome trim and grille, opening hood, opening doors, opening trunk, detailed engine, working steering system. Color white.',46.91,'C',NULL,NULL),('S24_3191','1969 Chevrolet Camaro Z28','1:24','Exoto Designs','1969 Z/28 Chevy Camaro 1:24 scale replica. The operating parts of this limited edition 1:24 scale diecast model car 1969 Chevy Camaro Z28- hood, trunk, wheels, streering, suspension and doors- are particularly delicate due to their precise scale and require special care and attention.',50.51,'C',NULL,NULL),('S24_3371','1971 Alpine Renault 1600s','1:24','Welly Diecast Productions','This 1971 Alpine Renault 1600s replica Features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',38.58,'C',NULL,NULL),('S24_3420','1937 Horch 930V Limousine','1:24','Autoart Studio Design','Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system',26.3,'C',NULL,NULL),('S24_3432','2002 Chevy Corvette','1:24','Gearbox Collectibles','The operating parts of this limited edition Diecast 2002 Chevy Corvette 50th Anniversary Pace car Limited Edition are particularly delicate due to their precise scale and require special care and attention. Features rotating wheels, poseable streering, opening doors and trunk.',62.11,'C',NULL,NULL),('S24_3816','1940 Ford Delivery Sedan','1:24','Carousel DieCast Legends','Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System. Color black.',48.64,'C',NULL,NULL),('S24_3856','1956 Porsche 356A Coupe','1:18','Classic Metal Creations','Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',98.3,'C',NULL,NULL),('S24_3949','Corsair F4U ( Bird Cage)','1:24','Second Gear Diecast','Has retractable wheels and comes with a stand. Official logos and insignias.',29.34,'C',NULL,NULL),('S24_3969','1936 Mercedes Benz 500k Roadster','1:24','Red Start Diecast','This model features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system and rubber wheels. Color black.',21.75,'C',NULL,NULL),('S24_4048','1992 Porsche Cayenne Turbo Silver','1:24','Exoto Designs','This replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',69.78,'C',NULL,NULL),('S24_4258','1936 Chrysler Airflow','1:24','Second Gear Diecast','Features opening trunk,  working steering system. Color dark green.',57.46,'C',NULL,NULL),('S24_4278','1900s Vintage Tri-Plane','1:24','Unimax Art Galleries','Hand crafted diecast-like metal Triplane is Re-created in about 1:24 scale of antique pioneer airplane. This antique style metal triplane is all hand-assembled with many different parts.',36.23,'C',NULL,NULL),('S24_4620','1961 Chevrolet Impala','1:18','Classic Metal Creations','This 1:18 scale precision die-cast reproduction of the 1961 Chevrolet Impala has all the features-doors, hood and trunk that open; detailed 409 cubic-inch engine; chrome dashboard and stick shift, two-tone interior; working steering system; all topped of with a factory baked-enamel finish.',32.33,'C',NULL,NULL),('S32_1268','1980’s GM Manhattan Express','1:32','Motor City Art Classics','This 1980’s era new look Manhattan express is still active, running from the Bronx to mid-town Manhattan. Has 35 opeining windows and working lights. Needs a battery.',53.93,'C',NULL,NULL),('S32_1374','1997 BMW F650 ST','1:32','Exoto Designs','Features official die-struck logos and baked enamel finish. Comes with stand.',66.92,'C',NULL,NULL),('S32_2206','1982 Ducati 996 R','1:32','Gearbox Collectibles','Features rotating wheels , working kick stand. Comes with stand.',24.14,'C',NULL,NULL),('S32_2509','1954 Greyhound Scenicruiser','1:32','Classic Metal Creations','Model features bi-level seating, 50 windows, skylights & glare resistant glass, working steering system, original logos',25.98,'C',NULL,NULL),('S32_3207','1950\'s Chicago Surface Lines Streetcar','1:32','Gearbox Collectibles','This streetcar is a joy to see. It has 80 separate windows, electric wire guides, detailed interiors with seats, poles and drivers controls, rolling and turning wheel assemblies, plus authentic factory baked-enamel finishes (Green Hornet for Chicago and Cream and Crimson for Boston).',26.72,'C',NULL,NULL),('S32_3522','1996 Peterbilt 379 Stake Bed with Outrigger','1:32','Red Start Diecast','This model features, opening doors, detailed engine, working steering, tinted windows, detailed interior, die-struck logos, removable stakes operating outriggers, detachable second trailer, functioning 360-degree self loader, precision molded resin trailer and trim, baked enamel finish on cab',33.61,'C',NULL,NULL),('S32_4289','1928 Ford Phaeton Deluxe','1:32','Highway 66 Mini Classics','This model features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system',33.02,'C',NULL,NULL),('S32_4485','1974 Ducati 350 Mk3 Desmo','1:32','Second Gear Diecast','This model features two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand',56.13,'C',NULL,NULL),('S50_1341','1930 Buick Marquette Phaeton','1:50','Studio M Art Models','Features opening trunk,  working steering system',27.06,'C',NULL,NULL),('S50_1392','Diamond T620 Semi-Skirted Tanker','1:50','Highway 66 Mini Classics','This limited edition model is licensed and perfectly scaled for Lionel Trains. The Diamond T620 has been produced in solid precision diecast and painted with a fire baked enamel finish. It comes with a removable tanker and is a perfect model to add authenticity to your static train or car layout or to just have on display.',68.29,'C',NULL,NULL),('S50_1514','1962 City of Detroit Streetcar','1:50','Classic Metal Creations','This streetcar is a joy to see. It has 99 separate windows, electric wire guides, detailed interiors with seats, poles and drivers controls, rolling and turning wheel assemblies, plus authentic factory baked-enamel finishes (Green Hornet for Chicago and Cream and Crimson for Boston).',37.49,'C',NULL,NULL),('S50_4713','2002 Yamaha YZR M1','1:50','Autoart Studio Design','Features rotating wheels , working kick stand. Comes with stand.',34.17,'C',NULL,NULL),('S700_1138','The Schooner Bluenose','1:700','Autoart Studio Design','All wood with canvas sails. Measures 31 1/2 inches in Length, 22 inches High and 4 3/4 inches Wide. Many extras.\r\nThe schooner Bluenose was built in Nova Scotia in 1921 to fish the rough waters off the coast of Newfoundland. Because of the Bluenose racing prowess she became the pride of all Canadians. Still featured on stamps and the Canadian dime, the Bluenose was lost off Haiti in 1946.',34,'C',NULL,NULL),('S700_1691','American Airlines: B767-300','1:700','Min Lin Diecast','Exact replia with official logos and insignias and retractable wheels',51.15,'C',NULL,NULL),('S700_1938','The Mayflower','1:700','Studio M Art Models','Measures 31 1/2 inches Long x 25 1/2 inches High x 10 5/8 inches Wide\r\nAll wood with canvas sail. Extras include long boats, rigging, ladders, railing, anchors, side cannons, hand painted, etc.',43.3,'C',NULL,NULL),('S700_2047','HMS Bounty','1:700','Unimax Art Galleries','Measures 30 inches Long x 27 1/2 inches High x 4 3/4 inches Wide. \r\nMany extras including rigging, long boats, pilot house, anchors, etc. Comes with three masts, all square-rigged.',39.83,'C',NULL,NULL),('S700_2466','America West Airlines B757-200','1:700','Motor City Art Classics','Official logos and insignias. Working steering system. Rotating jet engines',68.8,'C',NULL,NULL),('S700_2610','The USS Constitution Ship','1:700','Red Start Diecast','All wood with canvas sails. Measures 31 1/2\" Length x 22 3/8\" High x 8 1/4\" Width. Extras include 4 boats on deck, sea sprite on bow, anchors, copper railing, pilot houses, etc.',33.97,'C',NULL,NULL),('S700_2824','1982 Camaro Z28','1:18','Carousel DieCast Legends','Features include opening and closing doors. Color: White. \r\nMeasures approximately 9 1/2\" Long.',46.53,'C',NULL,NULL),('S700_2834','ATA: B757-300','1:700','Highway 66 Mini Classics','Exact replia with official logos and insignias and retractable wheels',59.33,'C',NULL,NULL),('S700_3167','F/A 18 Hornet 1/72','1:72','Motor City Art Classics','10\" Wingspan with retractable landing gears.Comes with pilot',54.4,'C',NULL,NULL),('S700_3505','The Titanic','1:700','Carousel DieCast Legends','Completed model measures 19 1/2 inches long, 9 inches high, 3inches wide and is in barn red/black. All wood and metal.',51.09,'C',NULL,NULL),('S700_3962','The Queen Mary','1:700','Welly Diecast Productions','Exact replica. Wood and Metal. Many extras including rigging, long boats, pilot house, anchors, etc. Comes with three masts, all square-rigged.',53.63,'C',NULL,NULL),('S700_4002','American Airlines: MD-11S','1:700','Second Gear Diecast','Polished finish. Exact replia with official logos and insignias and retractable wheels',36.27,'D',NULL,NULL),('S72_1253','Boeing X-32A JSF','1:72','Motor City Art Classics','10\" Wingspan with retractable landing gears.Comes with pilot',32.77,'D',NULL,NULL),('S72_3212','Pont Yacht','1:72','Unimax Art Galleries','Measures 38 inches Long x 33 3/4 inches High. Includes a stand.\r\nMany extras including rigging, long boats, pilot house, anchors, etc. Comes with 2 masts, all square-rigged',33.3,'D',NULL,NULL),('XX00001','USS Enterprise','1:50','Star Trek Limited','Star Trek Explorer Ship',100,'C',NULL,NULL),('XX00002','USS Exelsior','1:50','Star Trek Limited','Star Trek Explorer Ship',100,'C',NULL,NULL),('XX00003','USS Roosevelt','1:50','Star Trek Limited','Star Trek Explorer Ship',100,'D',NULL,NULL),('XX00004','Lego Starwars','1:20','Lego','big lego',100,'D','mark@toys.com','new product'),('XX00005','Honda Civic','1:200','Hotwheels','factory fresh',100,'C','mark1@toys.com','Add new product'),('XX00006','Corvette Stingray','1:200','Hotwheels','factory fresh',100,'C','mark1@toys.com','Add new product'),('XX00007','Toyota Tacoma','1:200','Hotwheels','factory fresh',100,'D','mike1@toys.com','new product'),('XX00008','Toyota Supra','1:200','Hotwheels','factory fresh',100,'D','mike1@toys.com','new product');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `products_BEFORE_INSERT` BEFORE INSERT ON `products` FOR EACH ROW BEGIN

	/*DECLARE newproductCode INT;
    DECLARE fixed_part INT;
    
    SET fixed_part = 'S';
    SET newproductCode = CONCAT(fixed_part, new.productScale);
	
    IF (lastNumber is NULL) THEN
		SET newemployeeNumber := CAST(CONCAT(fixed_part, '001') AS UNSIGNED);
	END IF;
		SET new.employeeNumber := newemployeeNumber;
        
        
	
    -- old report
    SELECT MAX(productCode) + 1 INTO newproductCode FROM products_audit;
	IF (newproductCode is NULL) THEN
		SET newproductCode := 5001;
	END IF;
		SET new.productCode = newproductCode;*/
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `products_AFTER_INSERT` AFTER INSERT ON `products` FOR EACH ROW BEGIN
	INSERT INTO products_audit VALUES(new.productCode, now(), 'C', NULL, NULL, NULL, NULL, NULL, NULL, new.productName, new.productScale, new.productVendor , new.productDescription, new.buyPrice, new.product_category, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `products_AFTER_UPDATE` AFTER UPDATE ON `products` FOR EACH ROW BEGIN
	IF (old.productCode <> new.productCode) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "productCode cannot be modified";
	END IF;

	INSERT INTO products_audit VALUES(new.productCode, now(), 'U', old.productName, old.productScale, old.productVendor , old.productDescription, old.buyPrice, old.product_category, new.productName, new.productScale, new.productVendor , new.productDescription, new.buyPrice, new.product_category, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `products_BEFORE_DELETE` BEFORE DELETE ON `products` FOR EACH ROW BEGIN
	INSERT INTO products_audit VALUES(old.productCode, now(), 'D', old.productName, old.productScale, old.productVendor , old.productDescription, old.buyPrice, old.product_category, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `products_audit`
--

DROP TABLE IF EXISTS `products_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_audit` (
  `productCode` varchar(15) NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_productName` varchar(70) DEFAULT NULL,
  `old_productScale` varchar(10) DEFAULT NULL,
  `old_productVendor` varchar(50) DEFAULT NULL,
  `old_productDescription` text,
  `old_buyPrice` double DEFAULT NULL,
  `old_product_category` enum('C','D') DEFAULT NULL,
  `new_productName` varchar(70) DEFAULT NULL,
  `new_productScale` varchar(10) DEFAULT NULL,
  `new_productVendor` varchar(50) DEFAULT NULL,
  `new_productDescription` text,
  `new_buyPrice` double DEFAULT NULL,
  `new_product_category` enum('C','D') DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productCode`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_audit`
--

LOCK TABLES `products_audit` WRITE;
/*!40000 ALTER TABLE `products_audit` DISABLE KEYS */;
INSERT INTO `products_audit` VALUES ('100009','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'Jeep','1:200','Hot Wheels','small jeep',100,'C','test4ba','test4ba'),('100010','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'Mazda MX-5','1:200','Hot Wheels','small car',100,'C','test4ba','test4ba'),('S10_1678','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1969 Harley Davidson Ultimate Chopper','1:10','Min Lin Diecast','This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.',48.81,'C',NULL,NULL),('S10_1949','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1952 Alpine Renault 1300','1:10','Classic Metal Creations','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',98.58,'C',NULL,NULL),('S10_2016','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1996 Moto Guzzi 1100i','1:10','Highway 66 Mini Classics','Official Moto Guzzi logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.',68.99,'C',NULL,NULL),('S10_4698','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'2003 Harley-Davidson Eagle Drag Bike','1:10','Red Start Diecast','Model features, official Harley Davidson logos and insignias, detachable rear wheelie bar, heavy diecast metal with resin parts, authentic multi-color tampo-printed graphics, separate engine drive belts, free-turning front fork, rotating tires and rear racing slick, certificate of authenticity, detailed engine, display stand\r\n, precision diecast replica, baked enamel finish, 1:10 scale model, removable fender, seat and tank cover piece for displaying the superior detail of the v-twin engine',91.02,'C',NULL,NULL),('S10_4757','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1972 Alfa Romeo GTA','1:10','Motor City Art Classics','Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',85.68,'C',NULL,NULL),('S10_4962','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1962 LanciaA Delta 16V','1:10','Second Gear Diecast','Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',103.42,'C',NULL,NULL),('S12_1099','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1968 Ford Mustang','1:12','Autoart Studio Design','Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color dark green.',95.34,'C',NULL,NULL),('S12_1108','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'2001 Ferrari Enzo','1:12','Second Gear Diecast','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',95.59,'C',NULL,NULL),('S12_1666','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1958 Setra Bus','1:12','Welly Diecast Productions','Model features 30 windows, skylights & glare resistant glass, working steering system, original logos',77.9,'C',NULL,NULL),('S12_2823','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'2002 Suzuki XREO','1:12','Unimax Art Galleries','Official logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.',66.27,'C',NULL,NULL),('S12_3148','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1969 Corvair Monza','1:18','Welly Diecast Productions','1:18 scale die-cast about 10\" long doors open, hood opens, trunk opens and wheels roll',89.14,'C',NULL,NULL),('S12_3380','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1968 Dodge Charger','1:12','Welly Diecast Productions','1:12 scale model of a 1968 Dodge Charger. Hood, doors and trunk all open to reveal highly detailed interior features. Steering wheel actually turns the front wheels. Color black',75.16,'C',NULL,NULL),('S12_3891','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1969 Ford Falcon','1:12','Second Gear Diecast','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',83.05,'C',NULL,NULL),('S12_3990','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1970 Plymouth Hemi Cuda','1:12','Studio M Art Models','Very detailed 1970 Plymouth Cuda model in 1:12 scale. The Cuda is generally accepted as one of the fastest original muscle cars from the 1970s. This model is a reproduction of one of the orginal 652 cars built in 1970. Red color.',31.92,'C',NULL,NULL),('S12_4473','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1957 Chevy Pickup','1:12','Exoto Designs','1:12 scale die-cast about 20\" long Hood opens, Rubber wheels',55.7,'C',NULL,NULL),('S12_4675','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1969 Dodge Charger','1:12','Welly Diecast Productions','Detailed model of the 1969 Dodge Charger. This model includes finely detailed interior and exterior features. Painted in red and white.',58.73,'C',NULL,NULL),('S18_1097','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1940 Ford Pickup Truck','1:18','Studio M Art Models','This model features soft rubber tires, working steering, rubber mud guards, authentic Ford logos, detailed undercarriage, opening doors and hood,  removable split rear gate, full size spare mounted in bed, detailed interior with opening glove box',58.33,'C',NULL,NULL),('S18_1129','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1993 Mazda RX-7','1:18','Highway 66 Mini Classics','This model features, opening hood, opening doors, detailed engine, rear spoiler, opening trunk, working steering, tinted windows, baked enamel finish. Color red.',83.51,'C',NULL,NULL),('S18_1342','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1937 Lincoln Berline','1:18','Motor City Art Classics','Features opening engine cover, doors, trunk, and fuel filler cap. Color black',60.62,'C',NULL,NULL),('S18_1367','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1936 Mercedes-Benz 500K Special Roadster','1:18','Studio M Art Models','This 1:18 scale replica is constructed of heavy die-cast metal and has all the features of the original: working doors and rumble seat, independent spring suspension, detailed interior, working steering system, and a bifold hood that reveals an engine so accurate that it even includes the wiring. All this is topped off with a baked enamel finish. Color white.',24.26,'C',NULL,NULL),('S18_1589','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1965 Aston Martin DB5','1:18','Classic Metal Creations','Die-cast model of the silver 1965 Aston Martin DB5 in silver. This model includes full wire wheels and doors that open with fully detailed passenger compartment. In 1:18 scale, this model measures approximately 10 inches/20 cm long.',65.96,'C',NULL,NULL),('S18_1662','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1980s Black Hawk Helicopter','1:18','Red Start Diecast','1:18 scale replica of actual Army\'s UH-60L BLACK HAWK Helicopter. 100% hand-assembled. Features rotating rotor blades, propeller blades and rubber wheels.',77.27,'C',NULL,NULL),('S18_1749','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1917 Grand Touring Sedan','1:18','Welly Diecast Productions','This 1:18 scale replica of the 1917 Grand Touring car has all the features you would expect from museum quality reproductions: all four doors and bi-fold hood opening, detailed engine and instrument panel, chrome-look trim, and tufted upholstery, all topped off with a factory baked-enamel finish.',86.7,'D',NULL,NULL),('S18_1889','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1948 Porsche 356-A Roadster','1:18','Gearbox Collectibles','This precision die-cast replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',53.9,'C',NULL,NULL),('S18_1984','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1995 Honda Civic','1:18','Min Lin Diecast','This model features, opening hood, opening doors, detailed engine, rear spoiler, opening trunk, working steering, tinted windows, baked enamel finish. Color yellow.',93.89,'C',NULL,NULL),('S18_2238','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1998 Chrysler Plymouth Prowler','1:18','Gearbox Collectibles','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',101.51,'C',NULL,NULL),('S18_2248','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1911 Ford Town Car','1:18','Motor City Art Classics','Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system.',33.3,'C',NULL,NULL),('S18_2319','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1964 Mercedes Tour Bus','1:18','Unimax Art Galleries','Exact replica. 100+ parts. working steering system, original logos',74.86,'C',NULL,NULL),('S18_2325','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1932 Model A Ford J-Coupe','1:18','Autoart Studio Design','This model features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system, chrome-covered spare, opening doors, detailed and wired engine',58.48,'C',NULL,NULL),('S18_2432','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1926 Ford Fire Engine','1:18','Carousel DieCast Legends','Gleaming red handsome appearance. Everything is here the fire hoses, ladder, axes, bells, lanterns, ready to fight any inferno.',24.92,'C',NULL,NULL),('S18_2581','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'P-51-D Mustang','1:72','Gearbox Collectibles','Has retractable wheels and comes with a stand',49,'C',NULL,NULL),('S18_2625','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1936 Harley Davidson El Knucklehead','1:18','Welly Diecast Productions','Intricately detailed with chrome accents and trim, official die-struck logos and baked enamel finish.',24.23,'C',NULL,NULL),('S18_2795','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1928 Mercedes-Benz SSK','1:18','Gearbox Collectibles','This 1:18 replica features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system, chrome-covered spare, opening doors, detailed and wired engine. Color black.',72.56,'C',NULL,NULL),('S18_2870','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1999 Indy 500 Monte Carlo SS','1:18','Red Start Diecast','Features include opening and closing doors. Color: Red',56.76,'C',NULL,NULL),('S18_2949','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1913 Ford Model T Speedster','1:18','Carousel DieCast Legends','This 250 part reproduction includes moving handbrakes, clutch, throttle and foot pedals, squeezable horn, detailed wired engine, removable water, gas, and oil cans, pivoting monocle windshield, all topped with a baked enamel red finish. Each replica comes with an Owners Title and Certificate of Authenticity. Color red.',60.78,'C',NULL,NULL),('S18_2957','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1934 Ford V8 Coupe','1:18','Min Lin Diecast','Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System',34.35,'C',NULL,NULL),('S18_3029','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1999 Yamaha Speed Boat','1:18','Min Lin Diecast','Exact replica. Wood and Metal. Many extras including rigging, long boats, pilot house, anchors, etc. Comes with three masts, all square-rigged.',51.61,'C',NULL,NULL),('S18_3136','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'18th Century Vintage Horse Carriage','1:18','Red Start Diecast','Hand crafted diecast-like metal horse carriage is re-created in about 1:18 scale of antique horse carriage. This antique style metal Stagecoach is all hand-assembled with many different parts.\r\n\r\nThis collectible metal horse carriage is painted in classic Red, and features turning steering wheel and is entirely hand-finished.',60.74,'C',NULL,NULL),('S18_3140','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1903 Ford Model A','1:18','Unimax Art Galleries','Features opening trunk,  working steering system',68.3,'C',NULL,NULL),('S18_3232','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1992 Ferrari 360 Spider red','1:18','Unimax Art Galleries','his replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',77.9,'C',NULL,NULL),('S18_3233','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1985 Toyota Supra','1:18','Highway 66 Mini Classics','This model features soft rubber tires, working steering, rubber mud guards, authentic Ford logos, detailed undercarriage, opening doors and hood, removable split rear gate, full size spare mounted in bed, detailed interior with opening glove box',57.01,'C',NULL,NULL),('S18_3259','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'Collectable Wooden Train','1:18','Carousel DieCast Legends','Hand crafted wooden toy train set is in about 1:18 scale, 25 inches in total length including 2 additional carts, of actual vintage train. This antique style wooden toy train model set is all hand-assembled with 100% wood.',67.56,'C',NULL,NULL),('S18_3278','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1969 Dodge Super Bee','1:18','Min Lin Diecast','This replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',49.05,'C',NULL,NULL),('S18_3320','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1917 Maxwell Touring Car','1:18','Exoto Designs','Features Gold Trim, Full Size Spare Tire, Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System',57.54,'C',NULL,NULL),('S18_3482','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1976 Ford Gran Torino','1:18','Gearbox Collectibles','Highly detailed 1976 Ford Gran Torino \"Starsky and Hutch\" diecast model. Very well constructed and painted in red and white patterns.',73.49,'C',NULL,NULL),('S18_3685','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1948 Porsche Type 356 Roadster','1:18','Gearbox Collectibles','This model features working front and rear suspension on accurately replicated and actuating shock absorbers as well as opening engine cover, rear stabilizer flap,  and 4 opening doors.',62.16,'C',NULL,NULL),('S18_3782','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1957 Vespa GS150','1:18','Studio M Art Models','Features rotating wheels , working kick stand. Comes with stand.',32.95,'C',NULL,NULL),('S18_3856','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1941 Chevrolet Special Deluxe Cabriolet','1:18','Exoto Designs','Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system, leather upholstery. Color black.',64.58,'C',NULL,NULL),('S18_4027','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1970 Triumph Spitfire','1:18','Min Lin Diecast','Features include opening and closing doors. Color: White.',91.92,'C',NULL,NULL),('S18_4409','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1932 Alfa Romeo 8C2300 Spider Sport','1:18','Exoto Designs','This 1:18 scale precision die cast replica features the 6 front headlights of the original, plus a detailed version of the 142 horsepower straight 8 engine, dual spares and their famous comprehensive dashboard. Color black.',43.26,'C',NULL,NULL),('S18_4522','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1904 Buick Runabout','1:18','Exoto Designs','Features opening trunk,  working steering system',52.66,'C',NULL,NULL),('S18_4600','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1940s Ford truck','1:18','Motor City Art Classics','This 1940s Ford Pick-Up truck is re-created in 1:18 scale of original 1940s Ford truck. This antique style metal 1940s Ford Flatbed truck is all hand-assembled. This collectible 1940\'s Pick-Up truck is painted in classic dark green color, and features rotating wheels.',84.76,'C',NULL,NULL),('S18_4668','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1939 Cadillac Limousine','1:18','Studio M Art Models','Features completely detailed interior including Velvet flocked drapes,deluxe wood grain floor, and a wood grain casket with seperate chrome handles',23.14,'C',NULL,NULL),('S18_4721','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1957 Corvette Convertible','1:18','Classic Metal Creations','1957 die cast Corvette Convertible in Roman Red with white sides and whitewall tires. 1:18 scale quality die-cast with detailed engine and underbvody. Now you can own The Classic Corvette.',69.93,'C',NULL,NULL),('S18_4933','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1957 Ford Thunderbird','1:18','Studio M Art Models','This 1:18 scale precision die-cast replica, with its optional porthole hardtop and factory baked-enamel Thunderbird Bronze finish, is a 100% accurate rendition of this American classic.',34.21,'C',NULL,NULL),('S24_1046','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1970 Chevy Chevelle SS 454','1:24','Unimax Art Galleries','This model features rotating wheels, working streering system and opening doors. All parts are particularly delicate due to their precise scale and require special care and attention. It should not be picked up by the doors, roof, hood or trunk.',49.24,'C',NULL,NULL),('S24_1444','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1970 Dodge Coronet','1:24','Highway 66 Mini Classics','1:24 scale die-cast about 18\" long doors open, hood opens and rubber wheels',32.37,'C',NULL,NULL),('S24_1578','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1997 BMW R 1100 S','1:24','Autoart Studio Design','Detailed scale replica with working suspension and constructed from over 70 parts',60.86,'C',NULL,NULL),('S24_1628','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1966 Shelby Cobra 427 S/C','1:24','Carousel DieCast Legends','This diecast model of the 1966 Shelby Cobra 427 S/C includes many authentic details and operating parts. The 1:24 scale model of this iconic lighweight sports car from the 1960s comes in silver and it\'s own display case.',29.18,'C',NULL,NULL),('S24_1785','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1928 British Royal Navy Airplane','1:24','Classic Metal Creations','Official logos and insignias',66.74,'C',NULL,NULL),('S24_1937','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1939 Chevrolet Deluxe Coupe','1:24','Motor City Art Classics','This 1:24 scale die-cast replica of the 1939 Chevrolet Deluxe Coupe has the same classy look as the original. Features opening trunk, hood and doors and a showroom quality baked enamel finish.',22.57,'C',NULL,NULL),('S24_2000','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1960 BSA Gold Star DBD34','1:24','Highway 66 Mini Classics','Detailed scale replica with working suspension and constructed from over 70 parts',37.32,'C',NULL,NULL),('S24_2011','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'18th century schooner','1:24','Carousel DieCast Legends','All wood with canvas sails. Many extras including rigging, long boats, pilot house, anchors, etc. Comes with 4 masts, all square-rigged.',82.34,'C',NULL,NULL),('S24_2022','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1938 Cadillac V-16 Presidential Limousine','1:24','Classic Metal Creations','This 1:24 scale precision die cast replica of the 1938 Cadillac V-16 Presidential Limousine has all the details of the original, from the flags on the front to an opening back seat compartment complete with telephone and rifle. Features factory baked-enamel black finish, hood goddess ornament, working jump seats.',20.61,'C',NULL,NULL),('S24_2300','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1962 Volkswagen Microbus','1:24','Autoart Studio Design','This 1:18 scale die cast replica of the 1962 Microbus is loaded with features: A working steering system, opening front doors and tailgate, and famous two-tone factory baked enamel finish, are all topped of by the sliding, real fabric, sunroof.',61.34,'C',NULL,NULL),('S24_2360','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1982 Ducati 900 Monster','1:24','Highway 66 Mini Classics','Features two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand',47.1,'C',NULL,NULL),('S24_2766','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1949 Jaguar XK 120','1:24','Classic Metal Creations','Precision-engineered from original Jaguar specification in perfect scale ratio. Features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',47.25,'C',NULL,NULL),('S24_2840','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1958 Chevy Corvette Limited Edition','1:24','Carousel DieCast Legends','The operating parts of this 1958 Chevy Corvette Limited Edition are particularly delicate due to their precise scale and require special care and attention. Features rotating wheels, working streering, opening doors and trunk. Color dark green.',15.91,'C',NULL,NULL),('S24_2841','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1900s Vintage Bi-Plane','1:24','Autoart Studio Design','Hand crafted diecast-like metal bi-plane is re-created in about 1:24 scale of antique pioneer airplane. All hand-assembled with many different parts. Hand-painted in classic yellow and features correct markings of original airplane.',34.25,'C',NULL,NULL),('S24_2887','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1952 Citroen-15CV','1:24','Exoto Designs','Precision crafted hand-assembled 1:18 scale reproduction of the 1952 15CV, with its independent spring suspension, working steering system, opening doors and hood, detailed engine and instrument panel, all topped of with a factory fresh baked enamel finish.',72.82,'C',NULL,NULL),('S24_2972','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1982 Lamborghini Diablo','1:24','Second Gear Diecast','This replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',16.24,'C',NULL,NULL),('S24_3151','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1912 Ford Model T Delivery Wagon','1:24','Min Lin Diecast','This model features chrome trim and grille, opening hood, opening doors, opening trunk, detailed engine, working steering system. Color white.',46.91,'C',NULL,NULL),('S24_3191','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1969 Chevrolet Camaro Z28','1:24','Exoto Designs','1969 Z/28 Chevy Camaro 1:24 scale replica. The operating parts of this limited edition 1:24 scale diecast model car 1969 Chevy Camaro Z28- hood, trunk, wheels, streering, suspension and doors- are particularly delicate due to their precise scale and require special care and attention.',50.51,'C',NULL,NULL),('S24_3371','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1971 Alpine Renault 1600s','1:24','Welly Diecast Productions','This 1971 Alpine Renault 1600s replica Features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',38.58,'C',NULL,NULL),('S24_3420','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1937 Horch 930V Limousine','1:24','Autoart Studio Design','Features opening hood, opening doors, opening trunk, wide white wall tires, front door arm rests, working steering system',26.3,'C',NULL,NULL),('S24_3432','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'2002 Chevy Corvette','1:24','Gearbox Collectibles','The operating parts of this limited edition Diecast 2002 Chevy Corvette 50th Anniversary Pace car Limited Edition are particularly delicate due to their precise scale and require special care and attention. Features rotating wheels, poseable streering, opening doors and trunk.',62.11,'C',NULL,NULL),('S24_3816','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1940 Ford Delivery Sedan','1:24','Carousel DieCast Legends','Chrome Trim, Chrome Grille, Opening Hood, Opening Doors, Opening Trunk, Detailed Engine, Working Steering System. Color black.',48.64,'C',NULL,NULL),('S24_3856','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1956 Porsche 356A Coupe','1:18','Classic Metal Creations','Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',98.3,'C',NULL,NULL),('S24_3949','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'Corsair F4U ( Bird Cage)','1:24','Second Gear Diecast','Has retractable wheels and comes with a stand. Official logos and insignias.',29.34,'C',NULL,NULL),('S24_3969','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1936 Mercedes Benz 500k Roadster','1:24','Red Start Diecast','This model features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system and rubber wheels. Color black.',21.75,'C',NULL,NULL),('S24_4048','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1992 Porsche Cayenne Turbo Silver','1:24','Exoto Designs','This replica features opening doors, superb detail and craftsmanship, working steering system, opening forward compartment, opening rear trunk with removable spare, 4 wheel independent spring suspension as well as factory baked enamel finish.',69.78,'C',NULL,NULL),('S24_4258','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1936 Chrysler Airflow','1:24','Second Gear Diecast','Features opening trunk,  working steering system. Color dark green.',57.46,'C',NULL,NULL),('S24_4278','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1900s Vintage Tri-Plane','1:24','Unimax Art Galleries','Hand crafted diecast-like metal Triplane is Re-created in about 1:24 scale of antique pioneer airplane. This antique style metal triplane is all hand-assembled with many different parts.',36.23,'C',NULL,NULL),('S24_4620','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1961 Chevrolet Impala','1:18','Classic Metal Creations','This 1:18 scale precision die-cast reproduction of the 1961 Chevrolet Impala has all the features-doors, hood and trunk that open; detailed 409 cubic-inch engine; chrome dashboard and stick shift, two-tone interior; working steering system; all topped of with a factory baked-enamel finish.',32.33,'C',NULL,NULL),('S32_1268','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1980’s GM Manhattan Express','1:32','Motor City Art Classics','This 1980’s era new look Manhattan express is still active, running from the Bronx to mid-town Manhattan. Has 35 opeining windows and working lights. Needs a battery.',53.93,'C',NULL,NULL),('S32_1374','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1997 BMW F650 ST','1:32','Exoto Designs','Features official die-struck logos and baked enamel finish. Comes with stand.',66.92,'C',NULL,NULL),('S32_2206','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1982 Ducati 996 R','1:32','Gearbox Collectibles','Features rotating wheels , working kick stand. Comes with stand.',24.14,'C',NULL,NULL),('S32_2509','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1954 Greyhound Scenicruiser','1:32','Classic Metal Creations','Model features bi-level seating, 50 windows, skylights & glare resistant glass, working steering system, original logos',25.98,'C',NULL,NULL),('S32_3207','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1950\'s Chicago Surface Lines Streetcar','1:32','Gearbox Collectibles','This streetcar is a joy to see. It has 80 separate windows, electric wire guides, detailed interiors with seats, poles and drivers controls, rolling and turning wheel assemblies, plus authentic factory baked-enamel finishes (Green Hornet for Chicago and Cream and Crimson for Boston).',26.72,'C',NULL,NULL),('S32_3522','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1996 Peterbilt 379 Stake Bed with Outrigger','1:32','Red Start Diecast','This model features, opening doors, detailed engine, working steering, tinted windows, detailed interior, die-struck logos, removable stakes operating outriggers, detachable second trailer, functioning 360-degree self loader, precision molded resin trailer and trim, baked enamel finish on cab',33.61,'C',NULL,NULL),('S32_4289','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1928 Ford Phaeton Deluxe','1:32','Highway 66 Mini Classics','This model features grille-mounted chrome horn, lift-up louvered hood, fold-down rumble seat, working steering system',33.02,'C',NULL,NULL),('S32_4485','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1974 Ducati 350 Mk3 Desmo','1:32','Second Gear Diecast','This model features two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand',56.13,'C',NULL,NULL),('S50_1341','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1930 Buick Marquette Phaeton','1:50','Studio M Art Models','Features opening trunk,  working steering system',27.06,'C',NULL,NULL),('S50_1392','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'Diamond T620 Semi-Skirted Tanker','1:50','Highway 66 Mini Classics','This limited edition model is licensed and perfectly scaled for Lionel Trains. The Diamond T620 has been produced in solid precision diecast and painted with a fire baked enamel finish. It comes with a removable tanker and is a perfect model to add authenticity to your static train or car layout or to just have on display.',68.29,'C',NULL,NULL),('S50_1514','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1962 City of Detroit Streetcar','1:50','Classic Metal Creations','This streetcar is a joy to see. It has 99 separate windows, electric wire guides, detailed interiors with seats, poles and drivers controls, rolling and turning wheel assemblies, plus authentic factory baked-enamel finishes (Green Hornet for Chicago and Cream and Crimson for Boston).',37.49,'C',NULL,NULL),('S50_4713','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'2002 Yamaha YZR M1','1:50','Autoart Studio Design','Features rotating wheels , working kick stand. Comes with stand.',34.17,'C',NULL,NULL),('S700_1138','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'The Schooner Bluenose','1:700','Autoart Studio Design','All wood with canvas sails. Measures 31 1/2 inches in Length, 22 inches High and 4 3/4 inches Wide. Many extras.\r\nThe schooner Bluenose was built in Nova Scotia in 1921 to fish the rough waters off the coast of Newfoundland. Because of the Bluenose racing prowess she became the pride of all Canadians. Still featured on stamps and the Canadian dime, the Bluenose was lost off Haiti in 1946.',34,'C',NULL,NULL),('S700_1691','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'American Airlines: B767-300','1:700','Min Lin Diecast','Exact replia with official logos and insignias and retractable wheels',51.15,'C',NULL,NULL),('S700_1938','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'The Mayflower','1:700','Studio M Art Models','Measures 31 1/2 inches Long x 25 1/2 inches High x 10 5/8 inches Wide\r\nAll wood with canvas sail. Extras include long boats, rigging, ladders, railing, anchors, side cannons, hand painted, etc.',43.3,'C',NULL,NULL),('S700_2047','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'HMS Bounty','1:700','Unimax Art Galleries','Measures 30 inches Long x 27 1/2 inches High x 4 3/4 inches Wide. \r\nMany extras including rigging, long boats, pilot house, anchors, etc. Comes with three masts, all square-rigged.',39.83,'C',NULL,NULL),('S700_2466','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'America West Airlines B757-200','1:700','Motor City Art Classics','Official logos and insignias. Working steering system. Rotating jet engines',68.8,'C',NULL,NULL),('S700_2610','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'The USS Constitution Ship','1:700','Red Start Diecast','All wood with canvas sails. Measures 31 1/2\" Length x 22 3/8\" High x 8 1/4\" Width. Extras include 4 boats on deck, sea sprite on bow, anchors, copper railing, pilot houses, etc.',33.97,'C',NULL,NULL),('S700_2824','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'1982 Camaro Z28','1:18','Carousel DieCast Legends','Features include opening and closing doors. Color: White. \r\nMeasures approximately 9 1/2\" Long.',46.53,'C',NULL,NULL),('S700_2834','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'ATA: B757-300','1:700','Highway 66 Mini Classics','Exact replia with official logos and insignias and retractable wheels',59.33,'C',NULL,NULL),('S700_3167','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'F/A 18 Hornet 1/72','1:72','Motor City Art Classics','10\" Wingspan with retractable landing gears.Comes with pilot',54.4,'C',NULL,NULL),('S700_3505','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'The Titanic','1:700','Carousel DieCast Legends','Completed model measures 19 1/2 inches long, 9 inches high, 3inches wide and is in barn red/black. All wood and metal.',51.09,'C',NULL,NULL),('S700_3962','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'The Queen Mary','1:700','Welly Diecast Productions','Exact replica. Wood and Metal. Many extras including rigging, long boats, pilot house, anchors, etc. Comes with three masts, all square-rigged.',53.63,'C',NULL,NULL),('S700_4002','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'American Airlines: MD-11S','1:700','Second Gear Diecast','Polished finish. Exact replia with official logos and insignias and retractable wheels',36.27,'D',NULL,NULL),('S72_1253','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'Boeing X-32A JSF','1:72','Motor City Art Classics','10\" Wingspan with retractable landing gears.Comes with pilot',32.77,'D',NULL,NULL),('S72_3212','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'Pont Yacht','1:72','Unimax Art Galleries','Measures 38 inches Long x 33 3/4 inches High. Includes a stand.\r\nMany extras including rigging, long boats, pilot house, anchors, etc. Comes with 2 masts, all square-rigged',33.3,'D',NULL,NULL),('XX00001','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'USS Enterprise','1:50','Star Trek Limited','Star Trek Explorer Ship',100,'C',NULL,NULL),('XX00002','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'USS Exelsior','1:50','Star Trek Limited','Star Trek Explorer Ship',100,'C',NULL,NULL),('XX00003','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'USS Roosevelt','1:50','Star Trek Limited','Star Trek Explorer Ship',100,'D',NULL,NULL),('XX00004','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'Lego Starwars','1:20','Lego','big lego',100,'D','mark@toys.com','new product'),('XX00005','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'Honda Civic','1:200','Hotwheels','factory fresh',100,'C','mark1@toys.com','Add new product'),('XX00006','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'Corvette Stingray','1:200','Hotwheels','factory fresh',100,'C','mark1@toys.com','Add new product'),('XX00007','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'Toyota Tacoma','1:200','Hotwheels','factory fresh',100,'D','mike1@toys.com','new product'),('XX00008','2024-07-20 03:43:23','C',NULL,NULL,NULL,NULL,NULL,NULL,'Toyota Supra','1:200','Hotwheels','factory fresh',100,'D','mike1@toys.com','new product');
/*!40000 ALTER TABLE `products_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_checkno`
--

DROP TABLE IF EXISTS `ref_checkno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_checkno` (
  `checkno` int NOT NULL,
  `bank` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`checkno`),
  KEY `FK-49_001_idx` (`bank`),
  CONSTRAINT `FK-49_001` FOREIGN KEY (`bank`) REFERENCES `banks` (`bank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_checkno`
--

LOCK TABLES `ref_checkno` WRITE;
/*!40000 ALTER TABLE `ref_checkno` DISABLE KEYS */;
/*!40000 ALTER TABLE `ref_checkno` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ref_checkno_BEFORE_INSERT` BEFORE INSERT ON `ref_checkno` FOR EACH ROW BEGIN
	DECLARE newcheckno INT;
	SELECT MIN(checkno) INTO newcheckno FROM ref_checkno_refidentifiers WHERE status = 'U';
	IF (newcheckno is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot generate new check number, reference IDs were already exhausted.";
	END IF;
		UPDATE ref_checkno_refidentifiers SET status = 'D' WHERE checkno = newcheckno;
		SET new.checkno = newcheckno;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ref_checkno_AFTER_INSERT` AFTER INSERT ON `ref_checkno` FOR EACH ROW BEGIN
	INSERT INTO ref_checkno_audit VALUES(new.checkno,  now(), 'C', NULL , new.bank, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ref_checkno_AFTER_UPDATE` AFTER UPDATE ON `ref_checkno` FOR EACH ROW BEGIN
	IF (old.checkno <> new.checkno) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "checkno cannot be modified";
	END IF;

	INSERT INTO ref_checkno_audit VALUES(new.checkno,  now(), 'U',  old.bank, new.bank, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ref_checkno_BEFORE_DELETE` BEFORE DELETE ON `ref_checkno` FOR EACH ROW BEGIN
	INSERT INTO ref_checkno_audit VALUES(old.checkno,  now(), 'D',  old.bank, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ref_checkno_audit`
--

DROP TABLE IF EXISTS `ref_checkno_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_checkno_audit` (
  `checkno` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_bank` int DEFAULT NULL,
  `new_bank` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`checkno`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_checkno_audit`
--

LOCK TABLES `ref_checkno_audit` WRITE;
/*!40000 ALTER TABLE `ref_checkno_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `ref_checkno_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_checkno_refidentifiers`
--

DROP TABLE IF EXISTS `ref_checkno_refidentifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_checkno_refidentifiers` (
  `checkno` int NOT NULL,
  `status` enum('U','D') DEFAULT NULL,
  PRIMARY KEY (`checkno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_checkno_refidentifiers`
--

LOCK TABLES `ref_checkno_refidentifiers` WRITE;
/*!40000 ALTER TABLE `ref_checkno_refidentifiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `ref_checkno_refidentifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_paymentreferenceno`
--

DROP TABLE IF EXISTS `ref_paymentreferenceno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_paymentreferenceno` (
  `referenceNo` int NOT NULL,
  `bank` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`referenceNo`),
  KEY `FK-30_001_idx` (`bank`),
  CONSTRAINT `FK-30_001` FOREIGN KEY (`bank`) REFERENCES `banks` (`bank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_paymentreferenceno`
--

LOCK TABLES `ref_paymentreferenceno` WRITE;
/*!40000 ALTER TABLE `ref_paymentreferenceno` DISABLE KEYS */;
/*!40000 ALTER TABLE `ref_paymentreferenceno` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ref_paymentreferenceNo_BEFORE_INSERT` BEFORE INSERT ON `ref_paymentreferenceno` FOR EACH ROW BEGIN
	DECLARE newreferenceNo INT;
	SELECT MIN(referenceNo) INTO newreferenceNo FROM ref_paymentreferenceNo_refidentifiers WHERE status = 'U';
	IF (newreferenceNo is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cannot generate new reference number, reference IDs were already exhausted.";
	END IF;
		UPDATE ref_paymentreferenceNo_refidentifiers SET status = 'D' WHERE referenceNo = newreferenceNo;
		SET new.referenceNo = newreferenceNo;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ref_paymentreferenceNo_AFTER_INSERT` AFTER INSERT ON `ref_paymentreferenceno` FOR EACH ROW BEGIN
	INSERT INTO ref_paymentreferenceNo_audit VALUES(new.referenceNo,  now(), 'C', NULL , new.bank, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ref_paymentreferenceNo_AFTER_UPDATE` AFTER UPDATE ON `ref_paymentreferenceno` FOR EACH ROW BEGIN
	IF (old.referenceNo <> new.referenceNo) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "referenceNoproductlines cannot be modified";
	END IF;

	INSERT INTO ref_paymentreferenceNo_audit VALUES(new.referenceNo,  now(), 'U',  old.bank, new.bank, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ref_paymentreferenceNo_BEFORE_DELETE` BEFORE DELETE ON `ref_paymentreferenceno` FOR EACH ROW BEGIN
	INSERT INTO ref_paymentreferenceNo_audit VALUES(old.referenceNo,  now(), 'D',  old.bank, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ref_paymentreferenceno_audit`
--

DROP TABLE IF EXISTS `ref_paymentreferenceno_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_paymentreferenceno_audit` (
  `referenceNo` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old_bank` int DEFAULT NULL,
  `new_bank` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`referenceNo`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_paymentreferenceno_audit`
--

LOCK TABLES `ref_paymentreferenceno_audit` WRITE;
/*!40000 ALTER TABLE `ref_paymentreferenceno_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `ref_paymentreferenceno_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_paymentreferenceno_refidentifiers`
--

DROP TABLE IF EXISTS `ref_paymentreferenceno_refidentifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_paymentreferenceno_refidentifiers` (
  `referenceNo` int NOT NULL,
  `status` enum('U','D') DEFAULT NULL,
  PRIMARY KEY (`referenceNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_paymentreferenceno_refidentifiers`
--

LOCK TABLES `ref_paymentreferenceno_refidentifiers` WRITE;
/*!40000 ALTER TABLE `ref_paymentreferenceno_refidentifiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `ref_paymentreferenceno_refidentifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_shipmentstatus`
--

DROP TABLE IF EXISTS `ref_shipmentstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_shipmentstatus` (
  `status` int NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_shipmentstatus`
--

LOCK TABLES `ref_shipmentstatus` WRITE;
/*!40000 ALTER TABLE `ref_shipmentstatus` DISABLE KEYS */;
INSERT INTO `ref_shipmentstatus` VALUES (4001,'For Pickup',NULL,NULL),(4002,'Picked-up by Courier',NULL,NULL),(4003,'in Courier Sortation Center',NULL,NULL),(4004,'in Courier Local Hub',NULL,NULL),(4005,'for 1st Delivery',NULL,NULL),(4006,'Failed 1st Delivery',NULL,NULL),(4007,'for 2nd Attempt Delivery',NULL,NULL),(4008,'Failed 2nd Attempt Delivery',NULL,NULL),(4009,'For Return to Seller',NULL,NULL),(4010,'Returned to Seller',NULL,NULL);
/*!40000 ALTER TABLE `ref_shipmentstatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ref_shipmentstatus_BEFORE_INSERT` BEFORE INSERT ON `ref_shipmentstatus` FOR EACH ROW BEGIN
	-- Implement the Sequential Logic
	DECLARE newstatusnumber INT;
    SELECT MAX(status) + 1 INTO newstatusnumber FROM ref_shipmentstatus_audit; 
    IF (newstatusnumber IS NULL) THEN
        SET newstatusnumber := 4001;
    END IF;
    
    SET new.status = newstatusnumber;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ref_shipmentstatus_AFTER_INSERT` AFTER INSERT ON `ref_shipmentstatus` FOR EACH ROW BEGIN
	 INSERT INTO ref_shipmentstatus_audit VALUES (new.status, now(), 'C', NULL, new.description, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ref_shipmentstatus_AFTER_UPDATE` AFTER UPDATE ON `ref_shipmentstatus` FOR EACH ROW BEGIN
	IF (old.status <> new.status) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bank ID cannot be modified';
    END IF;
	INSERT INTO ref_shipmentstatus_audit VALUES (new.status, now(), 'U', old.description, new.description, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ref_shipmentstatus_BEFORE_DELETE` BEFORE DELETE ON `ref_shipmentstatus` FOR EACH ROW BEGIN
		    INSERT INTO ref_shipmentstatus_audit VALUES (old.status, now(), 'D', old.description, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ref_shipmentstatus_audit`
--

DROP TABLE IF EXISTS `ref_shipmentstatus_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_shipmentstatus_audit` (
  `status` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old.description` varchar(45) DEFAULT NULL,
  `new.description` varchar(45) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`status`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_shipmentstatus_audit`
--

LOCK TABLES `ref_shipmentstatus_audit` WRITE;
/*!40000 ALTER TABLE `ref_shipmentstatus_audit` DISABLE KEYS */;
INSERT INTO `ref_shipmentstatus_audit` VALUES (4001,'2024-07-20 03:43:23','C',NULL,'For Pickup',NULL,NULL),(4002,'2024-07-20 03:43:23','C',NULL,'Picked-up by Courier',NULL,NULL),(4003,'2024-07-20 03:43:23','C',NULL,'in Courier Sortation Center',NULL,NULL),(4004,'2024-07-20 03:43:23','C',NULL,'in Courier Local Hub',NULL,NULL),(4005,'2024-07-20 03:43:23','C',NULL,'for 1st Delivery',NULL,NULL),(4006,'2024-07-20 03:43:23','C',NULL,'Failed 1st Delivery',NULL,NULL),(4007,'2024-07-20 03:43:23','C',NULL,'for 2nd Attempt Delivery',NULL,NULL),(4008,'2024-07-20 03:43:23','C',NULL,'Failed 2nd Attempt Delivery',NULL,NULL),(4009,'2024-07-20 03:43:23','C',NULL,'For Return to Seller',NULL,NULL),(4010,'2024-07-20 03:43:23','C',NULL,'Returned to Seller',NULL,NULL);
/*!40000 ALTER TABLE `ref_shipmentstatus_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `riders`
--

DROP TABLE IF EXISTS `riders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `riders` (
  `mobileno` int NOT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `courierName` varchar(100) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`mobileno`),
  KEY `FK-60_001_idx` (`courierName`),
  CONSTRAINT `FK-60_001` FOREIGN KEY (`courierName`) REFERENCES `couriers` (`courierName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riders`
--

LOCK TABLES `riders` WRITE;
/*!40000 ALTER TABLE `riders` DISABLE KEYS */;
INSERT INTO `riders` VALUES (91612345,'Roldan','Ronald','Gogo Xpress',NULL,NULL),(91712345,'Salazar','Mark','Lalamove',NULL,NULL),(91812345,'Balunton','Mark','Grab',NULL,NULL);
/*!40000 ALTER TABLE `riders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `riders_AFTER_INSERT` AFTER INSERT ON `riders` FOR EACH ROW BEGIN
	INSERT INTO riders_audit VALUES (new.mobileno, now(), 'C', NULL, NULL, NULL, new.lastName, new.firstName, new.courierName, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `riders_AFTER_UPDATE` AFTER UPDATE ON `riders` FOR EACH ROW BEGIN
	IF (old.mobileno <> new.mobileno) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'mobileno ID cannot be modified';
    END IF;
    INSERT INTO riders_audit VALUES (new.mobileno, now(), 'U', old.lastName, old.firstName, old.courierName, new.lastName, new.firstName, new.courierName, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `riders_BEFORE_DELETE` BEFORE DELETE ON `riders` FOR EACH ROW BEGIN
	INSERT INTO riders_audit VALUES (old.mobileno, now(), 'D', old.lastName, old.firstName, old.courierName, NULL, NULL, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `riders_audit`
--

DROP TABLE IF EXISTS `riders_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `riders_audit` (
  `mobileno` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old.lastName` varchar(45) DEFAULT NULL,
  `old.firstName` varchar(45) DEFAULT NULL,
  `old.courierName` varchar(100) DEFAULT NULL,
  `new.lastName` varchar(45) DEFAULT NULL,
  `new.firstName` varchar(45) DEFAULT NULL,
  `new.courierName` varchar(100) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`mobileno`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riders_audit`
--

LOCK TABLES `riders_audit` WRITE;
/*!40000 ALTER TABLE `riders_audit` DISABLE KEYS */;
INSERT INTO `riders_audit` VALUES (91612345,'2024-07-20 03:43:23','C',NULL,NULL,NULL,'Roldan','Ronald','Gogo Xpress',NULL,NULL),(91712345,'2024-07-20 03:43:23','C',NULL,NULL,NULL,'Salazar','Mark','Lalamove',NULL,NULL),(91812345,'2024-07-20 03:43:23','C',NULL,NULL,NULL,'Balunton','Mark','Grab',NULL,NULL);
/*!40000 ALTER TABLE `riders_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rpt_discounts`
--

DROP TABLE IF EXISTS `rpt_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rpt_discounts` (
  `report_id` int NOT NULL,
  `productLine` varchar(50) NOT NULL,
  `product` varchar(70) NOT NULL,
  `country` varchar(50) NOT NULL,
  `office` varchar(10) NOT NULL,
  `salesrepresentative` int NOT NULL,
  `month` int NOT NULL,
  `year` int NOT NULL,
  `discounts` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`report_id`,`productLine`,`product`,`country`,`office`,`salesrepresentative`,`month`,`year`),
  CONSTRAINT `FK88-00005` FOREIGN KEY (`report_id`) REFERENCES `rpt_masterlist` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rpt_discounts`
--

LOCK TABLES `rpt_discounts` WRITE;
/*!40000 ALTER TABLE `rpt_discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `rpt_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rpt_markups`
--

DROP TABLE IF EXISTS `rpt_markups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rpt_markups` (
  `report_id` int NOT NULL,
  `productLine` varchar(50) NOT NULL,
  `product` varchar(70) NOT NULL,
  `country` varchar(50) NOT NULL,
  `office` varchar(10) NOT NULL,
  `salesrepresentative` int NOT NULL,
  `month` int NOT NULL,
  `year` int NOT NULL,
  `markup` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`report_id`,`productLine`,`product`,`country`,`office`,`month`,`salesrepresentative`,`year`),
  CONSTRAINT `FK88-4001` FOREIGN KEY (`report_id`) REFERENCES `rpt_masterlist` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rpt_markups`
--

LOCK TABLES `rpt_markups` WRITE;
/*!40000 ALTER TABLE `rpt_markups` DISABLE KEYS */;
/*!40000 ALTER TABLE `rpt_markups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rpt_masterlist`
--

DROP TABLE IF EXISTS `rpt_masterlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rpt_masterlist` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(70) DEFAULT NULL,
  `reportgenerationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB AUTO_INCREMENT=719 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rpt_masterlist`
--

LOCK TABLES `rpt_masterlist` WRITE;
/*!40000 ALTER TABLE `rpt_masterlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `rpt_masterlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rpt_pricingvariation`
--

DROP TABLE IF EXISTS `rpt_pricingvariation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rpt_pricingvariation` (
  `report_id` int NOT NULL,
  `productLine` varchar(100) NOT NULL,
  `product` varchar(70) NOT NULL,
  `month` int NOT NULL,
  `year` int NOT NULL,
  `pricingVariation` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`productLine`,`report_id`,`product`,`month`,`year`),
  KEY `FK90_9001_idx` (`report_id`),
  CONSTRAINT `FK90_9001` FOREIGN KEY (`report_id`) REFERENCES `rpt_masterlist` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rpt_pricingvariation`
--

LOCK TABLES `rpt_pricingvariation` WRITE;
/*!40000 ALTER TABLE `rpt_pricingvariation` DISABLE KEYS */;
/*!40000 ALTER TABLE `rpt_pricingvariation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rpt_quantityordered`
--

DROP TABLE IF EXISTS `rpt_quantityordered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rpt_quantityordered` (
  `report_id` int NOT NULL,
  `productLine` varchar(50) NOT NULL,
  `product` varchar(70) NOT NULL,
  `country` varchar(50) NOT NULL,
  `office` varchar(10) NOT NULL,
  `salesrepresentative` int NOT NULL,
  `month` int NOT NULL,
  `year` int NOT NULL,
  `quantityOrdered` int DEFAULT NULL,
  PRIMARY KEY (`report_id`,`productLine`,`product`,`country`,`office`,`salesrepresentative`,`month`,`year`),
  KEY `FK30001_idx` (`report_id`),
  CONSTRAINT `FK88-30001` FOREIGN KEY (`report_id`) REFERENCES `rpt_masterlist` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rpt_quantityordered`
--

LOCK TABLES `rpt_quantityordered` WRITE;
/*!40000 ALTER TABLE `rpt_quantityordered` DISABLE KEYS */;
/*!40000 ALTER TABLE `rpt_quantityordered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rpt_sales`
--

DROP TABLE IF EXISTS `rpt_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rpt_sales` (
  `report_id` int NOT NULL,
  `productLine` varchar(50) NOT NULL,
  `product` varchar(70) NOT NULL,
  `country` varchar(50) NOT NULL,
  `office` varchar(10) NOT NULL,
  `salesrepresentative` int NOT NULL,
  `month` int NOT NULL,
  `year` int NOT NULL,
  `total_sales` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`report_id`,`productLine`,`product`,`country`,`office`,`salesrepresentative`,`month`,`year`),
  CONSTRAINT `FK88-00001` FOREIGN KEY (`report_id`) REFERENCES `rpt_masterlist` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rpt_sales`
--

LOCK TABLES `rpt_sales` WRITE;
/*!40000 ALTER TABLE `rpt_sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `rpt_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rpt_turnaroundtime`
--

DROP TABLE IF EXISTS `rpt_turnaroundtime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rpt_turnaroundtime` (
  `report_id` int NOT NULL,
  `country` varchar(50) NOT NULL,
  `office` varchar(10) NOT NULL,
  `month` int NOT NULL,
  `year` int NOT NULL,
  `avg_TurnaroundTime` time NOT NULL,
  PRIMARY KEY (`report_id`,`country`,`office`,`month`,`year`,`avg_TurnaroundTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rpt_turnaroundtime`
--

LOCK TABLES `rpt_turnaroundtime` WRITE;
/*!40000 ALTER TABLE `rpt_turnaroundtime` DISABLE KEYS */;
/*!40000 ALTER TABLE `rpt_turnaroundtime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `rptview_discounts`
--

DROP TABLE IF EXISTS `rptview_discounts`;
/*!50001 DROP VIEW IF EXISTS `rptview_discounts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `rptview_discounts` AS SELECT 
 1 AS `productLine`,
 1 AS `productName`,
 1 AS `country`,
 1 AS `officeCode`,
 1 AS `salesRepEmployeeNumber`,
 1 AS `Month`,
 1 AS `Year`,
 1 AS `discounts`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `rptview_markup`
--

DROP TABLE IF EXISTS `rptview_markup`;
/*!50001 DROP VIEW IF EXISTS `rptview_markup`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `rptview_markup` AS SELECT 
 1 AS `productLine`,
 1 AS `productName`,
 1 AS `country`,
 1 AS `officeCode`,
 1 AS `salesRepEmployeeNumber`,
 1 AS `month`,
 1 AS `year`,
 1 AS `total_markup`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `rptview_pricingvariation`
--

DROP TABLE IF EXISTS `rptview_pricingvariation`;
/*!50001 DROP VIEW IF EXISTS `rptview_pricingvariation`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `rptview_pricingvariation` AS SELECT 
 1 AS `productLine`,
 1 AS `product`,
 1 AS `month`,
 1 AS `year`,
 1 AS `pricingVariation`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `rptview_quantityordered`
--

DROP TABLE IF EXISTS `rptview_quantityordered`;
/*!50001 DROP VIEW IF EXISTS `rptview_quantityordered`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `rptview_quantityordered` AS SELECT 
 1 AS `productLine`,
 1 AS `productName`,
 1 AS `country`,
 1 AS `officeCode`,
 1 AS `salesRepEmployeeNumber`,
 1 AS `Month`,
 1 AS `Year`,
 1 AS `total_quantityOrdered`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `rptview_sales`
--

DROP TABLE IF EXISTS `rptview_sales`;
/*!50001 DROP VIEW IF EXISTS `rptview_sales`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `rptview_sales` AS SELECT 
 1 AS `productLine`,
 1 AS `productName`,
 1 AS `country`,
 1 AS `officeCode`,
 1 AS `salesRepEmployeeNumber`,
 1 AS `Month`,
 1 AS `Year`,
 1 AS `total_sales`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `rptview_turnaroundtime`
--

DROP TABLE IF EXISTS `rptview_turnaroundtime`;
/*!50001 DROP VIEW IF EXISTS `rptview_turnaroundtime`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `rptview_turnaroundtime` AS SELECT 
 1 AS `country`,
 1 AS `officeCode`,
 1 AS `month`,
 1 AS `year`,
 1 AS `avg_TurnaroundTime`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sales_managers`
--

DROP TABLE IF EXISTS `sales_managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_managers` (
  `employeeNumber` int NOT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeNumber`),
  CONSTRAINT `FK-89_001` FOREIGN KEY (`employeeNumber`) REFERENCES `non_salesrepresentatives` (`employeeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_managers`
--

LOCK TABLES `sales_managers` WRITE;
/*!40000 ALTER TABLE `sales_managers` DISABLE KEYS */;
INSERT INTO `sales_managers` VALUES (1088,NULL,NULL),(1102,NULL,NULL),(1143,NULL,NULL),(20242708,NULL,NULL),(20242711,NULL,NULL),(20242716,NULL,NULL),(20242725,NULL,NULL),(20242727,NULL,NULL),(20242730,NULL,NULL);
/*!40000 ALTER TABLE `sales_managers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sales_managers_BEFORE_INSERT` BEFORE INSERT ON `sales_managers` FOR EACH ROW BEGIN
	IF isDeactivated(NEW.employeeNumber) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 30A4: Employee Record is Deactivated';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sales_managers_AFTER_INSERT` AFTER INSERT ON `sales_managers` FOR EACH ROW BEGIN
	INSERT INTO sales_managers_audit VALUES (new.employeeNumber, now(), 'C', new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sales_managers_AFTER_UPDATE` AFTER UPDATE ON `sales_managers` FOR EACH ROW BEGIN
	-- IF (old.employeeNumber <> new.employeeNumber) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'employeeNumber ID cannot be modified';
    -- END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sales_managers_BEFORE_DELETE` BEFORE DELETE ON `sales_managers` FOR EACH ROW BEGIN
	INSERT INTO sales_managers_audit VALUES (old.employeeNumber, now(), 'D', NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sales_managers_audit`
--

DROP TABLE IF EXISTS `sales_managers_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_managers_audit` (
  `employeeNumber` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeNumber`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_managers_audit`
--

LOCK TABLES `sales_managers_audit` WRITE;
/*!40000 ALTER TABLE `sales_managers_audit` DISABLE KEYS */;
INSERT INTO `sales_managers_audit` VALUES (1088,'2024-07-20 03:43:23','C',NULL,NULL),(1102,'2024-07-20 03:43:23','C',NULL,NULL),(1143,'2024-07-20 03:43:23','C',NULL,NULL),(20242708,'2024-07-20 03:43:23','C',NULL,NULL),(20242711,'2024-07-20 03:43:23','C',NULL,NULL),(20242716,'2024-07-20 03:43:23','C',NULL,NULL),(20242725,'2024-07-20 03:43:23','C',NULL,NULL),(20242727,'2024-07-20 03:43:23','C',NULL,NULL),(20242730,'2024-07-20 03:43:23','C',NULL,NULL);
/*!40000 ALTER TABLE `sales_managers_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesrepassignments`
--

DROP TABLE IF EXISTS `salesrepassignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesrepassignments` (
  `employeeNumber` int NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date DEFAULT NULL,
  `reason` varchar(45) DEFAULT NULL,
  `quota` decimal(9,2) DEFAULT NULL,
  `salesManagerNumber` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeNumber`,`officeCode`,`startDate`),
  KEY `FK-88_002_idx` (`officeCode`),
  KEY `FK-88_003_idx` (`salesManagerNumber`),
  CONSTRAINT `FK-88_001` FOREIGN KEY (`employeeNumber`) REFERENCES `employees` (`employeeNumber`),
  CONSTRAINT `FK-88_002` FOREIGN KEY (`officeCode`) REFERENCES `offices` (`officeCode`),
  CONSTRAINT `FK-88_003` FOREIGN KEY (`salesManagerNumber`) REFERENCES `employees` (`employeeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesrepassignments`
--

LOCK TABLES `salesrepassignments` WRITE;
/*!40000 ALTER TABLE `salesrepassignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `salesrepassignments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesRepAssignments_AFTER_INSERT` AFTER INSERT ON `salesrepassignments` FOR EACH ROW BEGIN
	INSERT INTO salesRepAssignments_audit VALUES (new.employeeNumber, new.officeCode, new.startDate, now(), 'C', NULL, NULL, NULL, NULL, new.endDate, new.reason, new.quota, new.salesManagerNumber, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesRepAssignments_BEFORE_UPDATE` BEFORE UPDATE ON `salesrepassignments` FOR EACH ROW BEGIN
	IF (OLD.employeeNumber <> NEW.employeeNumber) 
       OR (OLD.officeCode <> NEW.officeCode) 
       OR (OLD.startDate <> NEW.startDate) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 30011: employeeNumber, officeCode, and startDate cannot be modified';
    END IF;
    
    IF NEW.endDate IS NOT NULL AND DATE_ADD(NEW.startDate, INTERVAL 1 MONTH) < NEW.endDate  THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 30012: Assigment is restricted to a maximum of one month';
    END IF;
    
    IF DATEDIFF(NEW.endDate, NEW.startDate) < 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 30015: Assigment start date is after end date';
    END IF;
    
    IF NEW.quota IS NULL OR NEW.quota < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 30013: Quota must be a positive value';
    END IF;
    
    IF getEmployeeType(NEW.salesManagerNumber) != 2 and new.salesManagerNumber != 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 30A6: Employee is not sales Manager';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesRepAssignments_AFTER_UPDATE` AFTER UPDATE ON `salesrepassignments` FOR EACH ROW BEGIN
	
    INSERT INTO salesRepAssignments_audit VALUES (new.employeeNumber, new.officeCode, new.startDate, now(), 'U', old.endDate, old.reason, old.quota, old.salesManagerNumber, new.endDate, new.reason, new.quota, new.salesManagerNumber, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesRepAssignments_BEFORE_DELETE` BEFORE DELETE ON `salesrepassignments` FOR EACH ROW BEGIN
	INSERT INTO salesRepAssignments_audit VALUES (old.employeeNumber, old.officeCode, old.startDate, now(), 'D', old.endDate, old.reason, old.quota, old.salesManagerNumber, NULL, NULL, NULL, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `salesrepassignments_audit`
--

DROP TABLE IF EXISTS `salesrepassignments_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesrepassignments_audit` (
  `employeeNumber` int NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `startDate` date NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old.endDate` date DEFAULT NULL,
  `old.reason` varchar(45) DEFAULT NULL,
  `old.quota` decimal(9,2) DEFAULT NULL,
  `old.salesManagerNumber` int DEFAULT NULL,
  `new.endDate` date DEFAULT NULL,
  `new.reason` varchar(45) DEFAULT NULL,
  `new.quota` decimal(9,2) DEFAULT NULL,
  `new.salesManagerNumber` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeNumber`,`officeCode`,`startDate`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesrepassignments_audit`
--

LOCK TABLES `salesrepassignments_audit` WRITE;
/*!40000 ALTER TABLE `salesrepassignments_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `salesrepassignments_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesrepresentatives`
--

DROP TABLE IF EXISTS `salesrepresentatives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesrepresentatives` (
  `employeeNumber` int NOT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeNumber`),
  CONSTRAINT `FK-86_001` FOREIGN KEY (`employeeNumber`) REFERENCES `employees` (`employeeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesrepresentatives`
--

LOCK TABLES `salesrepresentatives` WRITE;
/*!40000 ALTER TABLE `salesrepresentatives` DISABLE KEYS */;
INSERT INTO `salesrepresentatives` VALUES (1165,NULL,NULL),(1166,NULL,NULL),(1188,NULL,NULL),(1216,NULL,NULL),(1286,NULL,NULL),(1323,NULL,NULL),(1337,NULL,NULL),(1370,NULL,NULL),(1401,NULL,NULL),(1501,NULL,NULL),(1504,NULL,NULL),(1611,NULL,NULL),(1612,NULL,NULL),(1619,NULL,NULL),(1621,NULL,NULL),(1625,NULL,NULL),(20242704,NULL,NULL),(20242707,NULL,NULL),(20242731,NULL,NULL);
/*!40000 ALTER TABLE `salesrepresentatives` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesRepresentatives_BEFORE_INSERT` BEFORE INSERT ON `salesrepresentatives` FOR EACH ROW BEGIN
	IF isDeactivated(NEW.employeeNumber) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 30A4: Employee Record is Deactivated';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesRepresentatives_AFTER_INSERT` AFTER INSERT ON `salesrepresentatives` FOR EACH ROW BEGIN
	INSERT INTO salesRepresentatives_audit VALUES (new.employeeNumber, now(), 'C', new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesRepresentatives_AFTER_UPDATE` AFTER UPDATE ON `salesrepresentatives` FOR EACH ROW BEGIN
	-- IF (old.employeeNumber <> new.employeeNumber) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'employeeNumber ID cannot be modified';
    -- END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesRepresentatives_BEFORE_DELETE` BEFORE DELETE ON `salesrepresentatives` FOR EACH ROW BEGIN
	INSERT INTO salesRepresentatives_audit VALUES (old.employeeNumber, now(), 'D', NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `salesrepresentatives_audit`
--

DROP TABLE IF EXISTS `salesrepresentatives_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesrepresentatives_audit` (
  `employeeNumber` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeNumber`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesrepresentatives_audit`
--

LOCK TABLES `salesrepresentatives_audit` WRITE;
/*!40000 ALTER TABLE `salesrepresentatives_audit` DISABLE KEYS */;
INSERT INTO `salesrepresentatives_audit` VALUES (1165,'2024-07-20 03:43:23','C',NULL,NULL),(1166,'2024-07-20 03:43:23','C',NULL,NULL),(1188,'2024-07-20 03:43:23','C',NULL,NULL),(1216,'2024-07-20 03:43:23','C',NULL,NULL),(1286,'2024-07-20 03:43:23','C',NULL,NULL),(1323,'2024-07-20 03:43:23','C',NULL,NULL),(1337,'2024-07-20 03:43:23','C',NULL,NULL),(1370,'2024-07-20 03:43:23','C',NULL,NULL),(1401,'2024-07-20 03:43:23','C',NULL,NULL),(1501,'2024-07-20 03:43:23','C',NULL,NULL),(1504,'2024-07-20 03:43:23','C',NULL,NULL),(1611,'2024-07-20 03:43:23','C',NULL,NULL),(1612,'2024-07-20 03:43:23','C',NULL,NULL),(1619,'2024-07-20 03:43:23','C',NULL,NULL),(1621,'2024-07-20 03:43:23','C',NULL,NULL),(1625,'2024-07-20 03:43:23','C',NULL,NULL),(20242704,'2024-07-20 03:43:23','C',NULL,NULL),(20242707,'2024-07-20 03:43:23','C',NULL,NULL),(20242731,'2024-07-20 03:43:23','C',NULL,NULL);
/*!40000 ALTER TABLE `salesrepresentatives_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipments`
--

DROP TABLE IF EXISTS `shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipments` (
  `referenceNo` int NOT NULL,
  `courierName` varchar(100) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`referenceNo`),
  KEY `FK-63_001_idx` (`courierName`),
  CONSTRAINT `FK-63_001` FOREIGN KEY (`courierName`) REFERENCES `couriers` (`courierName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipments`
--

LOCK TABLES `shipments` WRITE;
/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `shipments_BEFORE_INSERT` BEFORE INSERT ON `shipments` FOR EACH ROW BEGIN
	DECLARE current_year CHAR(4);
    DECLARE fixed_part CHAR(2);
    DECLARE lastNumber CHAR(255);
    DECLARE lastThreeChars CHAR(3);
    DECLARE newRefNo CHAR(255);

    SET current_year = DATE_FORMAT(CURDATE(), '%Y');
    SET fixed_part = '04';

    SELECT MAX(referenceNo) INTO lastNumber FROM shipments_audit;

    IF (lastNumber IS NULL) THEN
        SET newRefNo = CONCAT(current_year, fixed_part, '001');
    ELSE
        SET lastThreeChars = RIGHT(lastNumber, 3);
        SET newRefNo = CONCAT(current_year, fixed_part, LPAD(CAST(lastThreeChars AS UNSIGNED) + 5, 3, '0'));
    END IF;

    SET NEW.referenceNo = newRefNo;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `shipments_AFTER_INSERT` AFTER INSERT ON `shipments` FOR EACH ROW BEGIN
	    INSERT INTO shipments_audit VALUES (new.referenceNo, now(), 'C', NULL, new.courierName, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `shipments_AFTER_UPDATE` AFTER UPDATE ON `shipments` FOR EACH ROW BEGIN
IF (old.referenceNo <> new.referenceNo) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'referenceNo ID cannot be modified';
    END IF;
    INSERT INTO shipments_audit VALUES (new.referenceNo, now(), 'U', old.courierName, new.courierName, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `shipments_BEFORE_DELETE` BEFORE DELETE ON `shipments` FOR EACH ROW BEGIN
		INSERT INTO shipments_audit VALUES (old.referenceNo, now(), 'D', old.courierName, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `shipments_audit`
--

DROP TABLE IF EXISTS `shipments_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipments_audit` (
  `referenceNo` int NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old.courierName` varchar(100) DEFAULT NULL,
  `new.courierName` varchar(100) DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`referenceNo`,`audit_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipments_audit`
--

LOCK TABLES `shipments_audit` WRITE;
/*!40000 ALTER TABLE `shipments_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipments_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipmentstatus`
--

DROP TABLE IF EXISTS `shipmentstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipmentstatus` (
  `referenceNo` int NOT NULL,
  `statusTimeStamp` datetime NOT NULL,
  `status` int DEFAULT NULL,
  `comments` varchar(45) DEFAULT NULL,
  `ridermobileno` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`referenceNo`,`statusTimeStamp`),
  KEY `FK-68_002_idx` (`status`),
  KEY `FK-68_003_idx` (`ridermobileno`),
  CONSTRAINT `FK-68_001` FOREIGN KEY (`referenceNo`) REFERENCES `shipments` (`referenceNo`),
  CONSTRAINT `FK-68_002` FOREIGN KEY (`status`) REFERENCES `ref_shipmentstatus` (`status`),
  CONSTRAINT `FK-68_003` FOREIGN KEY (`ridermobileno`) REFERENCES `riders` (`mobileno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipmentstatus`
--

LOCK TABLES `shipmentstatus` WRITE;
/*!40000 ALTER TABLE `shipmentstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipmentstatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `shipmentStatus_BEFORE_INSERT` BEFORE INSERT ON `shipmentstatus` FOR EACH ROW BEGIN
	-- DECLARE nStatus INT;

--     -- Implement Controlled Value Identifier
--     SELECT COUNT(*) INTO nStatus FROM ref_shipmentStatus WHERE status = NEW.status;

--     IF nStatus = 0 THEN
--         SIGNAL SQLSTATE '45000'
--         SET MESSAGE_TEXT = 'Cannot generate new Status ID, status ID does not exist in ref_shipmentStatus.';
--     END IF;
    
        
    -- System generated statusTimestamp
    SET NEW.statusTimestamp = CURRENT_TIMESTAMP;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `shipmentStatus_AFTER_INSERT` AFTER INSERT ON `shipmentstatus` FOR EACH ROW BEGIN
	INSERT INTO shipmentStatus_audit VALUES (new.referenceNo, new.statusTimeStamp, now(), 'C', NULL, NULL, NULL, new.status, new.comments, new.ridermobileno, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `shipmentStatus_BEFORE_UPDATE` BEFORE UPDATE ON `shipmentstatus` FOR EACH ROW BEGIN
    -- System generated statusTimestamp
    SET NEW.statusTimestamp = CURRENT_TIMESTAMP;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `shipmentStatus_AFTER_UPDATE` AFTER UPDATE ON `shipmentstatus` FOR EACH ROW BEGIN
	IF (OLD.referenceNo <> NEW.referenceNo) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'referenceNo cannot be modified';
		END IF;
		INSERT INTO shipmentStatus_audit VALUES (new.referenceNo, new.statusTimeStamp, now(), 'U', old.status, old.comments, old.ridermobileno, new.status, new.comments, new.ridermobileno, new.end_username, new.end_userreason);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `shipmentStatus_BEFORE_DELETE` BEFORE DELETE ON `shipmentstatus` FOR EACH ROW BEGIN
	INSERT INTO shipmentStatus_audit VALUES (old.referenceNo, old.statusTimeStamp, now(), 'D', old.status, old.comments, old.ridermobileno, NULL, NULL, NULL, NULL, 'Deletion of Record');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `shipmentstatus_audit`
--

DROP TABLE IF EXISTS `shipmentstatus_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipmentstatus_audit` (
  `referenceNo` int NOT NULL,
  `statusTimeStamp` datetime NOT NULL,
  `audit_timestamp` datetime NOT NULL,
  `activity` enum('C','U','D') DEFAULT NULL,
  `old.status` int DEFAULT NULL,
  `old.comments` varchar(45) DEFAULT NULL,
  `old.ridermobileno` int DEFAULT NULL,
  `new.status` int DEFAULT NULL,
  `new.comments` varchar(45) DEFAULT NULL,
  `new.ridermobileno` int DEFAULT NULL,
  `end_username` varchar(45) DEFAULT NULL,
  `end_userreason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`referenceNo`,`audit_timestamp`,`statusTimeStamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipmentstatus_audit`
--

LOCK TABLES `shipmentstatus_audit` WRITE;
/*!40000 ALTER TABLE `shipmentstatus_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipmentstatus_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_messages`
--

DROP TABLE IF EXISTS `tbl_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_messages` (
  `entryno` int NOT NULL AUTO_INCREMENT,
  `messages` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`entryno`)
) ENGINE=InnoDB AUTO_INCREMENT=66891 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_messages`
--

LOCK TABLES `tbl_messages` WRITE;
/*!40000 ALTER TABLE `tbl_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'dbsales2.6'
--

--
-- Dumping routines for database 'dbsales2.6'
--
/*!50003 DROP FUNCTION IF EXISTS `checkDiscontinued` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkDiscontinued`(v_productCode VARCHAR(15)) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE isDiscontinued CHAR(1);
	SELECT product_category INTO isDiscontinued FROM products WHERE productCode = v_productCode;
    IF isDiscontinued = 'D' THEN
		RETURN 1;
    else
		RETURN 0;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `checkPrice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkPrice`(v_productCode VARCHAR(15), v_suppliedPrice DOUBLE) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN    
	IF ((v_suppliedPrice > getPrice(v_productCode,"MAX")) OR (v_suppliedPrice < getPrice(v_productCode, "MIN"))) THEN
		RETURN 0;
	END IF;
	RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `checkRetail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkRetail`(v_productCode VARCHAR(15)) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN

DECLARE product VARCHAR(15);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET product = NULL;

SELECT productCode INTO product FROM product_retail WHERE productCode = v_productCode;

	-- Check if product exists
    IF product IS NOT NULL THEN
        RETURN TRUE; -- Product exists
    ELSE
        RETURN FALSE; -- Product does not exist
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `checkShippedDate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkShippedDate`(v_status VARCHAR(15), v_shippedDate DATETIME, v_orderDate DATETIME) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
	IF v_status = "In Process" THEN
        IF v_shippedDate IS NOT NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 9002: shippedDate can only be set when the status is ''shipped''.';
            SET v_shippedDate = NULL;
        END IF;
    ELSE
        IF v_shippedDate IS NULL THEN
			IF NOT v_status = "Cancelled" THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 9003: shippedDate must be set when the order is already shipped.';
			END IF;
		ELSEIF v_shippedDate < v_orderDate THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 9004: shippedDate must be after the orderdate.';
        END IF;
    END IF;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `checkStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkStatus`(v_orderNumber INT, v_status VARCHAR(15)) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE currentStatus VARCHAR(15);
    
	SET currentStatus = getCurrentStatus(v_orderNumber);
	IF currentStatus = v_status THEN
        RETURN 1;
    END IF;
    
RETURN 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `checkStatusChange` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkStatusChange`(v_oldStatus varchar(15), v_newStatus varchar(15)) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE valid_status_change BOOLEAN;
	--  a. In-Process to Shipped
		-- 	b. Shipped to Disputed
		-- 	C. Disputed to Resolved
		-- 	d. Shipped to Completed
		-- 	e. Resolved to Completed
        
    SET valid_status_change = ( (v_oldStatus = v_newStatus) OR (v_newStatus = 'Cancelled') OR
        (v_oldStatus = 'In Process' AND v_newStatus = 'Shipped') OR
        (v_oldStatus = 'Shipped' AND (v_newStatus = 'Disputed' OR v_newStatus = 'Completed')) OR
        (v_oldStatus = 'Disputed' AND v_newStatus = 'Resolved') OR
        (v_oldStatus = 'Resolved' AND v_newStatus = 'Completed')
    );

RETURN valid_status_change;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `checkWholesale` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `checkWholesale`(v_productCode VARCHAR(15)) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN

DECLARE product VARCHAR(15);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET product = NULL;

SELECT productCode INTO product FROM product_wholesale WHERE productCode = v_productCode;

	-- Check if product exists
    IF product IS NOT NULL THEN
        RETURN TRUE; -- Product exists
    ELSE
        RETURN FALSE; -- Product does not exist
    END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `computeNewStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `computeNewStock`(v_productCode VARCHAR(15), v_orderQuantity INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE old_quantity INT;
    DECLARE new_quantity INT;
    
    SELECT quantityInStock INTO old_quantity
    FROM current_products WHERE productCode = v_productCode;
    
    SET new_quantity := (old_quantity + v_orderQuantity);
    
    RETURN new_quantity;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ComputeRepSale` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `ComputeRepSale`(salesRepEmpNum INT,
    startDate DATE,
    endDate DATE) RETURNS decimal(9,2)
    READS SQL DATA
BEGIN

DECLARE total DECIMAL(9,2);

    SELECT COALESCE(SUM(od.priceEach * od.quantityOrdered), 0)
    INTO total
    FROM salesRepAssignments sra
    JOIN customers c ON c.salesRepEmployeeNumber = sra.employeeNumber
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE 
        c.salesRepEmployeeNumber = salesRepEmpNum
        AND (o.status = 'Completed' OR o.status = 'Shipped')
        AND o.shippedDate BETWEEN startDate AND endDate;
-- Ensure total is not negative
    IF total < 0 THEN
        SET total = 0;
    END IF;


    RETURN total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `expectedQuantity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `expectedQuantity`(v_productCode VARCHAR(15), v_oldquantity INT, v_newquantity INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE	quantity_difference		INT;
    DECLARE quantity_toDeduct		INT;
    DECLARE quantity_toAdd			INT;
    DECLARE projected_Quantity		INT;
    
    SET quantity_difference := v_newquantity - v_oldquantity;
    
	IF (quantity_difference > 0) THEN
		SET quantity_toDeduct := quantity_difference;
		SET quantity_toAdd    := 0;
	ELSEIF (quantity_difference < 0) THEN
		SET quantity_toDeduct := 0;
		SET quantity_toAdd    := -quantity_difference;
	ELSE
		SET quantity_toDeduct := 0;
		SET quantity_toAdd    := 0;
	END IF;
    
    -- Check if updated Quantity will cause a below zero inventory
    SELECT (quantityInStock + quantity_toAdd - quantity_toDeduct) INTO projected_Quantity
    FROM current_products WHERE productCode = v_productCode;

	RETURN projected_Quantity;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `generateLineNumber` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `generateLineNumber`(v_orderNumber INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE new_lineNumber		INT;
        
	SELECT MAX(orderLineNumber)+1 INTO new_lineNumber FROM orderdetails WHERE orderNumber = v_orderNumber;
    IF (new_lineNumber IS NULL) THEN
		SET new_lineNumber := 1;
    END IF;
RETURN new_lineNumber;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getCurrentStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getCurrentStatus`(v_orderNumber INT) RETURNS varchar(15) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
		DECLARE currentStatus VARCHAR(15);

		SELECT status INTO currentStatus
		FROM orders
		WHERE orderNumber = v_orderNumber;
		
		RETURN currentStatus;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getEmployeeType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getEmployeeType`( v_employeeNumber INT) RETURNS smallint
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE v_tableName SMALLINT(1);
    
	/*
		1 - sales_representatives
        2 - sales_managers
        3 - inventory_managers
    */
    
    
    -- Check in sales_representatives
    IF EXISTS (SELECT 1 FROM salesRepresentatives WHERE employeeNumber = v_employeeNumber) THEN
        SET v_tableName = 1;
    -- Check in sales_managers
    ELSEIF EXISTS (SELECT 1 FROM sales_managers WHERE employeeNumber = v_employeeNumber) THEN
        SET v_tableName = 2;
    -- Check in inventory_managers
    ELSEIF EXISTS (SELECT 1 FROM inventory_managers WHERE employeeNumber = v_employeeNumber) THEN
        SET v_tableName = 3;
    ELSE
        SET v_tableName = NULL;
    END IF;

    RETURN v_tableName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getMSRP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getMSRP`(v_productCode VARCHAR(15)) RETURNS decimal(9,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE v_MSRP DECIMAL(9,2);
    DECLARE currentDate DATETIME;
    DECLARE p_type ENUM('R', 'W');
    DECLARE temp_productCode VARCHAR(15); -- Used for determining if the productCode exists.
    
	-- Set currentDate to today
    SET currentDate = NOW();
    
    -- Assuming product_type can be NULL
    SELECT productCode INTO temp_productCode
    FROM current_products
    WHERE productCode = v_productCode;
    
    -- Checks if productCode does not exist
    IF (temp_productCode is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "ERROR 7001: Product Code does not exist!";
	ELSE -- If productCode exists
    -- Retrieve the product type from current_products
		SELECT product_type INTO p_type from current_products 
		WHERE productCode = v_productCode;
		
		IF(p_type = 'R') THEN
			IF currentDate < (SELECT MIN(startdate) FROM product_pricing WHERE productCode = v_productCode) THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 7002: Selling Price start date is set on a later date!';
			ELSEIF currentDate > (SELECT MAX(enddate) FROM product_pricing WHERE productCode = v_productCode) THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 7003: Selling Price has expired. Update its entry!';
			ELSE
				SELECT pp.MSRP INTO v_MSRP FROM product_pricing pp JOIN product_retail pr ON pp.productCode = pr.productCode
				WHERE pp.productCode = v_productCode;
				RETURN v_MSRP;
            END IF;
		ELSEIF (p_type = 'W') THEN
			SELECT MSRP INTO v_MSRP from product_wholesale
			WHERE productCode = v_productCode;
			RETURN v_MSRP;
		ELSE
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "ERROR 7004: Product Code does not have a product type assigned!";
		END IF; -- End of IF(p_type = 'R')
	END IF; -- End of (temp_productCode is NULL)
    RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getPrice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getPrice`(v_productCode VARCHAR(15), v_mode VARCHAR(10)) RETURNS double
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE curr_productType	CHAR(1);
    DECLARE min_price			DOUBLE;
    DECLARE max_price			DOUBLE;
    
	SELECT product_type INTO curr_productType FROM current_products 
    WHERE productCode = v_productCode;
    
    IF (curr_productType = 'W') THEN
		SELECT (MSRP*2), (MSRP*0.8) INTO max_price, min_price 
        FROM product_wholesale WHERE productCode = v_productCode;
    ELSEIF (curr_productType = 'R') THEN
		SELECT (MSRP*2), (MSRP*0.8) INTO max_price, min_price
        FROM   product_pricing 
        WHERE  productCode = v_productCode
        AND    DATE(NOW()) <= endDate AND DATE(NOW()) >= startDate;
    END IF;
    
    IF (max_price IS NULL) OR (min_price IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "ERROR 01M1: Price of the product cannot be determined";
    END IF;
    
    IF (v_mode='MAX') THEN 
		RETURN max_price;
    ELSE
		RETURN min_price;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getProductType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getProductType`(v_productCode VARCHAR(15)) RETURNS char(1) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE productType	CHAR(1);
	SELECT product_type INTO productType FROM current_products 
    WHERE productCode = v_productCode;
	RETURN productType;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `isDeactivated` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `isDeactivated`(v_employeeNumber INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE isDeactivated BOOLEAN;
	SELECT is_deactivated INTO isDeactivated FROM employees WHERE employeeNumber = v_employeeNumber;
	RETURN isDeactivated;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `isProductDiscontinued` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `isProductDiscontinued`(v_productCode VARCHAR(15)) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE discontinued BOOLEAN;
    DECLARE pcode VARCHAR(15);
    SET discontinued = FALSE;
    IF EXISTS (SELECT 1 FROM `discontinued_products` WHERE `productCode` = v_productCode) THEN
        SET discontinued = TRUE;
    END IF;
    RETURN discontinued;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `isProductLineExist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `isProductLineExist`(v_productLine VARCHAR(50)) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE isExist BOOLEAN DEFAULT FALSE;

    IF EXISTS (SELECT * FROM productlines WHERE productLine = v_productLine) THEN
        SET isExist = TRUE;
    END IF;

    RETURN isExist;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `isWithin_dateRange` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `isWithin_dateRange`(v_employeeNumber INT) RETURNS tinyint
    READS SQL DATA
BEGIN
    DECLARE isWithin TINYINT;
    DECLARE tempStartDate DATE;
    DECLARE tempEndDate DATE;

    -- Retrieve start and end dates
    SELECT MAX(startDate) INTO tempStartDate
    FROM salesRepAssignments
    WHERE employeeNumber = v_employeeNumber;

    SELECT MAX(endDate) INTO tempEndDate
    FROM salesRepAssignments
    WHERE employeeNumber = v_employeeNumber;

    -- Check if the current date is within the range
    IF CURDATE() BETWEEN tempStartDate AND tempEndDate THEN
        SET isWithin = 1;
    ELSE
        SET isWithin = 0;
    END IF;

    RETURN isWithin;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_employee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_employee`(
	IN p_lastName varchar(50), 
	IN p_firstName varchar(50), 
	IN p_extension varchar(10), 
	IN p_email varchar(100), 
	IN p_jobTitle varchar(50), 
    IN p_employee_Type varchar(50),
    IN p_depCode INT,
	IN p_end_username varchar(45),
	IN p_end_userreason varchar(45)
)
BEGIN
	DECLARE employee_type ENUM('S','N');
    DECLARE employeeNumber1 INT;
	
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	
	START TRANSACTION;

		IF p_employee_Type = 'Sales Representatives'  THEN
			SET employee_type := 'S';
		ELSEIF p_employee_Type = 'Inventory Manager' OR p_employee_Type = 'Sales Manager' THEN
			SET employee_type := 'N';
		ELSE
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 80A2: Invalid employee type';
		END IF;
		
	   
		INSERT INTO employees (lastName, firstName, extension, email, jobTitle, employee_type, end_username, end_userreason)
		VALUES (p_lastName, p_firstName, p_extension, p_email, p_jobTitle, employee_type, p_end_username, p_end_userreason);
		
		SELECT MAX(employeeNumber) INTO employeeNumber1 FROM employees;
		IF p_employee_Type = 'Sales Representatives'  THEN
			INSERT INTO salesRepresentatives (employeeNumber) VALUES (employeeNumber1);
		ELSEIF p_employee_Type = 'Inventory Manager' THEN
			INSERT INTO Non_SalesRepresentatives (employeeNumber, deptCode) VALUES (employeeNumber1, p_depCode);
			INSERT INTO inventory_managers (employeeNumber) VALUES (employeeNumber1);
		ELSEIF p_employee_Type = 'Sales Manager' THEN
			INSERT INTO Non_SalesRepresentatives (employeeNumber, deptCode) VALUES (employeeNumber1, p_depCode);
			INSERT INTO sales_managers (employeeNumber) VALUES (employeeNumber1);
		ELSE
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 80A2: Invalid employee type';
		END IF;
        
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_product`(IN v_productCode 	VARCHAR(15), 
								IN v_productName 	VARCHAR(70), 
								IN v_productScale 	VARCHAR(10), 
                                IN v_productVendor 	VARCHAR(50), 
                                IN v_productDescription 	TEXT, 
                                IN v_buyprice 		DOUBLE, 
                                IN v_productType 	ENUM('R', 'W'), 
                                IN v_quantityInStock 	SMALLINT, 
                                IN v_MSRP 			DECIMAL(9,2),
                                IN v_productLine	VARCHAR(50),
                                IN v_end_username 	VARCHAR(45),
                                IN v_end_userreason VARCHAR(45)
                                )
BEGIN
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
			RESIGNAL;
		END;
		
	START TRANSACTION;
		INSERT INTO products VALUES(v_productCode, v_productName, v_productScale, v_productVendor, v_productDescription, v_buyPrice, 'C', v_end_username, v_end_userreason);
		INSERT INTO current_products VALUES(v_productCode, v_productType, v_quantityInStock, v_end_username, v_end_userreason);
		IF (v_productType = 'R') THEN
			INSERT INTO product_retail VALUES(v_productCode, v_end_username, v_end_userreason);
			INSERT INTO product_pricing VALUES(v_productCode, DATE(NOW()), DATE_ADD(NOW(), INTERVAL 7 DAY), v_MSRP, v_end_username, v_end_userreason);
		ELSE
			INSERT INTO product_wholesale VALUES(v_productCode, v_MSRP, v_end_username, v_end_userreason);
		END IF;
		
        IF (NOT isProductLineExist(v_productLine) AND v_productLine != '')	THEN
			INSERT INTO productlines VALUES(v_productLine, NULL, NULL, NULL, v_end_username, "Added from add_products");
		END IF;
        INSERT INTO product_productlines VALUES(v_productCode, v_productLine, v_end_username, v_end_userreason);
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deactivateEmployee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deactivateEmployee`(
	IN p_employeeNumber INT,
	IN p_end_username varchar(45),
	IN p_end_userreason varchar(45)
)
BEGIN
	UPDATE employees SET is_deactivated = 1, end_username = p_end_username, end_userreason = p_end_userreason where employeeNumber = p_employeeNumber;
    
    DELETE FROM inventory_managers WHERE employeeNumber= p_employeeNumber;
	DELETE FROM sales_managers WHERE employeeNumber= p_employeeNumber;
	DELETE FROM Non_SalesRepresentatives WHERE employeeNumber= p_employeeNumber;
    DELETE FROM salesRepresentatives WHERE employeeNumber= p_employeeNumber;
    
    UPDATE salesRepAssignments SET endDate = CURDATE(), end_username = p_end_username, end_userreason = p_end_userreason
	WHERE employeeNumber = p_employeeNumber AND NOW() >= startDate AND NOW() <= endDate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `discontinue_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `discontinue_product`(
	IN p_productCode VARCHAR(15),
    IN p_inventoryManagerId INT,
    IN p_reason VARCHAR(45),
    IN p_end_username VARCHAR(45),
    IN p_end_userreason VARCHAR(45)
)
BEGIN
	DECLARE productExists INT;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
			RESIGNAL;
		END;
		
	START TRANSACTION;
		-- Check if the user is an inventory manager
		IF NOT EXISTS (SELECT 1 FROM inventory_managers WHERE employeeNumber = p_inventoryManagerId) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 20Z1: Only inventory managers can discontinue products.';
		END IF;

		-- Check if the product is in current products
		SELECT COUNT(*) INTO productExists FROM current_products WHERE productCode = p_productCode;
		IF productExists = 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 20Z2: Product not found in current products.';
		END IF;
        
		-- Update product_category to discontinued in products
		UPDATE products SET product_category = 'D' WHERE productCode = p_productCode;

		-- Insert into discontinued_products
		INSERT INTO discontinued_products (productCode, reason, inventory_manager, end_username, end_userreason)
		VALUES (p_productCode, p_reason, p_inventoryManagerId, p_end_username, p_end_userreason);
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `employeeTypeToInventoryManagers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `employeeTypeToInventoryManagers`(
	IN p_employeeNumber INT,
    IN p_deptCode INT
)
BEGIN
	DECLARE v_currentType SMALLINT(1);
   	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
			ROLLBACK;
		RESIGNAL;
	END;
	
	START TRANSACTION;
    
    /*
		1 - sales_representatives
        2 - sales_managers
        3 - inventory_managers
    */
    
    -- Get the current employee type
    SET v_currentType := getEmployeeType(p_employeeNumber);

    -- Ensure the new type is different from the current type
    IF v_currentType = 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 80Z1: New employee type must be different from the current employee type.';
    END IF;

    -- Remove from the current type table
    CASE v_currentType
        WHEN 1 THEN
            DELETE FROM salesRepresentatives WHERE employeeNumber = p_employeeNumber;
            INSERT INTO Non_SalesRepresentatives (employeeNumber, deptCode) VALUES (p_employeeNumber, p_deptCode);
        WHEN 2 THEN
            DELETE FROM sales_managers WHERE employeeNumber = p_employeeNumber;
		WHEN 3 THEN
            DELETE FROM inventory_managers WHERE employeeNumber = p_employeeNumber;
		ELSE
			INSERT INTO Non_SalesRepresentatives (employeeNumber, deptCode) VALUES (p_employeeNumber, p_deptCode);
    END CASE;

    -- Add to the new type table
    INSERT INTO inventory_managers (employeeNumber) VALUES (p_employeeNumber);

    -- Update the employee's type in the employees table
    UPDATE employees SET employee_type = 'N' WHERE employeeNumber = p_employeeNumber;
        
	
	COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `employeeTypeToSalesManager` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `employeeTypeToSalesManager`(
	IN p_employeeNumber INT,
    IN p_deptCode INT
)
BEGIN
	DECLARE v_currentType SMALLINT(1);
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
			ROLLBACK;
		RESIGNAL;
	END;
	
	START TRANSACTION;
    
    /*
		1 - sales_representatives
        2 - sales_managers
        3 - inventory_managers
    */
    
    -- Get the current employee type
    SET v_currentType := getEmployeeType(p_employeeNumber);

    -- Ensure the new type is different from the current type
    IF v_currentType = 2 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 80Z1: New employee type must be different from the current employee type.';
    END IF;

    -- Remove from the current type table
    CASE v_currentType
        WHEN 1 THEN
            DELETE FROM salesRepresentatives WHERE employeeNumber = p_employeeNumber;
            INSERT INTO Non_SalesRepresentatives (employeeNumber, deptCode) VALUES (p_employeeNumber, p_deptCode);
        WHEN 2 THEN
            DELETE FROM sales_managers WHERE employeeNumber = p_employeeNumber;
		WHEN 3 THEN
            DELETE FROM inventory_managers WHERE employeeNumber = p_employeeNumber;
		ELSE
			INSERT INTO Non_SalesRepresentatives (employeeNumber, deptCode) VALUES (p_employeeNumber, p_deptCode);
    END CASE;

    -- Add to the new type table
    INSERT INTO sales_managers (employeeNumber) VALUES (p_employeeNumber);

    -- Update the employee's type in the employees table
    UPDATE employees SET employee_type = 'N' WHERE employeeNumber = p_employeeNumber;
        
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `employeeTypeToSalesRepresentative` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `employeeTypeToSalesRepresentative`(
	IN p_employeeNumber INT
)
BEGIN
	DECLARE v_currentType SMALLINT(1);
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
			ROLLBACK;
		RESIGNAL;
	END;
	
	START TRANSACTION;
    
    /*
		1 - sales_representatives
        2 - sales_managers
        3 - inventory_managers
    */
    
    -- Get the current employee type
    SET v_currentType := getEmployeeType(p_employeeNumber);

    -- Ensure the new type is different from the current type
    IF v_currentType = 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 80Z1: New employee type must be different from the current employee type.';
    END IF;

    -- Remove from the current type table
    CASE v_currentType
        WHEN 1 THEN
            DELETE FROM salesRepresentatives WHERE employeeNumber = p_employeeNumber;
        WHEN 2 THEN
            DELETE FROM sales_managers WHERE employeeNumber = p_employeeNumber;
            DELETE FROM Non_SalesRepresentatives WHERE employeeNumber = p_employeeNumber;
		WHEN 3 THEN
            DELETE FROM inventory_managers WHERE employeeNumber = p_employeeNumber;
            DELETE FROM Non_SalesRepresentatives WHERE employeeNumber = p_employeeNumber;
    END CASE;

    -- Add to the new type table
	INSERT INTO salesRepresentatives (employeeNumber) VALUES (p_employeeNumber);

    -- Update the employee's type in the employees table
    UPDATE employees SET employee_type = 'S' WHERE employeeNumber = p_employeeNumber;
        

	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nested_transactionA` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `nested_transactionA`(IN trxA INT, IN trxB INT)
BEGIN
    DECLARE nestedCall	INT;
    
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		IF (nestedCall=0) THEN
			ROLLBACK;
        END IF;
        RESIGNAL;
    END;
    
    SELECT count(1) INTO nestedCall FROM information_schema.innodb_trx
	WHERE trx_mysql_thread_id = CONNECTION_ID();
    
    IF (nestedCall=0) THEN
		START TRANSACTION;
    END IF;
		INSERT INTO tbl_messages (messages)	VALUES ('First Procedure - First Insert');
		INSERT INTO tbl_messages (messages)	VALUES ('First Procedure - Second Insert');
		CALL nested_transactionB(trxA);
		INSERT INTO tbl_messages (messages)	VALUES ('First Procedure - Third Insert');
		INSERT INTO tbl_messages (messages)	VALUES ('First Procedure - Fourth Insert');
		CALL nested_transactionC(trxB);
		INSERT INTO tbl_messages (messages)	VALUES ('First Procedure - Fifth Insert');
		INSERT INTO tbl_messages (messages)	VALUES ('First Procedure - Sixth Insert');
	
    IF (nestedCall=0) THEN
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nested_transactionB` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `nested_transactionB`(IN test_mode INT)
BEGIN
    DECLARE nestedCall	INT;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		IF (nestedCall=0) THEN
			ROLLBACK;
        END IF;
        RESIGNAL;
    END;
	
    SELECT count(1) INTO nestedCall FROM information_schema.innodb_trx
	WHERE trx_mysql_thread_id = CONNECTION_ID();
    
	IF (nestedCall=0) THEN
		START TRANSACTION;
	END IF;
		INSERT INTO tbl_messages (messages)	VALUES ('2nd Procedure - First Insert');
		INSERT INTO tbl_messages (messages)	VALUES ('2nd Procedure - Second Insert');
        IF (test_mode=1) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Procedure B Fails";
		END IF;
	IF (nestedCall=0) THEN
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nested_transactionC` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `nested_transactionC`(IN test_mode INT)
BEGIN
    DECLARE nestedCall	INT;
    
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
    	IF (nestedCall=0) THEN
			ROLLBACK;
        END IF;
        RESIGNAL;
    END;
	
    SELECT count(1) INTO nestedCall FROM information_schema.innodb_trx
	WHERE trx_mysql_thread_id = CONNECTION_ID();
	
    IF (nestedCall=0) THEN
		START TRANSACTION;
	END IF;
    
		INSERT INTO tbl_messages (messages)	VALUES ('3rd Procedure - First Insert');
		INSERT INTO tbl_messages (messages)	VALUES ('3rd Procedure - Second Insert');
        IF (test_mode=1) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Procedure C Fails";
		END IF;

   	IF (nestedCall=0) THEN
		COMMIT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReassignSalesRep` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ReassignSalesRep`()
BEGIN

DECLARE done INT DEFAULT FALSE;
    DECLARE empNum_var INT;
    DECLARE officeCode_var VARCHAR(10);
    DECLARE initialQuota_var DECIMAL(9,2);
    DECLARE endDate_var DATE;
    DECLARE salesAchieved_var DECIMAL(9,2);
    DECLARE startDate_var DATE;
    DECLARE salesManagerNumber_var INT;

    -- Cursor to iterate through expiring assignments
    DECLARE cur CURSOR FOR
        SELECT employeeNumber, officeCode, quota, endDate, startDate, salesManagerNumber
        FROM salesRepAssignments
        WHERE endDate = CURDATE();

    -- Declare the handler to set done flag when the cursor is exhausted
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN cur;

    -- Loop through all expiring assignments
    read_loop: LOOP
        FETCH cur INTO empNum_var, officeCode_var, initialQuota_var, endDate_var, startDate_var, salesManagerNumber_var;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate the sales achieved during the previous assignment using the function
        SET salesAchieved_var = ComputeRepSale(empNum_var, startDate_var, endDate_var);

        -- Add a new assignment for the sales rep for another week
        INSERT INTO salesRepAssignments (
            employeeNumber, 
            officeCode, 
            startDate, 
            endDate, 
            quota, 
            salesManagerNumber, 
            reason, 
            end_username, 
            end_userreason
        )
        VALUES (
            empNum_var, 
            officeCode_var, 
            CURDATE() + INTERVAL 1 DAY, 
            CURDATE() + INTERVAL 1 WEEK, 
            initialQuota_var - salesAchieved_var,
            salesManagerNumber_var,
            'System Reassignment',
            'System',
            'System generated reassignment.'
        );
    END LOOP;

    -- Close the cursor
    CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReassignSalesRep1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ReassignSalesRep1`()
BEGIN

DECLARE done INT DEFAULT FALSE;
    DECLARE empNum INT;
    DECLARE officeCode VARCHAR(10);
    DECLARE initialQuota DECIMAL(9,2);
    DECLARE endDate DATE;
    DECLARE salesAchieved DECIMAL(9,2);
    DECLARE startDate DATE;
    DECLARE salesManagerNumber INT;

    -- Cursor to iterate through expiring assignments
    DECLARE cur CURSOR FOR
        SELECT employeeNumber, officeCode, quota, endDate, startDate, salesManagerNumber
        FROM salesRepAssignments
        WHERE endDate <= CURDATE();

    -- Declare the handler to set done flag when the cursor is exhausted
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN cur;

    -- Loop through all expiring assignments
    read_loop: LOOP
        FETCH cur INTO empNum, officeCode, initialQuota, endDate, startDate, salesManagerNumber;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate the sales achieved during the previous assignment using the function
        SET salesAchieved = ComputeRepSale(empNum, startDate, endDate);

        -- Add a new assignment for the sales rep for another week
        INSERT INTO salesRepAssignments (
            employeeNumber, 
            officeCode, 
            startDate, 
            endDate, 
            quota, 
            salesManagerNumber, 
            reason, 
            end_username, 
            end_userreason
        )
        VALUES (
            empNum, 
            officeCode, 
            CURDATE() + INTERVAL 1 DAY, 
            CURDATE() + INTERVAL 1 WEEK, 
            initialQuota - salesAchieved,
            salesManagerNumber,
            'System Reassignment',
            'System',
            'System generated reassignment.'
        );
    END LOOP;

    -- Close the cursor
    CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `reintroduce_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `reintroduce_product`(
    IN p_productCode VARCHAR(15),
    IN p_end_username VARCHAR(45),
    IN p_end_userreason VARCHAR(45)
)
BEGIN
    DECLARE productExists INT;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
			RESIGNAL;
		END;
		
	START TRANSACTION;
    
    SELECT COUNT(*) INTO productExists FROM discontinued_products WHERE productCode = p_productCode;
    IF productExists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR 20Z2: Product not found in discontinued products.';
    END IF;

    -- Update product_category to current in products
    UPDATE products SET product_category = 'C' WHERE productCode = p_productCode;

    -- Remove from discontinued_products
    DELETE FROM discontinued_products WHERE productCode = p_productCode;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SalesRepReassignment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SalesRepReassignment`()
BEGIN

	DECLARE done INT DEFAULT FALSE;
    DECLARE empNum_var INT;
    DECLARE officeCode_var VARCHAR(10);
    DECLARE initialQuota_var DECIMAL(9,2);
    DECLARE endDate_var DATE;
    DECLARE salesAchieved DECIMAL(9,2);
    DECLARE startDate_var DATE;
    DECLARE salesManagerNumber_var INT;

    -- Cursor to iterate through expiring assignments
    DECLARE cur CURSOR FOR
        SELECT employeeNumber, officeCode, quota, endDate, startDate, salesManagerNumber
FROM salesRepAssignments s
WHERE endDate = (
    SELECT MAX(endDate)
    FROM salesRepAssignments
    WHERE employeeNumber = s.employeeNumber
) AND endDate = CURDATE();

    -- Declare the handler to set done flag when the cursor is exhausted
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN cur;

    -- Loop through all expiring assignments
    read_loop: LOOP
        FETCH cur INTO empNum_var, officeCode_var, initialQuota_var, endDate_var, startDate_var, salesManagerNumber_var;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate the sales achieved during the previous assignment using the ComputeRepSale function
        SET salesAchieved = ComputeRepSale(empNum_var, startDate_var, endDate_var);

		-- Ensure quota doesn't go negative
        IF initialQuota_var - salesAchieved < 0 THEN
            SET initialQuota_var = 0; -- Set quota to 0 if negative
        ELSE
            SET initialQuota_var = initialQuota_var - salesAchieved; -- Otherwise subtract salesAchieved
        END IF;


	-- Insert the assignment for the sales rep for another week
        INSERT INTO salesRepAssignments (
            employeeNumber, 
            officeCode, 
            quota, 
            startDate, 
            endDate, 
            salesManagerNumber, 
            reason, 
            end_username, 
            end_userreason
        ) VALUES (
            empNum_var, 
            officeCode_var, 
            initialQuota_var, 
            DATE_ADD(CURDATE(), INTERVAL 1 DAY), 
            DATE_ADD(CURDATE(), INTERVAL 1 WEEK), 
            salesManagerNumber_var, 
            'System Reassignment', 
            'System', 
            'System generated reassignment.'
        );

    END LOOP;

    -- Close the cursor
    CLOSE cur;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `customer_credit_data`
--

/*!50001 DROP VIEW IF EXISTS `customer_credit_data`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customer_credit_data` AS select `c`.`customerNumber` AS `customerNumber`,ifnull(sum(ifnull((`od`.`quantityOrdered` * `od`.`priceEach`),0)),0) AS `totalOrders`,ifnull(count(`o`.`orderNumber`),0) AS `orderCount`,ifnull(max(ifnull((`od`.`quantityOrdered` * `od`.`priceEach`),0)),0) AS `maxOrder` from ((`customers` `c` left join `orders` `o` on(((`c`.`customerNumber` = `o`.`customerNumber`) and (`o`.`status` = 'Completed')))) left join `orderdetails` `od` on((`o`.`orderNumber` = `od`.`orderNumber`))) group by `c`.`customerNumber` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `expiring_assignments`
--

/*!50001 DROP VIEW IF EXISTS `expiring_assignments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `expiring_assignments` AS select `expiring_assignments1`.`employeeNumber` AS `employeeNumber`,max(`expiring_assignments1`.`maxEndDate`) AS `maxEndDate` from `expiring_assignments1` group by `expiring_assignments1`.`employeeNumber` having (max(`expiring_assignments1`.`maxEndDate`) <= curdate()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `expiring_assignments1`
--

/*!50001 DROP VIEW IF EXISTS `expiring_assignments1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `expiring_assignments1` AS select `salesrepassignments`.`employeeNumber` AS `employeeNumber`,max(`salesrepassignments`.`endDate`) AS `maxEndDate` from `salesrepassignments` group by `salesrepassignments`.`employeeNumber` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `expiring_assignments_details`
--

/*!50001 DROP VIEW IF EXISTS `expiring_assignments_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `expiring_assignments_details` AS select `s`.`employeeNumber` AS `employeeNumber`,`s`.`officeCode` AS `officeCode`,`s`.`quota` AS `quota`,`s`.`endDate` AS `endDate`,`s`.`startDate` AS `startDate`,`s`.`salesManagerNumber` AS `salesManagerNumber` from (`salesrepassignments` `s` join `expiring_assignments` `e` on(((`s`.`employeeNumber` = `e`.`employeeNumber`) and (`s`.`endDate` = `e`.`maxEndDate`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rptview_discounts`
--

/*!50001 DROP VIEW IF EXISTS `rptview_discounts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rptview_discounts` AS select `pl`.`productLine` AS `productLine`,`p`.`productName` AS `productName`,`oc`.`country` AS `country`,`oc`.`officeCode` AS `officeCode`,`c`.`salesRepEmployeeNumber` AS `salesRepEmployeeNumber`,month(`o`.`orderDate`) AS `Month`,year(`o`.`orderDate`) AS `Year`,round(sum((((case when (`cp`.`product_type` = 'R') then `pp`.`MSRP` when (`cp`.`product_type` = 'W') then `pw`.`MSRP` else 0 end) - `od`.`priceEach`) * `od`.`quantityOrdered`)),2) AS `discounts` from (((((((((`orderdetails` `od` join `products` `p` on((`od`.`productCode` = `p`.`productCode`))) join `current_products` `cp` on((`p`.`productCode` = `cp`.`productCode`))) join `product_wholesale` `pw` on((`cp`.`productCode` = `pw`.`productCode`))) join `product_productlines` `pl` on((`p`.`productCode` = `pl`.`productCode`))) join `orders` `o` on((`o`.`orderNumber` = `od`.`orderNumber`))) join `product_pricing` `pp` on(((`p`.`productCode` = `pp`.`productCode`) and (`o`.`orderDate` between `pp`.`startdate` and `pp`.`enddate`)))) join `customers` `c` on((`o`.`customerNumber` = `c`.`customerNumber`))) join `salesrepassignments` `sra` on(((`c`.`salesRepEmployeeNumber` = `sra`.`employeeNumber`) and (`c`.`officeCode` = `sra`.`officeCode`) and (`c`.`startDate` = `sra`.`startDate`)))) join `offices` `oc` on((`oc`.`officeCode` = `sra`.`officeCode`))) where (((`cp`.`product_type` = 'R') and (`pp`.`MSRP` > `od`.`priceEach`)) or ((`cp`.`product_type` = 'W') and (`pw`.`MSRP` > `od`.`priceEach`))) group by `pl`.`productLine`,`p`.`productName`,`oc`.`country`,`oc`.`officeCode`,`c`.`salesRepEmployeeNumber`,month(`o`.`orderDate`),year(`o`.`orderDate`) order by `pl`.`productLine`,`p`.`productName`,`oc`.`country`,`oc`.`officeCode`,`c`.`salesRepEmployeeNumber`,month(`o`.`orderDate`),year(`o`.`orderDate`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rptview_markup`
--

/*!50001 DROP VIEW IF EXISTS `rptview_markup`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rptview_markup` AS select `pl`.`productLine` AS `productLine`,`p`.`productName` AS `productName`,`oc`.`country` AS `country`,`oc`.`officeCode` AS `officeCode`,`c`.`salesRepEmployeeNumber` AS `salesRepEmployeeNumber`,month(`o`.`orderDate`) AS `month`,year(`o`.`orderDate`) AS `year`,round(sum(((`od`.`priceEach` - `p`.`buyPrice`) * `od`.`quantityOrdered`)),2) AS `total_markup` from ((((((`orderdetails` `od` join `products` `p` on((`od`.`productCode` = `p`.`productCode`))) join `product_productlines` `pl` on((`p`.`productCode` = `pl`.`productCode`))) join `orders` `o` on((`od`.`orderNumber` = `o`.`orderNumber`))) join `customers` `c` on((`o`.`customerNumber` = `c`.`customerNumber`))) join `salesrepassignments` `sra` on(((`c`.`salesRepEmployeeNumber` = `sra`.`employeeNumber`) and (`c`.`officeCode` = `sra`.`officeCode`) and (`c`.`startDate` = `sra`.`startDate`)))) join `offices` `oc` on((`oc`.`officeCode` = `sra`.`officeCode`))) group by `pl`.`productLine`,`p`.`productName`,`oc`.`country`,`oc`.`officeCode`,`c`.`salesRepEmployeeNumber`,month(`o`.`orderDate`),year(`o`.`orderDate`) order by `pl`.`productLine`,`p`.`productName`,`oc`.`country`,`oc`.`officeCode`,`c`.`salesRepEmployeeNumber`,month(`o`.`orderDate`),year(`o`.`orderDate`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rptview_pricingvariation`
--

/*!50001 DROP VIEW IF EXISTS `rptview_pricingvariation`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rptview_pricingvariation` AS select `pp`.`productLine` AS `productLine`,`p`.`productName` AS `product`,month(`pc`.`orderDate`) AS `month`,year(`pc`.`orderDate`) AS `year`,ifnull(round(avg(`pc`.`percentage_change`),2),0) AS `pricingVariation` from (((select `od`.`productCode` AS `productCode`,`o`.`orderDate` AS `orderDate`,(((`od`.`priceEach` - lag(`od`.`priceEach`) OVER (PARTITION BY `od`.`productCode` ORDER BY `o`.`orderDate` ) ) / lag(`od`.`priceEach`) OVER (PARTITION BY `od`.`productCode` ORDER BY `o`.`orderDate` ) ) * 100) AS `percentage_change` from (`orderdetails` `od` left join `orders` `o` on((`od`.`orderNumber` = `o`.`orderNumber`)))) `pc` join `products` `p` on((`pc`.`productCode` = `p`.`productCode`))) join `product_productlines` `pp` on((`p`.`productCode` = `pp`.`productCode`))) group by `pp`.`productLine`,`p`.`productName`,month(`pc`.`orderDate`),year(`pc`.`orderDate`) order by `pp`.`productLine`,`p`.`productName`,`year`,`month` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rptview_quantityordered`
--

/*!50001 DROP VIEW IF EXISTS `rptview_quantityordered`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rptview_quantityordered` AS select `pl`.`productLine` AS `productLine`,`p`.`productName` AS `productName`,`oc`.`country` AS `country`,`oc`.`officeCode` AS `officeCode`,`c`.`salesRepEmployeeNumber` AS `salesRepEmployeeNumber`,month(`o`.`orderDate`) AS `Month`,year(`o`.`orderDate`) AS `Year`,round(sum(`od`.`quantityOrdered`),2) AS `total_quantityOrdered` from ((((((`orderdetails` `od` join `products` `p` on((`od`.`productCode` = `p`.`productCode`))) join `product_productlines` `pl` on((`p`.`productCode` = `pl`.`productCode`))) join `orders` `o` on((`o`.`orderNumber` = `od`.`orderNumber`))) join `customers` `c` on((`o`.`customerNumber` = `c`.`customerNumber`))) join `salesrepassignments` `sra` on(((`c`.`salesRepEmployeeNumber` = `sra`.`employeeNumber`) and (`c`.`officeCode` = `sra`.`officeCode`) and (`c`.`startDate` = `sra`.`startDate`)))) join `offices` `oc` on((`oc`.`officeCode` = `sra`.`officeCode`))) group by `pl`.`productLine`,`p`.`productName`,`oc`.`country`,`oc`.`officeCode`,`c`.`salesRepEmployeeNumber`,month(`o`.`orderDate`),year(`o`.`orderDate`) order by `pl`.`productLine`,`p`.`productName`,`oc`.`country`,`oc`.`officeCode`,`c`.`salesRepEmployeeNumber`,month(`o`.`orderDate`),year(`o`.`orderDate`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rptview_sales`
--

/*!50001 DROP VIEW IF EXISTS `rptview_sales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rptview_sales` AS select `pl`.`productLine` AS `productLine`,`p`.`productName` AS `productName`,`oc`.`country` AS `country`,`oc`.`officeCode` AS `officeCode`,`c`.`salesRepEmployeeNumber` AS `salesRepEmployeeNumber`,month(`o`.`orderDate`) AS `Month`,year(`o`.`orderDate`) AS `Year`,round(sum((`od`.`quantityOrdered` * `od`.`priceEach`)),2) AS `total_sales` from ((((((`orderdetails` `od` join `products` `p` on((`od`.`productCode` = `p`.`productCode`))) join `product_productlines` `pl` on((`p`.`productCode` = `pl`.`productCode`))) join `orders` `o` on((`o`.`orderNumber` = `od`.`orderNumber`))) join `customers` `c` on((`o`.`customerNumber` = `c`.`customerNumber`))) join `salesrepassignments` `sra` on(((`c`.`salesRepEmployeeNumber` = `sra`.`employeeNumber`) and (`c`.`officeCode` = `sra`.`officeCode`) and (`c`.`startDate` = `sra`.`startDate`)))) join `offices` `oc` on((`oc`.`officeCode` = `sra`.`officeCode`))) group by `pl`.`productLine`,`p`.`productName`,`oc`.`country`,`oc`.`officeCode`,`c`.`salesRepEmployeeNumber`,month(`o`.`orderDate`),year(`o`.`orderDate`) order by `pl`.`productLine`,`p`.`productName`,`oc`.`country`,`oc`.`officeCode`,`c`.`salesRepEmployeeNumber`,month(`o`.`orderDate`),year(`o`.`orderDate`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rptview_turnaroundtime`
--

/*!50001 DROP VIEW IF EXISTS `rptview_turnaroundtime`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rptview_turnaroundtime` AS select `c`.`country` AS `country`,`c`.`officeCode` AS `officeCode`,month(`o`.`orderDate`) AS `month`,year(`o`.`orderDate`) AS `year`,avg((to_days(`o`.`shippedDate`) - to_days(`o`.`orderDate`))) AS `avg_TurnaroundTime` from ((select `customers`.`customerNumber` AS `customerNumber`,`customers`.`officeCode` AS `officeCode`,`customers`.`country` AS `country` from `customers`) `c` join (select `orders`.`orderNumber` AS `orderNumber`,`orders`.`customerNumber` AS `customerNumber`,`orders`.`orderDate` AS `orderDate`,`orders`.`shippedDate` AS `shippedDate`,`orders`.`status` AS `status` from `orders` where (`orders`.`status` = 'Completed')) `o`) where (`c`.`customerNumber` = `o`.`customerNumber`) group by `c`.`country`,`c`.`officeCode`,year(`o`.`orderDate`),month(`o`.`orderDate`) order by `c`.`country`,`c`.`officeCode`,year(`o`.`orderDate`),month(`o`.`orderDate`) */;
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

-- Dump completed on 2024-07-21  9:29:50
