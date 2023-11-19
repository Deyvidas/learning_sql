- [EXPORT&IMPORT DB DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-import-and-export-databases-in-mysql-or-mariadb)
- [Экспортировать базу данных](#1)
- [Импортировать базу данных](#2)

---

<h3 id="1" align="center">Экспортировать базу данных</h3>

__Данная команда создаст файлик с идентичной копией указанной БД!__

```bash
mysqldump -u <username> -p <database_name> > /path/to/file/dump.sql
```

<details><summary>dump.sql</summary>

```sql
-- Table structure for table `book`

DROP TABLE IF EXISTS `book`;

CREATE TABLE `book` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `author` varchar(30) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `book`

LOCK TABLES `book` WRITE;

INSERT INTO `book` VALUES (1,'Мастер и Маргарита','Булгаков М.А.',670.99,3),(2,'Белая гвардия','Булгаков М.А.',540.50,5),(3,'Идиот','Достоевский Ф.М.',460.00,10),(4,'Братья Карамазовы','Достоевский Ф.М.',799.01,3),(5,'Игрок','Достоевский Ф.М.',480.50,10),(6,'Стихотворения и поэмы','Есенин С.А.',650.00,15);

UNLOCK TABLES;

-- Table structure for table `supply`

DROP TABLE IF EXISTS `supply`;

CREATE TABLE `supply` (
  `supply_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `author` varchar(30) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  PRIMARY KEY (`supply_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `supply`

LOCK TABLES `supply` WRITE;

INSERT INTO `supply` VALUES (1,'Лирика','Пастернак Б.Л.',518.99,2),(2,'Черный человек','Есенин С.А.',570.20,6),(3,'Белая гвардия','Булгаков М.А.',540.50,7),(4,'Идиот','Достоевский Ф.М.',360.80,3);

UNLOCK TABLES;
```

</details>

<p align="center">~~~</p>

__Данная команда сохранит в файл только данные из таблицы.__

```bash
mysql -u <username> -p <database_name> -e "<sql_query>"> /path/to/file/table_data.csv
```

<details><summary>table_data.csv</summary>

```text
book_id	title	author	price	amount
1	Мастер и Маргарита	Булгаков М.А.	670.99	3
2	Белая гвардия	Булгаков М.А.	540.50	5
3	Идиот	Достоевский Ф.М.	460.00	10
4	Братья Карамазовы	Достоевский Ф.М.	799.01	3
5	Игрок	Достоевский Ф.М.	480.50	10
6	Стихотворения и поэмы	Есенин С.А.	650.00	15
```

</details>

<p align="center">~~~</p>

__Эта команда выполнит sql скрипт из файла.__

```bash
cat sql_script.sql | mysql -u <username> -p <database_name> > /path/to/file/table_data.csv
```

> Результат будет такой-же как и выше но преимущество в том что не нужно писать
запрос в одну строчку.

<details><summary>sql_script.sql</summary>

```sql
  SELECT ...
    FROM ...
   WHERE ...
GROUP BY ...
  HAVING ...
ORDER BY ...
   LIMIT ...;
```

</details>

---

<h3 id="2" align="center">Импортировать базу данных</h3>

__Прежде чем импортировать базу данных нужно создать её.__

```sql
CREATE DATABASE <database_name>;
```

<p align="center">~~~</p>

__Затем выполнить команду которая считает файл сгенерированный mysqldump и
воссоздаст полностью идентичные таблицы с записями (Круто!)__

```bash
mysql -u <username> -p <database_name> < /path/to/file/dump.sql
```