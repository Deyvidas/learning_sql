- [MySQL tutorial](https://www.mysqltutorial.org/mysql-group-by.aspx)
- [Группировка записей таблицы используя GROUP BY](#1)
- [Как работает COUNT](#2)
- [Использование групповых функции MIN MAX AVG SUM](#3)
- [Группировка данных по условию HAVING](#4)

---

<h3 id="1" align="center">Группировка записей таблицы используя GROUP BY</h3>

- `GROUP BY` - схлопывает все записи с одинаковым значением указанного поля в одну строку.
- `GROUP BY` - это как своего рода `unique` | `unique_together`.

```sql
  SELECT <field_1>      -- fields here must be equal with fields after GROUP BY;
    FROM <tbl_name>
   WHERE <condition_1>
GROUP BY <field_1>;     -- fields here must be equal with fields after SELECT;
```

<p align="center">~~~</p>

Пример 1:

```sql
  SELECT author,
         SUM(amount) AS total_amount,
         COUNT(*) AS count_records
    FROM book
GROUP BY author;
```
```text
author          |total_amount|count_records|
----------------+------------+-------------+
Булгаков М.А.   |           8|            2|
Достоевский Ф.М.|          23|            3|
Есенин С.А.     |          15|            1|
```

<p align="center">~~~</p>

Пример 2:

```sql
  SELECT YEAR(orderDate) AS year,
         status,
         SUM(quantityOrdered * priceEach) AS total
    FROM orders
         INNER JOIN orderdetails USING (orderNumber)
GROUP BY year,
         status
ORDER BY year;
```
```text
+------+------------+------------+
| year | status     | total      |
+------+------------+------------+
| 2003 | Cancelled  |   67130.69 | <-- unique combination of year and status
| 2003 | Resolved   |   27121.90 | <-- unique combination of year and status
| 2003 | Shipped    | 3223095.80 | <-- unique combination of year and status
| 2004 | Cancelled  |  171723.49 | <-- unique combination of year and status
| 2004 | On Hold    |   23014.17 | <-- unique combination of year and status
| 2004 | Resolved   |   20564.86 | <-- unique combination of year and status
| 2004 | Shipped    | 4300602.99 | <-- unique combination of year and status
| 2005 | Disputed   |   61158.78 | <-- unique combination of year and status
| 2005 | In Process |  135271.52 | <-- unique combination of year and status
| 2005 | On Hold    |  146561.44 | <-- unique combination of year and status
| 2005 | Resolved   |   86549.12 | <-- unique combination of year and status
| 2005 | Shipped    | 1341395.85 | <-- unique combination of year and status
+------+------------+------------+
```

<p align="center">~~~</p>

Задача:

Посчитать, количество различных книг и количество экземпляров книг каждого
автора , хранящихся на складе.  Столбцы назвать `Автор`, `Различных_книг` и
`Количество_экземпляров` соответственно.

```sql
SELECT author AS Автор,
       COUNT(title) AS Различных_книг,
       SUM(amount) AS Количество_экземпляров
FROM book
GROUP BY Автор;
```
```text
Автор           |Различных_книг|Количество_экземпляров|
----------------+--------------+----------------------+
Булгаков М.А.   |             2|                     8|
Достоевский Ф.М.|             3|                    23|
Есенин С.А.     |             1|                    15|
```

---

<h3 id="2" align="center">Как работает COUNT</h3>

- `COUNT(*)` — подсчитывает кол-во занятых строк каждой группой;
- `COUNT(<field>)` — подсчитывает кол-во `NOT NULL` значений в столбце `<field>`
для каждой группы;

```sql
CREATE TABLE with_null(
            id INT PRIMARY KEY AUTO_INCREMENT,
          name VARCHAR(30),
           age INT,
    profession VARCHAR(30));

INSERT INTO with_null(name, age, profession)
     VALUES ('name1', 1, NULL),
            ('name2', 2, 'programmer'),
            ('name3', 3, 'driver'),
            ('name4', 1, NULL),
            ('name5', 2, 'programmer'),
            ('name6', 3, 'driver');
```
```sql
SELECT * FROM with_null;
```
```text
id|name |age|profession|
--+-----+---+----------+
 1|name1|  1|          |
 2|name2|  2|programmer|
 3|name3|  3|driver    |
 4|name4|  1|          |
 5|name5|  2|programmer|
 6|name6|  3|driver    |
```

<p align="center">~~~</p>

Пример:

```sql
  SELECT age,
         COUNT(profession),
         COUNT(*)
    FROM with_null
GROUP BY age;
```
```text
age|COUNT(profession)|COUNT(*)|
---+-----------------+--------+
  1|                0|       2| <-- group with age=1 has all profession field values=NULL
  2|                2|       2|
  3|                2|       2|
```

---

<h3 id="3" align="center">Использование групповых функции MIN MAX AVG SUM</h3>

- `MIN(<field>)` - находит минимальное значение указанного столбца для каждой группы;
- `MAX(<field>)` - находит максимальное значение указанного столбца для каждой группы;
- `AVG(<field>)` - рассчитывает среднее значение указанного столбца для каждой группы;
- `SUM(<field>)` - суммирует все значения указанного столбца для каждой группы;
- __В качестве аргумента групповых функций  SQL может использоваться не только
столбец, но и любое допустимое в SQL арифметическое выражение.__

```sql
  SELECT author,
         MIN(price) AS min_price,
         MAX(price) AS max_price,
         ROUND(AVG(price), 2) AS avg_price,
         SUM(price) AS sum_price
    FROM book
GROUP BY author;
```
```text
author          |min_price|max_price|avg_price|sum_price|
----------------+---------+---------+---------+---------+
Булгаков М.А.   |   540.50|   670.99|   605.75|  1211.49|
Достоевский Ф.М.|   460.00|   799.01|   579.84|  1739.51|
Есенин С.А.     |   650.00|   650.00|   650.00|   650.00|
```

<p align="center">~~~</p>

Пример:

Вывести суммарную стоимость книг каждого автора.

```sql
  SELECT author,
         SUM(amount) AS total_books,
         ROUND(AVG(price), 2) AS avg_cost_book,
         SUM(price * amount) AS total_cost
    FROM book
GROUP BY author;
```
```text
author          |total_books|avg_cost_book|total_cost|
----------------+-----------+-------------+----------+
Булгаков М.А.   |          8|       605.75|   4715.47|
Достоевский Ф.М.|         23|       579.84|  11802.03|
Есенин С.А.     |         15|       650.00|   9750.00|
```

<p align="center">~~~</p>

Задание 1:

Вывести фамилию и инициалы автора, минимальную, максимальную и среднюю цену
книг каждого автора . Вычисляемые столбцы назвать `Минимальная_цена`,
`Максимальная_цена` и `Средняя_цена` соответственно.

```sql
  SELECT author,
         MIN(price) AS Минимальная_цена,
         MAX(price) AS Максимальная_цена,
         AVG(price) AS Средняя_цена
    FROM book
GROUP BY author;
```
```text
author          |Минимальная_цена|Максимальная_цена|Средняя_цена|
----------------+----------------+-----------------+------------+
Булгаков М.А.   |          540.50|           670.99|  605.745000|
Достоевский Ф.М.|          460.00|           799.01|  579.836667|
Есенин С.А.     |          650.00|           650.00|  650.000000|
```

<p align="center">~~~</p>

Задание 2:

- Для каждого автора вычислить суммарную стоимость книг `S` (имя столбца `Стоимость`);
- Вычислить налог на добавленную стоимость для полученных сумм (имя столбца `НДС` ),
который включен в стоимость и составляет 18% (k=18);
- Вычислить стоимость книг без налога на добавленную стоимость (`Стоимость_без_НДС`).
- Значения округлить до двух знаков после запятой.
- Для расчета НДС использовать формулу:`(S * (k / 100)) / (1 + k / 100)`
- Для расчета без НДС использовать формулу: `S / (1 + k / 100)`

```sql
  SELECT author,
         SUM(price * amount) AS Стоимость,
         ROUND((SUM(price * amount) * (18 / 100)) / (1 + (18 / 100)), 2) AS НДС,
         ROUND(SUM(price * amount) / (1 + (18 / 100)), 2) AS Стоимость_без_НДС
    FROM book
GROUP BY author;
```
```text
author          |Стоимость|НДС    |Стоимость_без_НДС|
----------------+---------+-------+-----------------+
Булгаков М.А.   |  4715.47| 719.31|          3996.16|
Достоевский Ф.М.| 11802.03|1800.31|         10001.72|
Есенин С.А.     |  9750.00|1487.29|          8262.71|
```

---

<h3 id="4" align="center">Группировка данных по условию HAVING</h3>

В запросах для фильтрации групп используется ключевое слово `HAVING`, которое
размещается после оператора `GROUP BY`.

```sql
  SELECT <field_1>
    FROM <tbl_name>
   WHERE <condition_1>
GROUP BY <field_1>
  HAVING <condition_1>
         [AND|OR|NOT] <condition_2>;
```

<p align="center">~~~</p>

Пример 1:

```sql
  SELECT author,
         AVG(price),
         SUM(price) AS sum
    FROM book
GROUP BY author
  HAVING AVG(price) > 600
     AND SUM(price) > 600;
```
```text
- взять таблицу book;
- сгруппировать записи по author;
- взять только те группы у которых:
    - средняя цена книги больше 600;
    - стоимость всех книг группы больше 600;
- вывести в таблицу:
    - название группы;
    - среднюю цену книги;
    - стоимость всех книг.
```
```text
author       |AVG(price)|SUM(price)|
-------------+----------+----------+
Булгаков М.А.|605.745000|1211.49   |
Есенин С.А.  |650.000000| 650.00   |
```

<p align="center">~~~</p>

Пример 2:

Вывести максимальную и минимальную цену книг каждого автора, кроме Есенина,
количество экземпляров книг которого больше 10.

```sql
  SELECT author,
         MIN(price) AS Минимальная_цена,
         MAX(price) AS Максимальная_цена
    FROM book
   WHERE author != 'Есенин С.А.'
GROUP BY author
  HAVING SUM(amount) > 10;
```
```text
- берем таблицу book;
- из неё отсекаем записи автор которых Есенин С.А.;
- группируем полученные записи по полю author;
- отсекаем все группы у которых общее кол-во книг меньше 10;
- выводим в таблицу:
    - название группы;
    - самую дешевую и самую дорогую книгу.
```
```text
author          |Минимальная_цена|Максимальная_цена|
----------------+----------------+-----------------+
Достоевский Ф.М.|          460.00|           799.01|
```

---

### Задание

Посчитать стоимость всех экземпляров каждого автора без учета книг «Идиот» и
«Белая гвардия». В результат включить только тех авторов, у которых суммарная
стоимость книг (без учета книг «Идиот» и «Белая гвардия») более 5000 руб.
Вычисляемый столбец назвать Стоимость. Результат отсортировать по убыванию
стоимости.

```text
- берем таблицу book;
- отсекаем все записи у которых title IN ('Идиот', 'Белая гвардия');
- группируем записи по полю author;
- отсекаем те группы у которых суммарная стоимость книг меньше 5000;
- формируем таблицу с полями:
    - author (название группы);
    - Стоимость (стоимость всех книг группы);
- сформированную таблицу отсортировать по убыванию стоимости.
```
```sql
  SELECT author,
         SUM(price * amount) AS Стоимость
    FROM book
   WHERE title NOT IN ('Идиот', 'Белая гвардия')
GROUP BY author
  HAVING sum(price * amount) > 5000
ORDER BY Стоимость DESC;
```
```text
author          |Стоимость|
----------------+---------+
Есенин С.А.     |  9750.00|
Достоевский Ф.М.|  7202.03|
```