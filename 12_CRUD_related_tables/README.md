- [Запросы на обновление, связанных таблиц](#1)
- [Запросы на добавление записей в связанные таблицы](#2)
- [Каскадное удаление записей связанных таблиц](#3)
- [Удаление записей главной таблицы с сохранением записей в зависимой](#4)
- [Удаление записей, использование связанных таблиц](#5)

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="1" align="center">Запросы на обновление, связанных таблиц</h3>

__Синтаксис:__

```sql
  UPDATE <tbl_name1> AS <tbl_al1>
         [INNER|LEFT|RIGHT] JOIN <tbl_name2> AS <tbl_al2>
                              ON <condition1>
                        [AND|OR] <condition2>
     SET <tbl_al1>.<field1> = <value1>,
         <tbl_al2>.<field2> = <value2>
   WHERE <condition3>
[AND|OR] <condition4>
```

<p align="center">~~~</p>

__Пример 1:__

Для книг, которые уже есть на складе (в таблице book) по той же цене и с тем-же
автором, что и в поставке (supply), увеличить количество на значение, указанное
в поставке, а также обнулить количество этих книг в поставке.

<details><br><summary>Таблица author</summary>

```text
author_id|name_author     |
---------+----------------+
        1|Булгаков М.А.   |
        2|Достоевский Ф.М.|
        3|Есенин С.А.     |
        4|Пастернак Б.Л.  |
        5|Лермонтов М.Ю.  |
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book до</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|     5| <- +7
      3|Идиот                |        2|       1|460.00|    10|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|     6| <- +6
      8|Лирика               |        4|       2|518.99|     2|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица supply до</summary>

```text
supply_id|title                |author          |price |amount|
---------+---------------------+----------------+------+------+
        1|Доктор Живаго        |Пастернак Б.Л.  |380.80|     4|
        2|Черный человек       |Есенин С.А.     |570.20|     6| <- -6
        3|Белая гвардия        |Булгаков М.А.   |540.50|     7| <- -7
        4|Идиот                |Достоевский Ф.М.|360.80|     3|
        5|Стихотворения и поэмы|Лермонтов М.Ю.  |255.90|     4|
        6|Остров сокровищ      |Стивенсон Р.Л.  |599.99|     5|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details><br>

```sql
UPDATE book AS b
       INNER JOIN supply AS s
               ON b.title LIKE s.title
              AND b.price = s.price
       INNER JOIN author AS a
               ON b.author_id = a.author_id
              AND s.author LIKE a.name_author
   SET b.amount = b.amount + s.amount,
       s.amount = s.amount - s.amount;
```

<details><br><summary>Таблица book после</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|    12| <-5+7=12
      3|Идиот                |        2|       1|460.00|    10|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|    12| <-6+6=12
      8|Лирика               |        4|       2|518.99|     2|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица supply после</summary>

```text
supply_id|title                |author          |price |amount|
---------+---------------------+----------------+------+------+
        1|Доктор Живаго        |Пастернак Б.Л.  |380.80|     4|
        2|Черный человек       |Есенин С.А.     |570.20|     0| <-6-6=0
        3|Белая гвардия        |Булгаков М.А.   |540.50|     0| <-7-7=0
        4|Идиот                |Достоевский Ф.М.|360.80|     3|
        5|Стихотворения и поэмы|Лермонтов М.Ю.  |255.90|     4|
        6|Остров сокровищ      |Стивенсон Р.Л.  |599.99|     5|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<p align="center">~~~</p>

__Задача 1:__

Для книг, которые уже есть на складе (в таблице book), но по другой цене, чем
в поставке (supply) и с таким-же автором, необходимо в таблице book увеличить
количество на значение, указанное в поставке,  и пересчитать цену. А в таблице
supply обнулить количество этих книг.

<details><br><summary>Таблица author</summary>

```text
author_id|name_author     |
---------+----------------+
        1|Булгаков М.А.   |
        2|Достоевский Ф.М.|
        3|Есенин С.А.     |
        4|Пастернак Б.Л.  |
        5|Лермонтов М.Ю.  |
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book до</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|     5|
      3|Идиот                |        2|       1|460.00|    10| <- +3, 437.11
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|     6|
      8|Лирика               |        4|       2|518.99|     2|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица supply до</summary>

```text
supply_id|title                |author          |price |amount|
---------+---------------------+----------------+------+------+
        1|Доктор Живаго        |Пастернак Б.Л.  |380.80|     4|
        2|Черный человек       |Есенин С.А.     |570.20|     6|
        3|Белая гвардия        |Булгаков М.А.   |540.50|     7|
        4|Идиот                |Достоевский Ф.М.|360.80|     3| <- -3
        5|Стихотворения и поэмы|Лермонтов М.Ю.  |255.90|     4|
        6|Остров сокровищ      |Стивенсон Р.Л.  |599.99|     5|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details><br>

```sql
UPDATE book AS b
       INNER JOIN supply AS s
               ON b.title = s.title
              AND b.price != s.price
       INNER JOIN author AS a
               ON b.author_id = a.author_id
              AND s.author LIKE a.name_author
   SET b.price = ROUND((b.price * b.amount + s.price * s.amount) / (b.amount + s.amount), 2),
       b.amount = b.amount + s.amount,
       s.amount = s.amount - s.amount;
```

<details><br><summary>Таблица book после</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|     5|
      3|Идиот                |        2|       1|437.11|    13| <- 10+3=13, 437.11
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|     6|
      8|Лирика               |        4|       2|518.99|     2|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица supply после</summary>

```text
supply_id|title                |author          |price |amount|
---------+---------------------+----------------+------+------+
        1|Доктор Живаго        |Пастернак Б.Л.  |380.80|     4|
        2|Черный человек       |Есенин С.А.     |570.20|     6|
        3|Белая гвардия        |Булгаков М.А.   |540.50|     7|
        4|Идиот                |Достоевский Ф.М.|360.80|     0| <- 3-3=0
        5|Стихотворения и поэмы|Лермонтов М.Ю.  |255.90|     4|
        6|Остров сокровищ      |Стивенсон Р.Л.  |599.99|     5|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<p align="center">~~~</p>

__Задача 2 :__ [(После этой задачи)](#2.1)

Для книг:
- «Доктор Живаго» Пастернака добавить жанр «Роман»;
- «Стихотворения и поэмы» Лермонтова добавить жанр «Поэзия»;
- «Остров сокровищ» Стивенсона добавить жанр «Приключения».
(Использовать два запроса).

<details><br><summary>Таблица genre</summary>

```text
genre_id|name_genre |
--------+-----------+
       1|Роман      |
       2|Поэзия     |
       3|Приключения|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book до</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|    12|
      3|Идиот                |        2|       1|437.11|    13|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|    12|
      8|Лирика               |        4|       2|518.99|     2|
      9|Доктор Живаго        |        4|        |380.80|     4| <-
     10|Стихотворения и поэмы|        5|        |255.90|     4| <-
     11|Остров сокровищ      |        6|        |599.99|     5| <-
```

<hr style="margin-left: 25%; margin-right: 25%;"></details><br>

```sql
UPDATE book
   SET genre_id = IF(title LIKE 'доктор живаго', 1,
                  IF(title LIKE 'стихотворения и поэмы', 2,
                  IF(title LIKE 'остров сокровищ', 3, NULL)))
 WHERE ISNULL(genre_id);
```

<details><br><summary>Таблица book после</summary>

```text
book_id|title                |author_id|genre_id|price |amount|name_genre |
-------+---------------------+---------+--------+------+------+-----------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|Роман      |
      2|Белая гвардия        |        1|       1|540.50|    12|Роман      |
      3|Идиот                |        2|       1|437.11|    13|Роман      |
      4|Братья Карамазовы    |        2|       1|799.01|     3|Роман      |
      5|Игрок                |        2|       1|480.50|    10|Роман      |
      6|Стихотворения и поэмы|        3|       2|650.00|    15|Поэзия     |
      7|Черный человек       |        3|       2|570.20|    12|Поэзия     |
      8|Лирика               |        4|       2|518.99|     2|Поэзия     |
      9|Доктор Живаго        |        4|       1|380.80|     4|Роман      | <-
     10|Стихотворения и поэмы|        5|       2|255.90|     4|Поэзия     | <-
     11|Остров сокровищ      |        6|       3|599.99|     5|Приключения| <-
```

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="2" align="center">Запросы на добавление записей в связанные таблицы</h3>

__Синтаксис:__

Базовый синтаксис вставки записей, можно посмотреть [здесь](https://github.com/Deyvidas/learning_sql/blob/master/07_CRUD_queries/README.md#2)

```sql
INSERT INTO <tbl_name1>(<field1>, ..., <fieldn>)
      SELECT <tbl2_al>.<field1>,
             ...,
             <tbl3_al>.<fieldn>
        FROM <tbl_name2> AS <tbl2_al>
             [INNER|LEFT|RIGHT] JOIN <tbl_name3> AS <tbl3_al>
                                  ON <condition1>
                            [AND|OR] <condition2>
       WHERE ...
    GROUP BY ...
      HAVING ...
    ORDER BY ...
       LIMIT ...;
```

<p align="center">~~~</p>

__Пример 1:__

В таблице supply есть новые книги, которых на складе еще не было. Прежде чем
добавлять их в таблицу book, необходимо из таблицы supply отобрать новых
авторов и добавить их в таблицу author, если таковые имеются.

<details><br><summary>Таблица supply</summary>

```text
supply_id|title                |author          |price |amount|
---------+---------------------+----------------+------+------+
        1|Доктор Живаго        |Пастернак Б.Л.  |380.80|     4|
        2|Черный человек       |Есенин С.А.     |570.20|     6|
        3|Белая гвардия        |Булгаков М.А.   |540.50|     7|
        4|Идиот                |Достоевский Ф.М.|360.80|     3|
        5|Стихотворения и поэмы|Лермонтов М.Ю.  |255.90|     4|
        6|Остров сокровищ      |Стивенсон Р.Л.  |599.99|     5| <-
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица author до</summary>

```text
author_id|name_author     |
---------+----------------+
        1|Булгаков М.А.   |
        2|Достоевский Ф.М.|
        3|Есенин С.А.     |
        4|Пастернак Б.Л.  |
        5|Лермонтов М.Ю.  |
```

<hr style="margin-left: 25%; margin-right: 25%;"></details><br>

```sql
INSERT INTO author(name_author)
     SELECT s.author
       FROM author AS a
            RIGHT JOIN supply AS s
                    ON a.name_author = s.author
      WHERE ISNULL(a.name_author);
```

<details><br><summary>Под-запрос</summary>

```sql
SELECT a.name_author,
       s.author
  FROM author AS a
       RIGHT JOIN supply AS s
               ON a.name_author = s.author;
```
```text
name_author     |author          |
----------------+----------------+
Пастернак Б.Л.  |Пастернак Б.Л.  |
Есенин С.А.     |Есенин С.А.     |
Булгаков М.А.   |Булгаков М.А.   |
Достоевский Ф.М.|Достоевский Ф.М.|
Лермонтов М.Ю.  |Лермонтов М.Ю.  |
                |Стивенсон Р.Л.  | <-
```

<p align="center">~~~</p>

```sql
SELECT s.author
  FROM author AS a
       RIGHT JOIN supply AS s
               ON a.name_author = s.author
 WHERE ISNULL(a.name_author);
```
```text
author        |
--------------+
Стивенсон Р.Л.|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица author после</summary>

```text
author_id|name_author     |
---------+----------------+
        1|Булгаков М.А.   |
        2|Достоевский Ф.М.|
        3|Есенин С.А.     |
        4|Пастернак Б.Л.  |
        5|Лермонтов М.Ю.  |
        6|Стивенсон Р.Л.  | <-
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<p id="2.1" align="center">~~~</p>

__Пример 2:__

В book добавить новые записи о книгах, которые есть в таблице supply и нет в
таблице book (учитывая автора). (В таблицах supply и book сохранены изменения
предыдущих шагов). Поскольку в таблице supply не указан жанр книги, оставить
его пока пустым (занести значение NULL).

<details><br><summary>Таблица author</summary>

```text
author_id|name_author     |
---------+----------------+
        1|Булгаков М.А.   |
        2|Достоевский Ф.М.|
        3|Есенин С.А.     |
        4|Пастернак Б.Л.  |
        5|Лермонтов М.Ю.  |
        6|Стивенсон Р.Л.  |
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица supply</summary>

```text
supply_id|title                |author          |price |amount|
---------+---------------------+----------------+------+------+
        1|Доктор Живаго        |Пастернак Б.Л.  |380.80|     4| <-
        2|Черный человек       |Есенин С.А.     |570.20|     0|
        3|Белая гвардия        |Булгаков М.А.   |540.50|     0|
        4|Идиот                |Достоевский Ф.М.|360.80|     0|
        5|Стихотворения и поэмы|Лермонтов М.Ю.  |255.90|     4| <-
        6|Остров сокровищ      |Стивенсон Р.Л.  |599.99|     5| <-
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book до</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|    12|
      3|Идиот                |        2|       1|437.11|    13|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|    12|
      8|Лирика               |        4|       2|518.99|     2|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details><br>

```sql
INSERT INTO book(title, author_id, genre_id, price, amount)
     SELECT s.title,
            (SELECT author_id
               FROM author
              WHERE name_author = s.author) AS author_id,
            b.genre_id,
            s.price,
            s.amount
       FROM book AS b
            INNER JOIN author AS a USING(author_id)
            RIGHT JOIN supply AS s
                    ON b.title = s.title
                   AND a.name_author = s.author
      WHERE ISNULL(b.book_id);
```

<details><br><summary>Под-запрос</summary>

Найти те книги в supply которых нет в book

```sql
SELECT s.title,
       s.author,
       (SELECT author_id
          FROM author
         WHERE name_author = s.author) AS author_id,
       b.genre_id,
       s.price,
       s.amount
  FROM book AS b
       INNER JOIN author AS a USING(author_id)
       RIGHT JOIN supply AS s
               ON b.title = s.title
              AND a.name_author = s.author
 WHERE ISNULL(b.book_id);
```
```text
title                |author        |author_id|genre_id|price |amount|
---------------------+--------------+---------+--------+------+------+
Доктор Живаго        |Пастернак Б.Л.|        4|        |380.80|     4|
Стихотворения и поэмы|Лермонтов М.Ю.|        5|        |255.90|     4|
Остров сокровищ      |Стивенсон Р.Л.|        6|        |599.99|     5|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book после</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|    12|
      3|Идиот                |        2|       1|437.11|    13|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|    12|
      8|Лирика               |        4|       2|518.99|     2|
      9|Доктор Живаго        |        4|        |380.80|     4| <-
     10|Стихотворения и поэмы|        5|        |255.90|     4| <-
     11|Остров сокровищ      |        6|        |599.99|     5| <-
```

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="3" align="center">Каскадное удаление записей связанных таблиц</h3>

Базовый синтаксис удаления, можно посмотреть. [здесь](https://github.com/Deyvidas/learning_sql/blob/master/07_CRUD_queries/README.md#7)

__Пример:__

Удалим из таблицы author всех авторов, фамилия которых начинается на «Д», а из
таблицы book - все книги этих авторов.

<details><br><summary>Таблица author до</summary>

```text
author_id|name_author     |
---------+----------------+
        1|Булгаков М.А.   |
        2|Достоевский Ф.М.| <-X
        3|Есенин С.А.     |
        4|Пастернак Б.Л.  |
        5|Лермонтов М.Ю.  |
        6|Стивенсон Р.Л.  |
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book до</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|    12|
      3|Идиот                |        2|       1|437.11|    13| <-X
      4|Братья Карамазовы    |        2|       1|799.01|     3| <-X
      5|Игрок                |        2|       1|480.50|    10| <-X
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|    12|
      8|Лирика               |        4|       2|518.99|     2|
      9|Доктор Живаго        |        4|       1|380.80|     4|
     10|Стихотворения и поэмы|        5|       2|255.90|     4|
     11|Остров сокровищ      |        6|       3|599.99|     5|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details><br>

```sql
DELETE FROM author
      WHERE name_author LIKE 'д%';
```

<details><br><summary>Таблица author после</summary>

```text
author_id|name_author   |
---------+--------------+
        1|Булгаков М.А. |
        3|Есенин С.А.   |
        4|Пастернак Б.Л.|
        5|Лермонтов М.Ю.|
        6|Стивенсон Р.Л.|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book после</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|    12|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|    12|
      8|Лирика               |        4|       2|518.99|     2|
      9|Доктор Живаго        |        4|       1|380.80|     4|
     10|Стихотворения и поэмы|        5|       2|255.90|     4|
     11|Остров сокровищ      |        6|       3|599.99|     5|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details><br>

Как видно после удаления автора из таблицы author так-же удалились и все
ссылающиеся на этого автора записи, все из-за того, что в таблице book ON
DELETE CASCADE.

```sql
CREATE TABLE book(
    ...
    author_id int NOT NULL,
    ...
    FOREIGN KEY (author_id) REFERENCES author (author_id) ON DELETE CASCADE, <-!!!
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE SET NULL
);
```

<p align="center">~~~</p>

__Задание:__

Удалить всех авторов и все их книги, общее количество книг которых меньше 20.

<details><br><summary>Таблица author до</summary>

```text
author_id|name_author     |
---------+----------------+
        1|Булгаков М.А.   | <-X
        2|Достоевский Ф.М.|
        3|Есенин С.А.     |
        4|Пастернак Б.Л.  | <-X
        5|Лермонтов М.Ю.  | <-X
        6|Стивенсон Р.Л.  | <-X
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book до</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3| <-X
      2|Белая гвардия        |        1|       1|540.50|    12| <-X
      3|Идиот                |        2|       1|437.11|    13|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|    12|
      8|Лирика               |        4|       2|518.99|     2| <-X
      9|Доктор Живаго        |        4|       1|380.80|     4| <-X
     10|Стихотворения и поэмы|        5|       2|255.90|     4| <-X
     11|Остров сокровищ      |        6|       3|599.99|     5| <-X
```

<hr style="margin-left: 25%; margin-right: 25%;"></details><br>

```sql
DELETE FROM author
      WHERE author_id IN (  SELECT author_id
                              FROM book
                          GROUP BY author_id
                            HAVING SUM(amount) < 20);
```

<details><br><summary>Под-запрос</summary>

```sql
  SELECT author_id
    FROM book
GROUP BY author_id
  HAVING SUM(amount) < 20;
```
```text
author_id|
---------+
        1|
        4|
        5|
        6|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица author после</summary>

```text
author_id|name_author     |
---------+----------------+
        2|Достоевский Ф.М.|
        3|Есенин С.А.     |
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book после</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      3|Идиот                |        2|       1|437.11|    13|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|    12|
```

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="4" align="center">Удаление записей главной таблицы с сохранением записей в зависимой</h3>

Базовый синтаксис удаления, можно посмотреть. [здесь](https://github.com/Deyvidas/learning_sql/blob/master/07_CRUD_queries/README.md#7)

__Пример:__

Удалим из таблицы genre все жанры, название которых заканчиваются на «я», а в
таблице book - для этих жанров установим значение NULL.

<details><br><summary>Таблица genre до</summary>

```text
genre_id|name_genre |
--------+-----------+
       1|Роман      |
       2|Поэзия     | <-X
       3|Приключения| <-X
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book до</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|    12|
      3|Идиот                |        2|       1|437.11|    13|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15| <-X
      7|Черный человек       |        3|       2|570.20|    12| <-X
      8|Лирика               |        4|       2|518.99|     2| <-X
      9|Доктор Живаго        |        4|       1|380.80|     4|
     10|Стихотворения и поэмы|        5|       2|255.90|     4| <-X
     11|Остров сокровищ      |        6|       3|599.99|     5| <-X
```

<hr style="margin-left: 25%; margin-right: 25%;"></details><br>

```sql
DELETE FROM genre
      WHERE name_genre LIKE '%я';
```

<details><br><summary>Таблица genre после</summary>

```text
genre_id|name_genre|
--------+----------+
       1|Роман     |
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book после</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|    12|
      3|Идиот                |        2|       1|437.11|    13|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|        |650.00|    15| <-NULL
      7|Черный человек       |        3|        |570.20|    12| <-NULL
      8|Лирика               |        4|        |518.99|     2| <-NULL
      9|Доктор Живаго        |        4|       1|380.80|     4|
     10|Стихотворения и поэмы|        5|        |255.90|     4| <-NULL
     11|Остров сокровищ      |        6|        |599.99|     5| <-NULL
```

<hr style="margin-left: 25%; margin-right: 25%;"></details><br>

Как видно после удаления жанра из таблицы genre в таблице book все значения
genre_id которые ссылались на удаленные жанры заменены на NULL, все из-за того,
что в таблице book ON DELETE SET NULL.

```sql
CREATE TABLE book(
    ...
    author_id int NOT NULL,
    ...
    FOREIGN KEY (author_id) REFERENCES author (author_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE SET NULL <-!!!
);
```

<p align="center">~~~</p>

__Задание:__

Удалить все жанры, к которым относится меньше 4-х наименований книг. В таблице
book для этих жанров установить значение NULL.

<details><br><summary>Таблица genre до</summary>

```text
genre_id|name_genre |
--------+-----------+
       1|Роман      |
       2|Поэзия     |
       3|Приключения| <-X
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book до</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|    12|
      3|Идиот                |        2|       1|437.11|    13|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|    12|
      8|Лирика               |        4|       2|518.99|     2|
      9|Доктор Живаго        |        4|       1|380.80|     4|
     10|Стихотворения и поэмы|        5|       2|255.90|     4|
     11|Остров сокровищ      |        6|       3|599.99|     5| <-X
```

<hr style="margin-left: 25%; margin-right: 25%;"></details><br>

```sql
DELETE FROM genre
      WHERE genre_id IN (  SELECT genre_id
                             FROM book
                         GROUP BY genre_id
                           HAVING COUNT(*) < 4);
```

<details><br><summary>Под-запрос</summary>

```sql
  SELECT genre_id
    FROM book
GROUP BY genre_id
  HAVING COUNT(*) < 4;
```
```text
genre_id|
--------+
       3|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица genre после</summary>

```text
genre_id|name_genre|
--------+----------+
       1|Роман     |
       2|Поэзия    |
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book после</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|    12|
      3|Идиот                |        2|       1|437.11|    13|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|    12|
      8|Лирика               |        4|       2|518.99|     2|
      9|Доктор Живаго        |        4|       1|380.80|     4|
     10|Стихотворения и поэмы|        5|       2|255.90|     4|
     11|Остров сокровищ      |        6|        |599.99|     5| <-
```

</details>

<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

---

<h3 id="5" align="center">Удаление записей, использование связанных таблиц</h3>

__Синтаксис:__

```sql
DELETE FROM <tab1_al>
      USING <table1> AS <tab1_al>
            INNER JOIN <table2> AS <tab2_al>
                    ON <condition1>
              [AND|OR] <condition2>
      WHERE <condition3>;
```

<p align="center">~~~</p>

__Пример:__

Удалить всех авторов из таблицы author, у которых есть книги, количество
экземпляров которых меньше 3. Из таблицы book удалить все книги этих авторов.

<details><br><summary>Таблица author до</summary>

```text
author_id|name_author     |
---------+----------------+
        1|Булгаков М.А.   |
        2|Достоевский Ф.М.|
        3|Есенин С.А.     |
        4|Пастернак Б.Л.  | <-X
        5|Лермонтов М.Ю.  |
        6|Стивенсон Р.Л.  |
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book до</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|    12|
      3|Идиот                |        2|       1|437.11|    13|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|    12|
      8|Лирика               |        4|       2|518.99|     2| <-X
      9|Доктор Живаго        |        4|       1|380.80|     4| <-X
     10|Стихотворения и поэмы|        5|       2|255.90|     4|
     11|Остров сокровищ      |        6|       3|599.99|     5|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details><br>

```sql
DELETE FROM a
      USING author AS a
            INNER JOIN book AS b
                    ON a.author_id = b.author_id
                   AND b.amount < 3;
```

<details><br><summary>Таблица author после</summary>

```text
author_id|name_author     |
---------+----------------+
        1|Булгаков М.А.   |
        2|Достоевский Ф.М.|
        3|Есенин С.А.     |
        5|Лермонтов М.Ю.  |
        6|Стивенсон Р.Л.  |
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book после</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|    12|
      3|Идиот                |        2|       1|437.11|    13|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15|
      7|Черный человек       |        3|       2|570.20|    12|
     10|Стихотворения и поэмы|        5|       2|255.90|     4|
     11|Остров сокровищ      |        6|       3|599.99|     5|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<p align="center">~~~</p>

__Задание:__

Удалить всех авторов, которые пишут в жанре "Поэзия". Из таблицы book удалить
все книги этих авторов. В запросе для отбора авторов использовать полное
название жанра, а не его id.

<details><br><summary>Таблица genre</summary>

```text
genre_id|name_genre |
--------+-----------+
       1|Роман      |
       2|Поэзия     |
       3|Приключения|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица author до</summary>

```text
author_id|name_author     |
---------+----------------+
        1|Булгаков М.А.   |
        2|Достоевский Ф.М.|
        3|Есенин С.А.     | <-X
        4|Пастернак Б.Л.  | <-X
        5|Лермонтов М.Ю.  | <-X
        6|Стивенсон Р.Л.  |
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book до</summary>

```text
book_id|title                |author_id|genre_id|price |amount|
-------+---------------------+---------+--------+------+------+
      1|Мастер и Маргарита   |        1|       1|670.99|     3|
      2|Белая гвардия        |        1|       1|540.50|    12|
      3|Идиот                |        2|       1|437.11|    13|
      4|Братья Карамазовы    |        2|       1|799.01|     3|
      5|Игрок                |        2|       1|480.50|    10|
      6|Стихотворения и поэмы|        3|       2|650.00|    15| <-X
      7|Черный человек       |        3|       2|570.20|    12| <-X
      8|Лирика               |        4|       2|518.99|     2| <-X
      9|Доктор Живаго        |        4|       1|380.80|     4| <-X
     10|Стихотворения и поэмы|        5|       2|255.90|     4| <-X
     11|Остров сокровищ      |        6|       3|599.99|     5|
```

<hr style="margin-left: 25%; margin-right: 25%;"></details><br>

```sql
DELETE FROM a
      USING author AS a
            INNER JOIN book AS b USING(author_id)
            INNER JOIN genre AS g
                    ON b.genre_id = g.genre_id
                   AND g.name_genre LIKE 'поэзия';
```

<details><br><summary>Таблица author после</summary>

```text
author_id|name_author     |
---------+----------------+
        1|Булгаков М.А.   |
        2|Достоевский Ф.М.|
        6|Стивенсон Р.Л.  |
```

<hr style="margin-left: 25%; margin-right: 25%;"></details>

<details><br><summary>Таблица book после</summary>

```text
book_id|title             |author_id|genre_id|price |amount|
-------+------------------+---------+--------+------+------+
      1|Мастер и Маргарита|        1|       1|670.99|     3|
      2|Белая гвардия     |        1|       1|540.50|    12|
      3|Идиот             |        2|       1|437.11|    13|
      4|Братья Карамазовы |        2|       1|799.01|     3|
      5|Игрок             |        2|       1|480.50|    10|
     11|Остров сокровищ   |        6|       3|599.99|     5|
```

</details>