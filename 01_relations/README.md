<style>@font-face{font-family:JetBrains; src:url('../00_fonts/JetBrainsMono-Light.ttf');}body{font-family:JetBrains;font-size:15px;}th{background:#1f1f1f;}tr{background:#262626;}.top_button{position:fixed;bottom:1%;left:1%;background-color:#262626;}</style>
<button class="top_button"><a href="#top" style="color: white">^</a></button>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

- [Основные команды](#1)
- [Создание таблицы](#2)
- [Посмотреть какой инструкцией была создана таблица](#3)
- [Добавление записей в таблицу](#4)
- [ALTER TABLE - MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/alter-table.html)
    - [MySQL ALTER TABLE - tutorial](https://www.mysqltutorial.org/mysql-alter-table.aspx)
    - [(ADD COLUMN) - Добавление столбцов в таблицу](#5)
    - [(MODIFY COLUMN) - Изменить тип и местоположение столбца в таблице](#5.1)
    - [(CHANGE COLUMN) - Переименовать, изменить тип и положение столбца в таблице](#5.2)
    - [(DROP COLUMN) - Удаление столбцов из таблицы](#5.3)
    - [(RENAME TO) - Изменить название таблицы](#5.4)
- [MySQL Variables - tutorial](https://www.mysqltutorial.org/mysql-variables/)
    - [Переменные в MySQL](#6)

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="1" align="center">Основные команды</h3>

```sql
-- DATABASE
SHOW DATABASES;                                 -- show all existent databases;
CREATE DATABASE <db_name>;                      -- create new database;
USE <db_name>;                                  -- select database to use;
SELECT DATABSE();                               -- show name of used database;
DROP DATABASE <db_name>;                        -- delete database;
DROP DATABASE IF EXISTS <db_name>;              -- delete database if exists (more correct way to delete database);

-- TABLES
SHOW TABLES;                                    -- show all tables in used database;
SHOW TABLES FROM <db_name>;                     -- show all tables in specified database;
DROP TABLE <tbl_name>, ...;                     -- delete table;
DROP TABLE IF EXISTS <tbl_name>, ...;           -- delete table if exists (more correct way to delete table);
SHOW CREATE TABLE <tbl_name>;                   -- show statement of how table was created;

-- COLUMNS
DESCRIBE <tbl_name>                             -- show information about all columns in specified table;
SHOW COLUMNS FROM <tbl_name>;                   -- show information about all columns in specified table;
SHOW COLUMNS FROM <tbl_name> FROM <db_name>;    -- show information about all columns in specified table in specified database;
```

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="2" align="center">Создание таблицы</h3>

```sql
-- create table with specified fields with specified type;
CREATE TABLE <tbl_name>(
    <field_name> <type>,
    <field_name> <type>
);
```

Минус данного способа в том, что если таблица с указанным именем уже существует
в используемой БД то возникает следующее исключение:

```text
SQL Error [1050] [42S01]: Table '<tbl_name>' already exists
```

Что-бы этого избежать следует добавлять `IF NOT EXISTS` в конструкцию:

```sql
CREATE TABLE IF NOT EXISTS <tbl_name>(
    <field_name> <type>,
    <field_name> <type>
);
```

<p align="center">~~~</p>

<h3 id="" align="center">Создание таблицы на основе существующей</h3>

```sql
-- Создать таблицу на основе существующей;
CREATE TABLE IF NOT EXISTS <tbl_name>
                    SELECT <field_1>,
                           ...,
                           <field_n>
                     WHERE ...
                  GROUP BY ...
                    HAVING ...
                  ORDER BY ...
                     LIMIT ...;
```

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="3" align="center">Посмотреть какой инструкцией была создана таблица</h3>

```sql
SHOW CREATE TABLE book;
```
```text
Table|Create Table                                                                                                                                                                                                                                                   |
-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
book |CREATE TABLE `book` (¶  `book_id` int NOT NULL AUTO_INCREMENT,¶  `title` varchar(50) DEFAULT NULL,¶  `author` varchar(30) DEFAULT NULL,¶  `price` decimal(8,2) DEFAULT NULL,¶  `amount` int DEFAULT NULL,¶  PRIMARY KEY (`book_id`)¶) ENGINE=InnoDB AUTO_INCREM|
```

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="4" align="center">Добавление записей в таблицу</h3>

```sql
INSERT INTO <tbl_name>(<field_1>, <field_2>)
     VALUES (<value_1>, <value_2>),
            (<value_1>, <value_2>),
            (<value_1>, <value_2>);
```

1. количество полей и количество значений в списках должны совпадать;
2. должно существовать прямое соответствие между позицией одного и того же элемента в обоих списках;
3. типы данных элементов в списке значений должны быть совместимы с типами данных соответствующих столбцов;
4. новые значения нельзя добавлять в поля, описанные как `PRIMARY KEY AUTO_INCREMENT`;
5. рекомендуется заполнять все поля записи.

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="5" align="center">Добавление столбцов в таблицу</h3>

__Синтаксис:__

```sql
ALTER TABLE <tbl_name>
 -- by default new column is places after last column of the table;
 ADD COLUMN <col_name1> <col_definition> [FIRST | AFTER <col_name>],
 ADD COLUMN <col_name2> <col_definition> [FIRST | AFTER <col_name>],
 ...;
```

<p align="center">~~~</p>

__Пример:__

Включить в таблицу applicant_order новый столбец str_id целого типа ,
расположить его перед первым.

```sql
ALTER TABLE applicant_order
 ADD COLUMN str_id INTEGER FIRST;
```

<details><br><summary>Таблица applicant_order до</summary>

|program_id|enrollee_id|itog|
|----------|-----------|----|
|1|3|235|
|1|2|226|
|1|1|219|
|2|6|276|
|2|3|235|
|2|2|226|
|3|6|270|
|3|4|239|
|3|5|200|
|4|6|270|
|4|3|247|
|4|5|200|

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица applicant_order после</summary>

|str_id|program_id|enrollee_id|itog|
|------|----------|-----------|----|
|NULL|1|3|235|
|NULL|1|2|226|
|NULL|1|1|219|
|NULL|2|6|276|
|NULL|2|3|235|
|NULL|2|2|226|
|NULL|3|6|270|
|NULL|3|4|239|
|NULL|3|5|200|
|NULL|4|6|270|
|NULL|4|3|247|
|NULL|4|5|200|

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<p align="center"></p>

<details><br><summary>Поля таблицы applicant_order до</summary>

|Field|Type|Null|Key|Default|Extra|
|-----|----|----|---|-------|-----|
|program_id|int|NO||0||
|enrollee_id|int|NO||0||
|itog|decimal(32,0)|YES||NULL||

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Поля таблицы applicant_order после</summary>

|Field|Type|Null|Key|Default|Extra||
|-----|----|----|---|-------|-----|-|
|str_id|int|YES||NULL||<font color="green"><-</font>|
|program_id|int|NO||0||
|enrollee_id|int|NO||0||
|itog|decimal(32,0)|YES||NULL||

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="5.1" align="center">Изменить тип и местоположение столбца в таблице</h3>

MODIFY COLUMN позволяет:
- изменить тип и настройки существующего столбца;
- изменить местоположение существующего столбца.

__Важно:__ При изменении типа поля, нужно учитывать, что все значения в колонке
можно преобразовать в указанный тип.

<p align="center">~~~</p>

__Синтаксис:__

```sql
  ALTER TABLE <tbl_name>
-- by default modified column does not change position after modification;
MODIFY COLUMN <col_name1> <new_col_definition> [FIRST | AFTER <col_name>],
MODIFY COLUMN <col_name2> <new_col_definition> [FIRST | AFTER <col_name>],
...;
```

<p align="center">~~~</p>

__Пример:__

Для таблицы applicant_order изменить тип поля str_id на VARCHAR(5), сделать
его NOT NULL, изменить значение по умолчанию на 'empty' и переместить поле в
конец таблицы.

```sql
  ALTER TABLE applicant_order
MODIFY COLUMN str_id VARCHAR(5) NOT NULL DEFAULT 'empty' AFTER itog;
```

<details><br><summary>Типы полей таблицы applicant_order до</summary>

|Field|Type|Null|Key|Default|Extra|
|-----|----|----|---|-------|-----|
|str_id|int|YES||NULL||
|program_id|int|NO||0||
|enrollee_id|int|NO||0||
|itog|decimal(32,0)|YES||NULL||

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Типы полей таблицы applicant_order после</summary>

|Field|Type|Null|Key|Default|Extra||
|-----|----|----|---|-------|-----|-|
|program_id|int|NO||0||
|enrollee_id|int|NO||0||
|itog|decimal(32,0)|YES||NULL||
|str_id|varchar(5)|NO||empty||<font color="green"><-</font>|

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="5.2" align="center">Переименовать, изменить тип и положение столбца в таблице</h3>

CHANGE COLUMN позволяет:
- изменить название существующего столбца;
- изменить тип и настройки существующего столбца;
- изменить местоположение существующего столбца.

__Важно:__ При изменении типа поля, нужно учитывать, что все значения в колонке
можно преобразовать в указанный тип.

<p align="center">~~~</p>

__Синтаксис:__

```sql
  ALTER TABLE <tbl_name>
CHANGE COLUMN <old_col_name1> <new_col_name1> <col_definition> [FIRST | AFTER <col_name>],
CHANGE COLUMN <old_col_name2> <new_col_name2> <col_definition> [FIRST | AFTER <col_name>],
...;
```

<p align="center">~~~</p>

__Пример:__

Для таблицы applicant_order изменить тип поля str_id на INTEGER, переименовать
str_id на int_id, сделать поле необязательным для заполнения, изменить значение
по умолчанию на NULL и переместить поле в начало.

```sql
  ALTER TABLE applicant_order
CHANGE COLUMN str_id int_id INTEGER DEFAULT NULL FIRST;
```

<details><br><summary>Поля applicant_order до</summary>

|Field|Type|Null|Key|Default|Extra||
|-----|----|----|---|-------|-----|-|
|program_id|int|NO||0||
|enrollee_id|int|NO||0||
|itog|decimal(32,0)|YES||NULL||
|str_id|varchar(5)|NO||empty||<font color="green"><-</font>|

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Поля applicant_order после</summary>

|Field|Type|Null|Key|Default|Extra||
|-----|----|----|---|-------|-----|-|
|int_id|int|YES||NULL||<font color="green"><-</font>|
|program_id|int|NO||0||
|enrollee_id|int|NO||0||
|itog|decimal(32,0)|YES||NULL||

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="5.3" align="center">Удаление столбцов из таблицы</h3>

__Синтаксис:__

```sql
ALTER TABLE <tbl_name>
DROP COLUMN <column_name1>,
DROP COLUMN <column_name2>,
...;
```

<p align="center">~~~</p>

__Пример:__

Удалить из таблицы applicant_order поля int_id и program_id

```sql
ALTER TABLE applicant_order
DROP COLUMN int_id,
DROP COLUMN program_id;
```

<details><br><summary>Поля applicant_order до</summary>

|Field|Type|Null|Key|Default|Extra||
|-----|----|----|---|-------|-----|-|
|int_id|int|YES||NULL||<font color="red">X</font>|
|program_id|int|NO||0||<font color="red">X</font>|
|enrollee_id|int|NO||0||
|itog|decimal(32,0)|YES||NULL||

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Поля applicant_order после</summary>

|Field|Type|Null|Key|Default|Extra|
|-----|----|----|---|-------|-----|
|enrollee_id|int|NO||0||
|itog|decimal(32,0)|YES||NULL||

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="5.4" align="center">Изменить название таблицы</h3>

__Синтаксис:__

```sql
ALTER TABLE <tbl_name> RENAME TO <new_tbl_name>;
```

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="6" align="center">Переменные в MySQL</h3>

Для присвоения значения переменной используется оператор `:=` так как, в отличие
от `=`, оператор `:=` никогда не интерпретируется как оператор сравнения.

<p align="center">~~~</p>

__Синтаксис:__

```sql
SET @var_name1 := expr [, @var_name2 := expr];
```

```sql
SELECT @var_name1 := <column1>,
       @var_name2 := <column2>
  FROM ...
 WHERE @var_name3 := <expression>
   AND ...;
```

<p align="center">~~~</p>

__Пример:__

Занести в столбец str_id таблицы applicant_order нумерацию абитуриентов, которая
начинается с 1 для каждой образовательной программы.

```sql
SET @program_id := 1, @str_id := 0;

UPDATE applicant_order
   SET str_id = IF(@program_id = program_id,
                   @str_id := @str_id + 1,
                   @str_id := 1 AND @program_id := @program_id + 1);
```

<details><br><summary>Таблица applicant_order до и после</summary>

|str_id|program_id|enrollee_id|itog|<font color="green">-></font>|str_id|program_id|enrollee_id|itog|
|------|----------|-----------|----|-|------|----------|-----------|----|
|NULL|1|3|235|<font color="green">-></font>|1|1|3|235|
|NULL|1|2|226|<font color="green">-></font>|2|1|2|226|
|NULL|1|1|219|<font color="green">-></font>|3|1|1|219|
|NULL|2|6|276|<font color="green">-></font>|1|2|6|276|
|NULL|2|3|235|<font color="green">-></font>|2|2|3|235|
|NULL|2|2|226|<font color="green">-></font>|3|2|2|226|
|NULL|3|6|270|<font color="green">-></font>|1|3|6|270|
|NULL|3|4|239|<font color="green">-></font>|2|3|4|239|
|NULL|3|5|200|<font color="green">-></font>|3|3|5|200|
|NULL|4|6|270|<font color="green">-></font>|1|4|6|270|
|NULL|4|3|247|<font color="green">-></font>|2|4|3|247|
|NULL|4|5|200|<font color="green">-></font>|3|4|5|200|

</details>