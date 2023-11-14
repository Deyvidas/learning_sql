## Основные команды:
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

-- COLUMNS
SHOW COLUMNS FROM <tbl_name>;                   -- show all columns of specified table;
SHOW COLUMNS FROM <tbl_name> FROM <db_name>;    -- show all columns of specified table in specified database;
```
---
## Создание таблицы:
```sql
-- create table with specified fields with specified type;
CREATE TABLE <tbl_name>(
    <field_name> <type>,
    <field_name> <type>
);
```
Минус данного способа в том, что если таблица с указанным именем уже существует в используемой БД то возникает следующее исключение:
```text
SQL Error [1050] [42S01]: Table '<tbl_name>' already exists
```
Что-бы этого избежать следует добавлять `IF NOT EXISTS` в конструкцию:
```sql
-- create table only if table with this name not exists in used database (more correct way to create table);
CREATE TABLE IF NOT EXISTS <tbl_name>(
    <field_name> <type>,
    <field_name> <type>
);
```
---
## Добавление записей в таблицу:
```sql
INSERT INTO <tbl_name>
    (<field_1>, <field_2>)
VALUES
    (<value_1>, <value_2>),
    (<value_1>, <value_2>),
    (<value_1>, <value_2>)
;
```
1. количество полей и количество значений в списках должны совпадать;
2. должно существовать прямое соответствие между позицией одного и того же элемента в обоих списках;
3. типы данных элементов в списке значений должны быть совместимы с типами данных соответствующих столбцов;
4. новые значения нельзя добавлять в поля, описанные как `PRIMARY KEY AUTO_INCREMENT`;
5. рекомендуется заполнять все поля записи.
---
## Итоговый пример:
```sql
SHOW TABLES;

CREATE TABLE IF NOT EXISTS book(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT
);

SHOW TABLES;
SHOW COLUMNS FROM book;

INSERT INTO book
    (title, author, price, amount)
VALUES
    ('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3)
;

SELECT * FROM book;

INSERT INTO book
    (title, author, price, amount)
VALUES
    ('Белая гвардия', 'Булгаков М.А.', 540.50, 5),
    ('Идиот', 'Достоевский Ф.М.', 460.00, 10),
    ('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2)
;

SELECT * FROM book;
```