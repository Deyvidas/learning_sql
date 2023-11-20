- [MySQL Foreign Key - tutorial](https://www.mysqltutorial.org/mysql-foreign-key/)
- [Создание таблицы с внешними ключами](#1)
- [ON DELETE](#2)

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="1" align="center">Создание таблицы с внешними ключами</h3>

- __главная таблица__ - таблица на которую ссылается подчиненная таблица;
- __подчиненная таблица__ - таблица которая ссылается на другую таблицу.

<p align="center">~~~</p>

При создании зависимой таблицы (таблицы, которая содержит внешние ключи)
необходимо учитывать, что:
- для внешних ключей подчиненной таблицы рекомендуется устанавливать
ограничение NOT NULL;
- каждый внешний ключ подчиненной таблицы должен иметь такой же тип данных, как
связанное поле главной таблицы;
- для внешнего ключа, необходимо указать главную таблицу и столбец, по которому
осуществляется связь;
    ```sql
    FOREIGN KEY (<field1>) REFERENCES <to_table1>(<to_field>)
        [ON DELETE CASCADE|SET NULL|SET DEFAULT|RESTRICT],
    FOREIGN KEY (<field2>) REFERENCES <to_table2>(<to_field>)
        [ON DELETE CASCADE|SET NULL|SET DEFAULT|RESTRICT]
    ```

<p align="center">~~~</p>

<p align="center"><b>Создание таблицы author (главной таблицы)</b></p>

```sql
CREATE TABLE IF NOT EXISTS author(
      author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
);
```

<p align="center"><b>Создание таблицы genre (главной таблицы)</b></p>

```sql
CREATE TABLE IF NOT EXISTS genre(
      genre_id INT PRIMARY KEY AUTO_INCREMENT,
    name_genre VARCHAR(30)
);
```

<p align="center"><b>Создание таблицы book (подчиненной таблицы)</b></p>

```sql
CREATE TABLE IF NOT EXISTS book(
      book_id INT PRIMARY KEY AUTO_INCREMENT,
        title VARCHAR(50),
    author_id INT NOT NULL,
     genre_id INT,
        price DECIMAL(8, 2),
       amount INT,
    FOREIGN KEY (author_id) REFERENCES author (author_id),
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id)
);
```

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="2" align="center">Действия при удалении записи из главной таблицы</h3>

С помощью выражения ON DELETE можно установить действия, которые выполняются
для записей подчиненной таблицы при удалении связанной строки из главной
таблицы. При удалении можно установить следующие опции:

- __CASCADE__ - автоматически удаляет строки из подчиненной таблицы при
  удалении связанных строк в главной таблице.
- __SET NULL__ - при удалении  связанной строки из главной таблицы
  устанавливает для столбца внешнего ключа значение NULL. (В этом случае
  столбец внешнего ключа должен поддерживать установку NULL).
- __SET DEFAULT__ - похоже на SET NULL за тем исключением, что значение
  внешнего ключа устанавливается не в NULL, а в значение по умолчанию для
  данного столбца.
- __RESTRICT__ - отклоняет удаление строк в главной таблице при наличии
  связанных строк в подчиненной таблице.

> __Важно!__ Если для столбца установлена опция SET NULL, то при его описании
нельзя задать ограничение на пустое значение.

<p align="center">~~~</p>

__Пример:__

Будем считать, что при удалении автора из таблицы author, необходимо удалить
все записи о книгах из таблицы book, написанные этим автором. Данное действие
необходимо прописать при создании таблицы.

```sql
CREATE TABLE IF NOT EXISTS author(
      author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
);
```
```sql
CREATE TABLE IF NOT EXISTS book(
      book_id INT PRIMARY KEY AUTO_INCREMENT,
        title VARCHAR(50),
    author_id INT NOT NULL,
        price DECIMAL(8,2),
       amount INT,
    FOREIGN KEY (author_id) REFERENCES author (author_id)
        ON DELETE CASCADE
);
```

<p align="center">~~~</p>

__Задание 1:__

Создать таблицу book той же структуры, что и на предыдущем шаге. Будем считать,
что при удалении автора из таблицы author, должны удаляться все записи о книгах
из таблицы book, написанные этим автором. А при удалении жанра из таблицы genre
для соответствующей записи book установить значение Null в столбце genre_id.

<details><br><summary>Главные таблицы author и genre</summary>

```sql
CREATE TABLE IF NOT EXISTS author(
      author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
);
```
```sql
CREATE TABLE IF NOT EXISTS genre(
      genre_id INT PRIMARY KEY AUTO_INCREMENT,
    name_genre VARCHAR(30)
);
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

```sql
CREATE TABLE IF NOT EXISTS book(
      book_id INT PRIMARY KEY AUTO_INCREMENT,
        title VARCHAR(50),
    author_id INT NOT NULL,
     genre_id INT,
        price DECIMAL(8,2),
       amount INT,
    FOREIGN KEY (author_id) REFERENCES author (author_id)
        ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id)
        ON DELETE SET NULL
);
```

<p align="center">~~~</p>

__Задание 2:__

Вставить в таблицу book следующие 3 записи:


```text
+-----------------------+-----------+----------+--------+--------+
| title                 | author_id | genre_id | price  | amount |
+-----------------------+-----------+----------+--------+--------+
| Стихотворения и поэмы | 3         | 2        | 650.00 | 15     |
| Черный человек        | 3         | 2        | 570.20 | 6      |
| Лирика                | 4         | 2        | 518.99 | 2      |
+-----------------------+-----------+----------+--------+--------+
```

<p align="center">~~~</p>

<details><br><summary>Содержание главных таблиц author и genre</summary>

```sql
SELECT * FROM author;
```
```text
author_id|name_author     |
---------+----------------+
        1|Булгаков М.А.   |
        2|Достоевский Ф.М.|
        3|Есенин С.А.     |
        4|Пастернак Б.Л.  |
```

<p align="center">~~~</p>

```sql
SELECT * FROM genre;
```
```text
genre_id|name_genre|
--------+----------+
       1|Роман     |
       2|Поэзия    |
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Содержание подчиненной таблицы book</summary>

```sql
SELECT * FROM book;
```
```text
book_id|title             |author_id|genre_id|price |amount|
-------+------------------+---------+--------+------+------+
      1|Мастер и Маргарита|        1|       1|670.99|     3|
      2|Белая гвардия     |        1|       1|540.50|     5|
      3|Идиот             |        2|       1|460.00|    10|
      4|Братья Карамазовы |        2|       1|799.01|     3|
      5|Игрок             |        2|       1|480.50|    10|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

```sql
INSERT INTO book(title, author_id, genre_id, price, amount)
     VALUES ('Стихотворения и поэмы', 3, 2, 650.00, 15),
            ('Черный человек', 3, 2, 570.20, 6),
            ('Лирика', 4, 2, 518.99, 2);

SELECT * FROM book;
```
```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|     5|
      3|Идиот                |        2|       1|460.00|    10|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15| <-+
      7|Черный человек       |        3|       2|570.20|     6| <-+
      8|Лирика               |        4|       2|518.99|     2| <-+
```
