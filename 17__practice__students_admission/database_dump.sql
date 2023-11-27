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
-- Table structure for table `achievement`
--

DROP TABLE IF EXISTS `achievement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `achievement` (
  `achievement_id` int NOT NULL AUTO_INCREMENT,
  `name_achievement` varchar(30) DEFAULT NULL,
  `bonus` int DEFAULT NULL,
  PRIMARY KEY (`achievement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `achievement`
--

LOCK TABLES `achievement` WRITE;
/*!40000 ALTER TABLE `achievement` DISABLE KEYS */;
INSERT INTO `achievement` VALUES (1,'Золотая медаль',5),(2,'Серебряная медаль',3),(3,'Золотой значок ГТО',3),(4,'Серебряный значок ГТО',1);
/*!40000 ALTER TABLE `achievement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `name_department` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Инженерная школа'),(2,'Школа естественных наук');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollee`
--

DROP TABLE IF EXISTS `enrollee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollee` (
  `enrollee_id` int NOT NULL AUTO_INCREMENT,
  `name_enrollee` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`enrollee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollee`
--

LOCK TABLES `enrollee` WRITE;
/*!40000 ALTER TABLE `enrollee` DISABLE KEYS */;
INSERT INTO `enrollee` VALUES (1,'Баранов Павел'),(2,'Абрамова Катя'),(3,'Семенов Иван'),(4,'Яковлева Галина'),(5,'Попов Илья'),(6,'Степанова Дарья');
/*!40000 ALTER TABLE `enrollee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollee_achievement`
--

DROP TABLE IF EXISTS `enrollee_achievement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollee_achievement` (
  `enrollee_achiev_id` int NOT NULL AUTO_INCREMENT,
  `enrollee_id` int DEFAULT NULL,
  `achievement_id` int DEFAULT NULL,
  PRIMARY KEY (`enrollee_achiev_id`),
  KEY `enrollee_id` (`enrollee_id`),
  KEY `achievement_id` (`achievement_id`),
  CONSTRAINT `enrollee_achievement_ibfk_1` FOREIGN KEY (`enrollee_id`) REFERENCES `enrollee` (`enrollee_id`) ON DELETE CASCADE,
  CONSTRAINT `enrollee_achievement_ibfk_2` FOREIGN KEY (`achievement_id`) REFERENCES `achievement` (`achievement_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollee_achievement`
--

LOCK TABLES `enrollee_achievement` WRITE;
/*!40000 ALTER TABLE `enrollee_achievement` DISABLE KEYS */;
INSERT INTO `enrollee_achievement` VALUES (1,1,2),(2,1,3),(3,3,1),(4,4,4),(5,5,1),(6,5,3);
/*!40000 ALTER TABLE `enrollee_achievement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollee_subject`
--

DROP TABLE IF EXISTS `enrollee_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollee_subject` (
  `enrollee_subject_id` int NOT NULL AUTO_INCREMENT,
  `enrollee_id` int DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `result` int DEFAULT NULL,
  PRIMARY KEY (`enrollee_subject_id`),
  KEY `enrollee_id` (`enrollee_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `enrollee_subject_ibfk_1` FOREIGN KEY (`enrollee_id`) REFERENCES `enrollee` (`enrollee_id`) ON DELETE CASCADE,
  CONSTRAINT `enrollee_subject_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollee_subject`
--

LOCK TABLES `enrollee_subject` WRITE;
/*!40000 ALTER TABLE `enrollee_subject` DISABLE KEYS */;
INSERT INTO `enrollee_subject` VALUES (1,1,1,68),(2,1,2,70),(3,1,3,41),(4,1,4,75),(5,2,1,75),(6,2,2,70),(7,2,4,81),(8,3,1,85),(9,3,2,67),(10,3,3,90),(11,3,4,78),(12,4,1,82),(13,4,2,86),(14,4,3,70),(15,5,1,65),(16,5,2,67),(17,5,3,60),(18,6,1,90),(19,6,2,92),(20,6,3,88),(21,6,4,94);
/*!40000 ALTER TABLE `enrollee_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program` (
  `program_id` int NOT NULL AUTO_INCREMENT,
  `name_program` varchar(50) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `plan` int DEFAULT NULL,
  PRIMARY KEY (`program_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `program_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
INSERT INTO `program` VALUES (1,'Прикладная математика и информатика',2,2),(2,'Математика и компьютерные науки',2,1),(3,'Прикладная механика',1,2),(4,'Мехатроника и робототехника',1,3);
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_enrollee`
--

DROP TABLE IF EXISTS `program_enrollee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_enrollee` (
  `program_enrollee_id` int NOT NULL AUTO_INCREMENT,
  `program_id` int DEFAULT NULL,
  `enrollee_id` int DEFAULT NULL,
  PRIMARY KEY (`program_enrollee_id`),
  KEY `program_id` (`program_id`),
  KEY `enrollee_id` (`enrollee_id`),
  CONSTRAINT `program_enrollee_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE CASCADE,
  CONSTRAINT `program_enrollee_ibfk_2` FOREIGN KEY (`enrollee_id`) REFERENCES `enrollee` (`enrollee_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_enrollee`
--

LOCK TABLES `program_enrollee` WRITE;
/*!40000 ALTER TABLE `program_enrollee` DISABLE KEYS */;
INSERT INTO `program_enrollee` VALUES (1,3,1),(2,4,1),(3,1,1),(4,2,2),(5,1,2),(6,1,3),(7,2,3),(8,4,3),(9,3,4),(10,3,5),(11,4,5),(12,2,6),(13,3,6),(14,4,6);
/*!40000 ALTER TABLE `program_enrollee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_subject`
--

DROP TABLE IF EXISTS `program_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_subject` (
  `program_subject_id` int NOT NULL AUTO_INCREMENT,
  `program_id` int DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `min_result` int DEFAULT NULL,
  PRIMARY KEY (`program_subject_id`),
  KEY `program_id` (`program_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `program_subject_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE CASCADE,
  CONSTRAINT `program_subject_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_subject`
--

LOCK TABLES `program_subject` WRITE;
/*!40000 ALTER TABLE `program_subject` DISABLE KEYS */;
INSERT INTO `program_subject` VALUES (1,1,1,40),(2,1,2,50),(3,1,4,60),(4,2,1,30),(5,2,2,50),(6,2,4,60),(7,3,1,30),(8,3,2,45),(9,3,3,45),(10,4,1,40),(11,4,2,45),(12,4,3,45);
/*!40000 ALTER TABLE `program_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `subject_id` int NOT NULL AUTO_INCREMENT,
  `name_subject` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES (1,'Русский язык'),(2,'Математика'),(3,'Физика'),(4,'Информатика');
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-26 17:29:46
