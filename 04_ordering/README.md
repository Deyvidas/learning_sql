## Выборка данных с сортировкой:
<u>По умолчанию `ORDER BY` выполняет сортировку по возрастанию `ASC`.</u>
```sql
SELECT
    <fields>
FROM
    <tbl_name>
ORDER BY 
    <column1> [ASC|DESC], 
    <column2> [ASC|DESC]
;
```
Пример 1:

Вывести автора, название и количество книг, в отсортированном в алфавитном порядке по автору и по убыванию количества, для тех книг, цены которых меньше 750 рублей.
```sql
SELECT
    author,
    title,
    amount
FROM
    book
WHERE
    price < 750
ORDER BY
    author ASC,
    amount DESC
;
```
```text
author          |title                |amount|
----------------+---------------------+------+
Булгаков М.А.   |Белая гвардия        |     5|
Булгаков М.А.   |Мастер и Маргарита   |     3|
Достоевский Ф.М.|Идиот                |    10|
Есенин С.А.     |Стихотворения и поэмы|    15|
```
---
## Сортировка по алиасам:
```sql
SELECT
    author AS автор,
    title AS название,
    amount AS `кол-во шт.`
FROM
    book
WHERE
    price < 750
ORDER BY
    автор ASC,
    `кол-во шт.` DESC
;
```
```text
автор           |название             |кол-во шт.|
----------------+---------------------+----------+
Булгаков М.А.   |Белая гвардия        |         5|
Булгаков М.А.   |Мастер и Маргарита   |         3|
Достоевский Ф.М.|Идиот                |        10|
Есенин С.А.     |Стихотворения и поэмы|        15|
```
---
## Задание:

Вывести  автора и название  книг, количество которых принадлежит интервалу от 2 до 14 (включая границы). Информацию  отсортировать сначала по авторам (в обратном алфавитном порядке), а затем по названиям книг (по алфавиту).
```sql
SELECT
    author,
    title
FROM
    book
WHERE
    amount BETWEEN 2 AND 14
ORDER BY
    author DESC,
    title ASC
;
```
```text
author          |title             |
----------------+------------------+
Достоевский Ф.М.|Братья Карамазовы |
Достоевский Ф.М.|Идиот             |
Булгаков М.А.   |Белая гвардия     |
Булгаков М.А.   |Мастер и Маргарита|
```