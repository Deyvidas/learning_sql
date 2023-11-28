<style>@font-face{font-family:JetBrains; src:url('../00_fonts/JetBrainsMono-Light.ttf');}body{font-family:JetBrains;font-size:15px;}th{background:#1f1f1f;}tr{background:#262626;}.top_button{position:fixed;bottom:1%;left:1%;background-color:#262626;}</style>
<button class="top_button"><a href="#top" style="color: white">^</a></button>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

- [SHOW DATABASES - Просмотр всех БД на сервере MySQL](#1)
- [CREATE DATABASE - Создание новой БД на сервере MySQL](#2)
- [USE - Указать к какой БД подключиться](#3)
- [SELECT DATABASE() - Узнать какая БД используется](#4)
- [DROP DATABASE - Удалить БД](#5)
- [Экспортировать БД в файл](#6)
- [Импортировать БД из файла](#7)

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="1" align="center">SHOW DATABASES - Просмотр всех БД на сервере MySQL</h3>

__Синтаксис:__

```sql
SHOW DATABASES;
```

<details><br><summary><b>Пример</b></summary>

```sql
SHOW DATABASES;
```

|Database|
|--------|
|information_schema|
|learning_sql|
|mysql|
|performance_schema|
|sys|

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="2" align="center">CREATE DATABASE - Создание новой БД на сервере MySQL</h3>

__Синтаксис:__

```sql
CREATE DATABASE database_name;
```

<details><br><summary><b>Пример</b></summary>

```sql
CREATE DATABASE new_database;
```

|Database||
|--------|-|
|information_schema|
|learning_sql|
|mysql|
|new_database|<font color="green"><-</font>|
|performance_schema|
|sys|

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary><b>Анти-пример (создание БД с именем существующей БД)</b></summary>

|Database||
|--------|-|
|information_schema|
|learning_sql|
|mysql|
|new_database|<font color="green"><-</font>|
|performance_schema|
|sys|

```sql
CREATE DATABASE new_database;
```

```text
SQL Error [1007] [HY000]: Can't create database 'new_database'; database exists
```

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="3" align="center">USE - Указать к какой БД подключиться</h3>

__Синтаксис:__

```sql
USE database_name;
```

<details><br><summary><b>Пример</b></summary>

|Database||
|--------|-|
|information_schema|
|learning_sql|
|mysql|
|new_database|<font color="green"><-</font>|
|performance_schema|
|sys|


```sql
USE new_database;
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary><b>Анти-пример (попытка подключиться к несуществующей БД)</b></summary>

|Database|
|--------|
|information_schema|
|learning_sql|
|mysql|
|new_database|
|performance_schema|
|sys|


```sql
USE not_existent_database;
```

```text
SQL Error [1049] [42000]: Unknown database 'not_existent_database'
```

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="4" align="center">SELECT DATABASE() - Узнать какая БД используется</h3>

__Синтаксис:__

```sql
SELECT DATABASE();
```

<details><br><summary><b>Пример (после подключения к серверу БД не выбрана)</b></summary>

```sql
SELECT DATABASE();
```

|DATABASE()|
|----------|
|NULL|

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary><b>Пример (после подключения к БД)</b></summary>

```sql
USE new_database;  -- Подключаемся к БД с именем new_database;

SELECT DATABASE();
```

|DATABASE()|
|----------|
|new_database|

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="5" align="center">DROP DATABASE - Удалить БД</h3>

__Синтаксис:__

```sql
DROP DATABASE [IF EXISTS] database_name;
```

<details><br><summary><b>Пример</b></summary>

|Database||
|--------|-|
|information_schema|
|learning_sql|
|mysql|
|new_database|<font color="red">X</font>|
|performance_schema|
|sys|

```sql
DROP DATABASE IF EXISTS new_database;
```

|Database|
|--------|
|information_schema|
|learning_sql|
|mysql|
|performance_schema|
|sys|

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary><b>Анти-пример (когда пытаемся удалить несуществующую БД)</b></summary>

|Database|
|--------|
|information_schema|
|learning_sql|
|mysql|
|performance_schema|
|sys|

<p align="center">Без использования IF EXISTS</p>

```sql
DROP DATABASE not_existent_database;
```

```text
SQL Error [1008] [HY000]: Can't drop database 'not_existent_database'; database doesn't exist
```

<p align="center">С использованием IF EXISTS</p>

```sql
DROP DATABASE IF EXISTS not_existent_database;
```

> БД не удалилась, так как её не-было на сервере, но и исключения не возникло.

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="6" align="center">Экспортировать БД в файл</h3>

__Синтаксис:__

```bash
mysqldump -u username -p database_name > /path/to/file_name.sql
```

Данная команда создаст бэкап указанной БД и сохранит его в указанный файл.
В бэкапе будет хранится ВСЯ информация обо всех таблицах, а так-же все записи
таблиц.

<details><br><summary><b>Пример бэкап файла</b></summary>

```sql
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
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `author` varchar(30) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'Мастер и Маргарита','Булгаков М.А.',670.99,3),(2,'Белая гвардия','Булгаков М.А.',540.50,5),(3,'Идиот','Достоевский Ф.М.',460.00,10),(4,'Братья Карамазовы','Достоевский Ф.М.',799.01,3),(5,'Игрок','Достоевский Ф.М.',480.50,10),(6,'Стихотворения и поэмы','Есенин С.А.',650.00,15);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supply`
--

DROP TABLE IF EXISTS `supply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supply` (
  `supply_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `author` varchar(30) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  PRIMARY KEY (`supply_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supply`
--

LOCK TABLES `supply` WRITE;
/*!40000 ALTER TABLE `supply` DISABLE KEYS */;
INSERT INTO `supply` VALUES (1,'Лирика','Пастернак Б.Л.',518.99,2),(2,'Черный человек','Есенин С.А.',570.20,6),(3,'Белая гвардия','Булгаков М.А.',540.50,7),(4,'Идиот','Достоевский Ф.М.',360.80,3);
/*!40000 ALTER TABLE `supply` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-19  7:38:38

```

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="7" align="center">Импортировать БД из файла</h3>

__Синтаксис:__

```bash
mysql -u username -p database_name < /path/to/file_name.sql
```

__ВАЖНО!__ Перед тем, как импортировать БД из файла нужно [создать БД](#2)
на сервере или указать существующую.

<details><br><summary><b>Пример</b></summary>

```sql
CREATE DATABASE new_database;

SHOW DATABASES;
```

|Database||
|--------|-|
|information_schema|
|learning_sql|
|mysql|
|new_database|<font color="green"><-</font>|
|performance_schema|
|sys|

```bash
mysql -u user1 -p new_database < /home/user1/dev/database_dump.sql
```

</details>