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
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `author_id` int NOT NULL AUTO_INCREMENT,
  `name_author` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (1,'Булгаков М.А.'),(2,'Достоевский Ф.М.'),(3,'Есенин С.А.'),(4,'Пастернак Б.Л.'),(5,'Лермонтов М.Ю.');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `genre_id` int DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  PRIMARY KEY (`book_id`),
  KEY `author_id` (`author_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`author_id`) ON DELETE CASCADE,
  CONSTRAINT `book_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`genre_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'Мастер и Маргарита',1,1,670.99,3),(2,'Белая гвардия',1,1,540.50,5),(3,'Идиот',2,1,460.00,10),(4,'Братья Карамазовы',2,1,799.01,3),(5,'Игрок',2,1,480.50,10),(6,'Стихотворения и поэмы',3,2,650.00,15),(7,'Черный человек',3,2,570.20,6),(8,'Лирика',4,2,518.99,2);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buy`
--

DROP TABLE IF EXISTS `buy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buy` (
  `buy_id` int NOT NULL AUTO_INCREMENT,
  `buy_description` varchar(100) DEFAULT NULL,
  `client_id` int DEFAULT NULL,
  PRIMARY KEY (`buy_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `buy_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buy`
--

LOCK TABLES `buy` WRITE;
/*!40000 ALTER TABLE `buy` DISABLE KEYS */;
INSERT INTO `buy` VALUES (1,'Доставка только вечером',1),(2,NULL,3),(3,'Упаковать каждую книгу по отдельности',2),(4,NULL,1);
/*!40000 ALTER TABLE `buy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buy_archive`
--

DROP TABLE IF EXISTS `buy_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buy_archive` (
  `buy_archive_id` int NOT NULL AUTO_INCREMENT,
  `buy_id` int DEFAULT NULL,
  `client_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  `date_payment` date DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  PRIMARY KEY (`buy_archive_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buy_archive`
--

LOCK TABLES `buy_archive` WRITE;
/*!40000 ALTER TABLE `buy_archive` DISABLE KEYS */;
INSERT INTO `buy_archive` VALUES (1,2,1,1,'2019-02-21',670.60,2),(2,2,1,3,'2019-02-21',450.90,1),(3,1,2,2,'2019-02-10',520.30,2),(4,1,2,4,'2019-02-10',780.90,3),(5,1,2,3,'2019-02-10',450.90,1),(6,3,4,4,'2019-03-05',780.90,4),(7,3,4,5,'2019-03-05',480.90,2),(8,4,1,6,'2019-03-12',650.00,1),(9,5,2,1,'2019-03-18',670.60,2),(10,5,2,4,'2019-03-18',780.90,1);
/*!40000 ALTER TABLE `buy_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buy_book`
--

DROP TABLE IF EXISTS `buy_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buy_book` (
  `buy_book_id` int NOT NULL AUTO_INCREMENT,
  `buy_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  PRIMARY KEY (`buy_book_id`),
  KEY `buy_id` (`buy_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `buy_book_ibfk_1` FOREIGN KEY (`buy_id`) REFERENCES `buy` (`buy_id`) ON DELETE CASCADE,
  CONSTRAINT `buy_book_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buy_book`
--

LOCK TABLES `buy_book` WRITE;
/*!40000 ALTER TABLE `buy_book` DISABLE KEYS */;
INSERT INTO `buy_book` VALUES (1,1,1,1),(2,1,7,2),(3,1,3,1),(4,2,8,2),(5,3,3,2),(6,3,2,1),(7,3,1,1),(8,4,5,1);
/*!40000 ALTER TABLE `buy_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buy_step`
--

DROP TABLE IF EXISTS `buy_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buy_step` (
  `buy_step_id` int NOT NULL AUTO_INCREMENT,
  `buy_id` int DEFAULT NULL,
  `step_id` int DEFAULT NULL,
  `date_step_beg` date DEFAULT NULL,
  `date_step_end` date DEFAULT NULL,
  PRIMARY KEY (`buy_step_id`),
  KEY `buy_id` (`buy_id`),
  KEY `step_id` (`step_id`),
  CONSTRAINT `buy_step_ibfk_1` FOREIGN KEY (`buy_id`) REFERENCES `buy` (`buy_id`) ON DELETE CASCADE,
  CONSTRAINT `buy_step_ibfk_2` FOREIGN KEY (`step_id`) REFERENCES `step` (`step_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buy_step`
--

LOCK TABLES `buy_step` WRITE;
/*!40000 ALTER TABLE `buy_step` DISABLE KEYS */;
INSERT INTO `buy_step` VALUES (1,1,1,'2020-02-20','2020-02-20'),(2,1,2,'2020-02-20','2020-02-21'),(3,1,3,'2020-02-22','2020-03-07'),(4,1,4,'2020-03-08','2020-03-08'),(5,2,1,'2020-02-28','2020-02-28'),(6,2,2,'2020-02-29','2020-03-01'),(7,2,3,'2020-03-02',NULL),(8,2,4,NULL,NULL),(9,3,1,'2020-03-05','2020-03-05'),(10,3,2,'2020-03-05','2020-03-06'),(11,3,3,'2020-03-06','2020-03-11'),(12,3,4,'2020-03-12',NULL),(13,4,1,'2020-03-20',NULL),(14,4,2,NULL,NULL),(15,4,3,NULL,NULL),(16,4,4,NULL,NULL);
/*!40000 ALTER TABLE `buy_step` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `city_id` int NOT NULL AUTO_INCREMENT,
  `name_city` varchar(50) DEFAULT NULL,
  `days_delivery` int DEFAULT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Москва',5),(2,'Санкт-Петербург',3),(3,'Владивосток',12);
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `client_id` int NOT NULL AUTO_INCREMENT,
  `name_client` varchar(50) DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `client_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'Баранов Павел',3,'baranov@test'),(2,'Абрамова Катя',1,'abramova@test'),(3,'Семенонов Иван',2,'semenov@test'),(4,'Яковлева Галина',1,'yakovleva@test');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `genre_id` int NOT NULL AUTO_INCREMENT,
  `name_genre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (1,'Роман'),(2,'Поэзия'),(3,'Приключения');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `step`
--

DROP TABLE IF EXISTS `step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `step` (
  `step_id` int NOT NULL AUTO_INCREMENT,
  `name_step` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`step_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `step`
--

LOCK TABLES `step` WRITE;
/*!40000 ALTER TABLE `step` DISABLE KEYS */;
INSERT INTO `step` VALUES (1,'Оплата'),(2,'Упаковка'),(3,'Транспортировка'),(4,'Доставка');
/*!40000 ALTER TABLE `step` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-24  5:45:12
