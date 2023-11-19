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
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip` (
  `trip_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `city` varchar(25) DEFAULT NULL,
  `per_diem` decimal(8,2) DEFAULT NULL,
  `date_first` date DEFAULT NULL,
  `date_last` date DEFAULT NULL,
  PRIMARY KEY (`trip_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (1,'Баранов П.Е.','Москва',700.00,'2020-01-12','2020-01-17'),(2,'Абрамова К.А.','Владивосток',450.00,'2020-01-14','2020-01-27'),(3,'Семенов И.В.','Москва',700.00,'2020-01-23','2020-01-31'),(4,'Ильиных Г.Р.','Владивосток',450.00,'2020-01-12','2020-02-02'),(5,'Колесов С.П.','Москва',700.00,'2020-02-01','2020-02-06'),(6,'Баранов П.Е.','Москва',700.00,'2020-02-14','2020-02-22'),(7,'Абрамова К.А.','Москва',700.00,'2020-02-23','2020-03-01'),(8,'Лебедев Т.К.','Москва',700.00,'2020-03-03','2020-03-06'),(9,'Колесов С.П.','Новосибирск',450.00,'2020-02-27','2020-03-12'),(10,'Семенов И.В.','Санкт-Петербург',700.00,'2020-03-29','2020-04-05'),(11,'Абрамова К.А.','Москва',700.00,'2020-04-06','2020-04-14'),(12,'Баранов П.Е.','Новосибирск',450.00,'2020-04-18','2020-05-04'),(13,'Лебедев Т.К.','Томск',450.00,'2020-05-20','2020-05-31'),(14,'Семенов И.В.','Санкт-Петербург',700.00,'2020-06-01','2020-06-03'),(15,'Абрамова К.А.','Санкт-Петербург',700.00,'2020-05-28','2020-06-04'),(16,'Федорова А.Ю.','Новосибирск',450.00,'2020-05-25','2020-06-04'),(17,'Колесов С.П.','Новосибирск',450.00,'2020-06-03','2020-06-12'),(18,'Федорова А.Ю.','Томск',450.00,'2020-06-20','2020-06-26'),(19,'Абрамова К.А.','Владивосток',450.00,'2020-07-02','2020-07-13'),(20,'Баранов П.Е.','Воронеж',450.00,'2020-07-19','2020-07-25');
/*!40000 ALTER TABLE `trip` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-19 19:53:09
