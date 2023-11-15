- [MySQL - Comparison Functions and Operators](https://dev.mysql.com/doc/refman/8.0/en/comparison-operators.html)

---
## Фильтрация:
```sql
SELECT *
FROM <tbl_name>
WHERE <condition>
```
```sql
SELECT
    <field_1>,
    <field_2>
FROM <tbl_name>
WHERE <condition>
```
Пример 1:

Вывести название, автора  и стоимость (цена умножить на количество) тех книг, стоимость которых больше 4000 рублей
```sql
SELECT
    title,
    author,
    price
FROM book
WHERE price * amount > 4000;
```
```text
title                |author          |price |
---------------------+----------------+------+
Идиот                |Достоевский Ф.М.|460.00|
Стихотворения и поэмы|Есенин С.А.     |650.00|
```
Пример 2:

Вывести название, цену  тех книг, которые написал Булгаков или Есенин, ценой больше 600 рублей
```sql
SELECT
    title,
    author,
    price
FROM book
WHERE 
    LOWER(author) IN ('булгаков м.а.', 'есенин с.а.')
    AND price > 600
;
```
```text
title                |author       |price |
---------------------+-------------+------+
Мастер и Маргарита   |Булгаков М.А.|670.99|
Стихотворения и поэмы|Есенин С.А.  |650.00|
```
Пример 3:

Вывести название, автора,  цену  и количество всех книг, цена которых меньше 500 или больше 600, а стоимость всех экземпляров этих книг больше или равна 5000.
```sql
SELECT
    title,
    author,
    price,
    amount
FROM book
WHERE
    NOT (price BETWEEN 500 AND 600)
    AND (amount * price) >= 5000
;
```
```text
title                |author     |price |amount|
---------------------+-----------+------+------+
Стихотворения и поэмы|Есенин С.А.|650.00|    15|
```
Пример 4:

Вывести название и авторов тех книг, цены которых принадлежат интервалу от 540.50 до 800 (включая границы),  а количество или 2, или 3, или 5, или 7 .
```sql
SELECT
    title,
    author
FROM book
WHERE
    price BETWEEN 540.5 AND 800
    AND amount IN (2, 3, 5, 7)
;
```
```text
title             |author          |
------------------+----------------+
Мастер и Маргарита|Булгаков М.А.   |
Белая гвардия     |Булгаков М.А.   |
Братья Карамазовы |Достоевский Ф.М.|
```
---
## Как работает `BETWEEN`:
```sql
-- BETWEEN check if value in [a; b] (including border value)
<value> BETWEEN <a> AND <b>
```
```sql
SELECT
    title,
    price
FROM book
WHERE price BETWEEN 460 AND 540.50;
```
```text
title        |price |
-------------+------+
Белая гвардия|540.50|
Идиот        |460.00|
```