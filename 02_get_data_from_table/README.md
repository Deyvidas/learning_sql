<style>
    .hp_button {
        position: fixed;
        bottom: 2%;
        left: 95%;
        font-size: 15px;
        border-color: rgba(85, 85, 85, 0.2);
        background-color: rgb(100,100,100);
        padding: 3px;
        border-radius: 4px;
    }
</style>
<button class="hp_button"><a href="#" style="color: white">Top</a></button>

- [MySQL - Functions and Operators](https://dev.mysql.com/doc/refman/8.0/en/functions.html)
- [Выборка всех записей из таблицы](#выборка-всех-записей-из-таблицы)
- [Алиасы или псевдонимы в названиях столбцов](#алиасы-или-псевдонимы-в-названиях-столбцов)
- [Создание побочного столбца в результате вычислений](#создание-побочного-столбца-в-результате-вычислений)
- [Создание побочного столбца в результате конкатенации столбцов](#создание-побочного-столбца-в-результате-конкатенации-столбцов)
- [Логическое ветвление](#логическое-ветвление)
- [Вложенное логическое ветвление](#вложенное-логическое-ветвление)
- [Выбор уникальных элементов столбца](#выбор-уникальных-элементов-столбца)
- [Использование групповых функции `MIN` `MAX` `AVG` `SUM`](#использование-групповых-функции-min-max-avg-sum)
---
## Выборка всех записей из таблицы
### С отображение только указанных полей:
```sql
-- select all records from specified table and show only specified fields;
SELECT <field1>, <field2>, ...
FROM <tbl_name>;
```
```sql
SELECT book_id, title, amount
FROM book;
```
```text
book_id|title                |amount|
-------+---------------------+------+
      1|Мастер и Маргарита   |     3|
      2|Белая гвардия        |     5|
      3|Идиот                |    10|
      4|Братья Карамазовы    |     2|
      5|Стихотворения и поэмы|    15|
```
### С отображение всех полей:
```sql
-- select all records from specified table and show all fields;
SELECT * FROM <tbl_name>;
```
```sql
SELECT * FROM book;
```
```text
book_id|title                |author          |price |amount|
-------+---------------------+----------------+------+------+
      1|Мастер и Маргарита   |Булгаков М.А.   |670.99|     3|
      2|Белая гвардия        |Булгаков М.А.   |540.50|     5|
      3|Идиот                |Достоевский Ф.М.|460.00|    10|
      4|Братья Карамазовы    |Достоевский Ф.М.|799.01|     2|
      5|Стихотворения и поэмы|Есенин С.А.     |650.00|    15|
```
---
## Алиасы или псевдонимы в названиях столбцов:
```sql
SELECT
    <field1> AS <alias1>,
    <field2> AS <alias2>
FROM
    <tbl_name>
;
```
Если в алиасе необходимы пробелы, то строку необходимо заключить в `''` или `""`:
```sql
SELECT
    <field1> AS '<alias 1 with spaces>',
    <field2> AS '<alias 2 with spaces>'
FROM
    <tbl_name>
;
```
---
## Создание побочного столбца в результате вычислений:
```sql
-- all fields are showed;
SELECT
    *,
    <num_field1> + <num_field2> AS <field_name1>,
    <num_field1> * 0.12 AS <field_name2>
FROM
    <tbl_name>
;
```
```sql
-- with specified fields to show;
SELECT
    <field_1>,
    <field_2>,
    <num_field1> + <num_field2> AS <field_name1>,
    <num_field1> * 0.12 AS <field_name2>
FROM
    <tbl_name>
;
```
```sql
-- show only calculated field;
SELECT
    <num_field1> + <num_field2> AS <field_name1>,
    <num_field1> * 0.12 AS <field_name2>
FROM
    <tbl_name>
;
```
Пример 1:
```sql
SELECT
    *,
    price * amount AS total
FROM
    book
;
```
```text
book_id|title                |author          |price |amount|total  |
-------+---------------------+----------------+------+------+-------+
      1|Мастер и Маргарита   |Булгаков М.А.   |670.99|     3|2012.97|
      2|Белая гвардия        |Булгаков М.А.   |540.50|     5|2702.50|
      3|Идиот                |Достоевский Ф.М.|460.00|    10|4600.00|
      4|Братья Карамазовы    |Достоевский Ф.М.|799.01|     2|1598.02|
      5|Стихотворения и поэмы|Есенин С.А.     |650.00|    15|9750.00|
```
Пример 2:
```sql
SELECT
    title,
    price * amount AS total,
    ROUND(price * 0.22, 2) AS discount
FROM
    book
;
```
```text
title                |total  |discount|
---------------------+-------+--------+
Мастер и Маргарита   |2012.97|  147.62|
Белая гвардия        |2702.50|  118.91|
Идиот                |4600.00|  101.20|
Братья Карамазовы    |1598.02|  175.78|
Стихотворения и поэмы|9750.00|  143.00|
```
Пример 3:
```sql
SELECT
    price * amount AS total
FROM
    book
;
```
```text
total  |
-------+
2012.97|
2702.50|
4600.00|
1598.02|
9750.00|
```
---
## Создание побочного столбца в результате конкатенации столбцов:
```sql
SELECT
    CONCAT(<field_1>, ' (', <field_2>, ') ', <field_3>, '!') AS <field_name>
FROM
    <tbl_name>
;
```
```sql
SELECT
    CONCAT(title, ' (', author, ') price: ', price, ' rub. amount: ', amount) AS info
FROM
    book
;
```
```text
info                                                             |
-----------------------------------------------------------------+
Мастер и Маргарита (Булгаков М.А.) price: 670.99 rub. amount: 3  |
Белая гвардия (Булгаков М.А.) price: 540.50 rub. amount: 5       |
Идиот (Достоевский Ф.М.) price: 460.00 rub. amount: 10           |
Братья Карамазовы (Достоевский Ф.М.) price: 799.01 rub. amount: 2|
Стихотворения и поэмы (Есенин С.А.) price: 650.00 rub. amount: 15|
```
---
## Логическое ветвление:
```sql
SELECT
    *,
    IF(<condition>, <do_if_cond_true>, <do_if_cond_false>) AS <field_name>
FROM
    <tbl_name>
;
```
Аналог на Python:
```python
if <condition>:
    <do_if_cond_true>
else:
    <do_if_cond_false>
```
Пример:
```sql
SELECT
    amount,
    ROUND(IF(amount<4, price*0.5, price*0.7), 2) AS sale,
    IF(amount<4, 'sale 50%', 'sale 30%') AS str_sale
FROM
    book
;
```
```text
amount|sale  |str_sale|
------+------+--------+
     3|335.50|sale 50%|
     5|378.35|sale 30%|
    10|322.00|sale 30%|
     2|399.51|sale 50%|
    15|455.00|sale 30%|
```
---
## Вложенное логическое ветвление:
```sql
SELECT
    *,
    IF(<cond_1>, IF(<cond_2>, <T_2>, <F_2>), IF(<cond_3>, <T_3>, <F_3>)) AS <field_name>
```
Аналог на Python
```python
if <cond_1>:
    if <cond_2>:
        <T_2>
    else:
        <F_2>
else:
    if <cond_3>:
        <T_3>
    else:
        <F_3>
```
Пример1:

Если количество книг меньше 4 – то скидка 50%, меньше 11 – 30%, в остальных
случаях – 10%. И еще укажем какая именно скидка на каждую книгу.
```sql
SELECT
    amount,
    ROUND(IF(amount<4, price*0.5, IF(amount<11, price*0.7, price*0.9)), 2) AS sale,
    IF(amount<4, 'sale 50%', IF(amount<11, 'sale 30%', 'sale 10%')) AS str_sale
FROM
    book
;
```
```text
amount|sale  |str_sale|
------+------+--------+
     3|335.50|sale 50%|
     5|378.35|sale 30%|
    10|322.00|sale 30%|
     2|399.51|sale 50%|
    15|585.00|sale 10%|
```
Пример 2:

При анализе продаж книг выяснилось, что наибольшей популярностью пользуются
книги Михаила Булгакова, на втором месте книги Сергея Есенина. Исходя из
этого решили поднять цену книг Булгакова на 10%, а цену книг Есенина - на 5%.
Написать запрос, куда включить автора, название книги и новую цену, последний
столбец назвать new_price. Значение округлить до двух знаков после запятой.

```sql
SELECT
    author,
    title,
    ROUND(IF(LOWER(author)='булгаков м.а.', price*1.1, IF(LOWER(author)='есенин с.а.', price*1.05, price)), 2) AS new_price
FROM
    book
;
```
```text
author          |title                |price |new_price|
----------------+---------------------+------+---------+
Булгаков М.А.   |Мастер и Маргарита   |670.99|   738.09|
Булгаков М.А.   |Белая гвардия        |540.50|   594.55|
Достоевский Ф.М.|Идиот                |460.00|   460.00|
Достоевский Ф.М.|Братья Карамазовы    |799.01|   799.01|
Есенин С.А.     |Стихотворения и поэмы|650.00|   682.50|
```
---
## Выбор уникальных элементов столбца:
```sql
SELECT DISTINCT <field>
FROM <tbl_name>;
```
Пример 1:

Вывести всех уникальных авторов.
```sql
SELECT DISTINCT author
FROM book;
```
```text
author          |
----------------+
Булгаков М.А.   |
Достоевский Ф.М.|
Есенин С.А.     |
```
---
## Использование групповых функции `MIN` `MAX` `AVG` `SUM`
- `MIN(<field>)` - находит минимальное значение указанного столбца;
- `MAX(<field>)` - находит максимальное значение указанного столбца;
- `AVG(<field>)` - рассчитывает среднее значение указанного столбца;
- `SUM(<field>)` - суммирует все значения указанного столбца;
- <b>В качестве аргумента групповых функций  SQL может использоваться не только
столбец, но и любое допустимое в SQL арифметическое выражение.</b>
```sql
SELECT
    MIN(price) AS min,
    MAX(price) AS max,
    ROUND(AVG(price), 2) AS avg,
    SUM(price) AS sum
FROM
    book
;
```
```text
min   |max   |avg   |sum    |
------+------+------+-------+
460.00|799.01|600.17|3601.00|
```