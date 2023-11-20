-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: learning_sql
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `fine`
--

DROP TABLE IF EXISTS `fine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fine` (
  `fine_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `number_plate` varchar(6) DEFAULT NULL,
  `violation` varchar(50) DEFAULT NULL,
  `sum_fine` decimal(8,2) DEFAULT NULL,
  `date_violation` date DEFAULT NULL,
  `date_payment` date DEFAULT NULL,
  PRIMARY KEY (`fine_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fine`
--

LOCK TABLES `fine` WRITE;
/*!40000 ALTER TABLE `fine` DISABLE KEYS */;
INSERT INTO `fine` VALUES (1,'Баранов П.Е.','Р523ВТ','Превышение скорости(от 40 до 60)',500.00,'2020-01-12','2020-01-17'),(2,'Абрамова К.А.','О111АВ','Проезд на запрещающий сигнал',1000.00,'2020-01-14','2020-02-27'),(3,'Яковлев Г.Р.','Т330ТТ','Превышение скорости(от 20 до 40)',500.00,'2020-01-23','2020-02-23'),(4,'Яковлев Г.Р.','М701АА','Превышение скорости(от 20 до 40)',NULL,'2020-01-12',NULL),(5,'Колесов С.П.','К892АХ','Превышение скорости(от 20 до 40)',NULL,'2020-02-01',NULL),(6,'Баранов П.Е.','Р523ВТ','Превышение скорости(от 40 до 60)',NULL,'2020-02-14',NULL),(7,'Абрамова К.А.','О111АВ','Проезд на запрещающий сигнал',NULL,'2020-02-23',NULL),(8,'Яковлев Г.Р.','Т330ТТ','Проезд на запрещающий сигнал',NULL,'2020-03-03',NULL);
/*!40000 ALTER TABLE `fine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `number_plate` varchar(6) DEFAULT NULL,
  `violation` varchar(50) DEFAULT NULL,
  `date_violation` date DEFAULT NULL,
  `date_payment` date DEFAULT NULL,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,'Яковлев Г.Р.','М701АА','Превышение скорости(от 20 до 40)','2020-01-12','2020-01-22'),(2,'Баранов П.Е.','Р523ВТ','Превышение скорости(от 40 до 60)','2020-02-14','2020-03-06'),(3,'Яковлев Г.Р.','Т330ТТ','Проезд на запрещающий сигнал','2020-03-03','2020-03-23');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traffic_violation`
--

DROP TABLE IF EXISTS `traffic_violation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traffic_violation` (
  `violation_id` int NOT NULL AUTO_INCREMENT,
  `violation` varchar(50) DEFAULT NULL,
  `sum_fine` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`violation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traffic_violation`
--

LOCK TABLES `traffic_violation` WRITE;
/*!40000 ALTER TABLE `traffic_violation` DISABLE KEYS */;
INSERT INTO `traffic_violation` VALUES (1,'Превышение скорости(от 20 до 40)',500.00),(2,'Превышение скорости(от 40 до 60)',1000.00),(3,'Проезд на запрещающий сигнал',1000.00);
/*!40000 ALTER TABLE `traffic_violation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-20  7:19:09