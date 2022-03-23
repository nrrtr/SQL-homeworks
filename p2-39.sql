Отличие ' ' от " "

' ' - строка
" " - сущность, название 


Зарезервированные слова

select "select"
from "from"

синтаксический порядок инструкции select;

select distinct функции, столбцы........
from .... 
join ..... on условие соединения
where .........
group by ....
having ....
order by 
offset 
limit

логический порядок инструкции select;

from 
on 
join 
where .........
group by ....
having ....
select -> алиас 
order by 
offset 
limit

1. Получите атрибуты id фильма, название, описание, год релиза из таблицы фильмы.
Переименуйте поля так, чтобы все они начинались со слова Film (FilmTitle вместо title и тп)
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- as - для задания синонимов 

select film_id, title, description, release_year
from film 

select film_id FilmFilm_id, title FilmTitle, description FilmDescription, release_year FilmRelease_year
from film 

select film_id as FilmFilm_id, title as FilmTitle, description as FilmDescription, release_year as FilmRelease_year
from film 

select 
from (
	select film_id FilmFilm_id, title FilmTitle, description FilmDescription, release_year FilmRelease_year
	from film) t

select film_id FilmFilm_id, title FilmTitle, description FilmDescription, release_year FilmRelease_year
from film 

select film_id "FilmFilm_id", title "FilmTitle", description "FilmDescription", release_year "Год выпуска фильма"
from film 

63
32

2. В одной из таблиц есть два атрибута:
rental_duration - длина периода аренды в днях  
rental_rate - стоимость аренды фильма на этот промежуток времени. 
Для каждого фильма из данной таблицы получите стоимость его аренды в день,
задайте вычисленному столбцу псевдоним cost_per_day
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- стоимость аренды в день - отношение rental_rate к rental_duration
- as - для задания синонимов 

select title, rental_rate / rental_duration as cost_per_day
from film 

select pg_typeof(100)

select pg_typeof(100.)

select pg_typeof('100')

select pg_typeof('100'::int)

select pg_typeof(cast('100' as text))

select pg_typeof('100')

integer 	varchar

числовые 
символьные 
дата и время 
булев тип
сложные типы 
is null
is not null
void

2*
- арифметические действия
- оператор round

int 
numeric
float (real / double precision) 
serial 

select title, rental_rate / rental_duration as cost_per_day
from film 

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 

select title, round(rental_rate::int / rental_duration::int, 2) as cost_per_day
from film 

select 1./2

select title, round(rental_rate::float / rental_duration::float) as cost_per_day
from film 

SELECT x,
  round(x::numeric) AS num_round,
  round(x::double precision) AS dbl_round
FROM generate_series(-3.5, 3.5, 1) as x;


3.1 Отсортировать список фильмов по убыванию стоимости за день аренды (п.2)
- используйте order by (по умолчанию сортирует по возрастанию)
- desc - сортировка по убыванию

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by cost_per_day

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 --asc

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc, 1

select *, title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 16 desc, 15

3.1* Отсортируйте таблицу платежей по возрастанию суммы платежа (amount)
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- используйте order by 
- asc - сортировка по возрастанию 

select *
from payment 
order by amount

3.2 Вывести топ-10 самых дорогих фильмов по стоимости за день аренды
- используйте limit

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc, 1
limit 10

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc
limit 1

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc
fetch first 1 row only

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc
fetch first 1 row with ties

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc
fetch first 63 row with ties

3.3 Вывести топ-10 самых дорогих фильмов по стоимости аренды за день, начиная с 58-ой позиции
- воспользуйтесь Limit и offset

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc
offset 57
limit 10


3.3* Вывести топ-15 самых низких платежей, начиная с позиции 14000
- воспользуйтесь Limit и Offset

select *
from payment 
order by amount
offset 13999
limit 15
	
4. Вывести все уникальные годы выпуска фильмов
- воспользуйтесь distinct

select distinct release_year
from film 

select distinct film_id
from film 

explain analyze --77.50
select distinct film_id
from film 

explain analyze --65.50 /*ghfghfgh*/
select film_id
from film 

4* Вывести уникальные имена покупателей
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- воспользуйтесь distinct

select distinct first_name
from customer 

select distinct customer_id, payment_id, amount, payment_date --16 049
from payment 

select distinct on (customer_id) customer_id, payment_id, amount, payment_date --599
from payment

select distinct on (customer_id) customer_id, payment_id, amount, payment_date --599
from (select * from payment order by payment_date) t
order by customer_id, payment_date

select distinct on (customer_id) payment_id, amount, payment_date --599
from (select * from payment order by payment_date) t


5.1. Вывести весь список фильмов, имеющих рейтинг 'PG-13', в виде: "название - год выпуска"
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- "||" - оператор конкатенации, отличие от concat
- where - конструкция фильтрации
- "=" - оператор сравнения

varchar(N) 0 - N символов
varchar(150) 0 - 150
char(N) = N символов
char(10) 'aaaaa' -> 'aaaaa     '
text

select title, release_year, rating
from film 
where rating = 'PG-13'

select title, release_year, rating
from film 
where rating = 'PG-13'

select title || ' - ' || release_year, rating
from film 
where rating = 'PG-13'

select concat(title, ' - ', release_year), rating
from film 
where rating = 'PG-13'

select concat(title, ' - ', release_year, ' - ', rating)
from film 
where rating = 'PG-13'

select concat_ws(' - ', title, release_year, rating)
from film 
where rating = 'PG-13'

select 1 + null

select 'Hello' || null

select concat('Hello', null)

5.2 Вывести весь список фильмов, имеющих рейтинг, начинающийся на 'PG'
- cast(название столбца as тип) - преобразование
- like - поиск по шаблону
- ilike - регистронезависимый поиск
- lower
- upper
- length

select distinct rating
from film 

select pg_typeof(rating)
from film 

ОШИБКА: оператор не существует: mpaa_rating ~~ unknown

select title, release_year, rating
from film 
where rating::text like 'PG%'

select title, release_year, rating
from film 
where rating::text like 'PG___'

select title, release_year, rating
from film 
where rating::text like '%-%'

select title, release_year, rating
from film 
where rating::text not like '%-%'

select title, release_year, rating
from film 
where rating::text not like '__-__'

select title, release_year, rating
from film 
where rating::text like 'PG%' and character_length(rating::text) = 5

select title, release_year, rating
from film 
where rating::text ilike 'pg%'

select title, release_year, rating
from film 
where rating::text ilike 'pg___'

select title, release_year, rating
from film 
where lower(rating::text) like 'pg%'

select title, release_year, rating
from film 
where upper(rating::text) like 'PG%'

select title, release_year, rating
from film 
where title ilike '%x%%' escape 'x'
order by 1

select ''''

5.2* Получить информацию по покупателям с именем содержашим подстроку'jam' (независимо от регистра написания), в виде: "имя фамилия" - одной строкой.
- "||" - оператор конкатенации
- where - конструкция фильтрации
- ilike - регистронезависимый поиск
- strpos
- character_length
- overlay
- substring
- split_part

select *
from customer 
where first_name ilike '%jam%'

select strpos('Hello world', 'world') -- 7

select character_length('Hello world') -- 11

select length('Hello world') -- 11

select overlay('Hello world' placing 'Max' from 7 for 5)

select overlay('Hello world' placing 'Max' from strpos('Hello world', 'world') for length('world') )

select substring('Hello world', 7)

select substring('Hello world', 7, 3)

select split_part('Hello world and Max', ' ', 1), split_part('Hello world and Max', ' ', 2),
	split_part('Hello world and Max', ' ', 3), split_part('Hello world and Max', ' ', 4)
	
select split_part('Hello', 'l', 1), split_part('Hello', 'l', 2), split_part('Hello', 'l', 3)
	
select left('Hello world', 3)

select left('Hello world', -3)

select right('Hello world', -3)

select right('Hello world', 5)

select trim(both from 'heheheehllo worldheheheheh', 'he')

leading | trailing

select initcap('hello!world.max pitr')

БИК/КБК

select split_part(split_part('avxbvvaa', 'b', 1), 'v', 2)
	
6. Получить id покупателей, арендовавших фильмы в срок с 27-05-2005 по 28-05-2005 включительно
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- between - задает промежуток (аналог ... >= ... and ... <= ...)
- date_part()
- date_trunc()
- interval
-- extract

timestamp 
timestamptz 
date 
time 
timetz
interval

-- запрос не верный
select payment_id, payment_date
from payment 
where payment_date >= '27-05-2005' and payment_date <= '28-05-2005'
order by payment_date desc

-- запрос не верный
select payment_id, payment_date
from payment 
where payment_date between '27-05-2005' and '28-05-2005'
order by payment_date desc

select payment_id, pg_typeof(payment_date)
from payment 

--ТАК ПЛОХО
select payment_id, payment_date
from payment 
where payment_date between '27-05-2005' and '28-05-2005 24:00:00'
order by payment_date desc

select payment_id, payment_date
from payment 
where payment_date between '27-05-2005' and '29-05-2005'
order by payment_date desc

--МОЖНО
select payment_id, payment_date
from payment 
where payment_date between '27-05-2005' and '28-05-2005'::date + interval '1 day'
order by payment_date desc

select payment_id, payment_date
from payment 
where payment_date between '27-05-2005' and '28-05-2005'::date + interval '24 hours'
order by payment_date desc

29-05-2005 00:00:00.000

--НУЖНО
select payment_id, payment_date
from payment 
where payment_date::date between '27-05-2005' and '28-05-2005'
order by payment_date desc
  
6* Вывести платежи поступившие после 2005-07-08
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- > - строгое больше (< - строгое меньше)

select payment_id, payment_date
from payment 
where payment_date::date > '2005-07-08'

2005-07-09 13:24:07.000+8

'27/05/2005'
'27.05.2005'
'2005-07-08'
'2005/07/08'

Год-месяц-число
ММ.ДД.ГГГГ

select '2005-07-09 13:24:07.000'::time

select date_part('year', '2005-07-09 13:24:07.000'::date)

select date_part('month', '2005-07-09 13:24:07.000'::timestamp)

select date_part('hour', '2005-07-09 13:24:07.000'::timestamp)

select date_part('isodow', '2005-07-09 13:24:07.000'::timestamp)

select date_part('dow', '2005-07-09 13:24:07.000'::timestamp)

select date('2005-07-09 13:24:07.000')

select pg_typeof(date_trunc('year', '2005-07-09 13:24:07.000'::date))

select date_trunc('month', '2005-07-09 13:24:07.000'::timestamp)

select date_trunc('hour', '2005-07-09 13:24:07.000'::timestamp)

select date_trunc('isodow', '2005-07-09 13:24:07.000'::timestamp)

select date_trunc('dow', '2005-07-09 13:24:07.000'::timestamp)

04.2020
04.2021
04.2022

date_part - 4

date_trunc 04.2020 04.2021 04.2022

select ('2005-07-09'::date - '2004-07-09'::date) + interval '1 day'

select pg_typeof('2005-07-09'::date - '2004-07-09'::date)

select '2005-07-09'::timestamp - '2004-07-09'::timestamp + interval '100 day' + interval '2 month'

select pg_typeof('2005-07-09'::timestamp - '2004-07-09'::timestamp)

select now()

select current_timestamp

select current_date

select current_time

select '14.02.2020'::date + interval '0.5 month' 

7 Получить количество дней с '30-04-2007' по сегодняшний день.
Получить количество месяцев с '30-04-2007' по сегодняшний день.
Получить количество лет с '30-04-2007' по сегодняшний день.


--дни:
select current_date - '30-04-2007'

--Месяцы:
select date_part('year', age(now(), '30-04-2007')) * 12 + date_part('month', age(now(), '30-04-2007')) + 1

--Года:
select date_part('year', age(now(), '30-04-2007'))

select age(now(), '30-04-2007')

Логические операторы and и or

and > or 

select customer_id, amount
from payment 
where customer_id < 3 and amount = 2.99

select customer_id, amount
from payment 
where amount > 1 and amount < 3

select customer_id, amount
from payment 
where customer_id < 3 or amount = 2.99

select customer_id, amount
from payment 
where customer_id < 3 and (amount = 0.99 or amount = 2.99)

select e.emp_id
from nkh.employee e

Задание 1. Выведите уникальные названия городов из таблицы городов.
Ожидаемый результат запроса: letsdocode.ru...in/2-1.png

Задание 2. Доработайте запрос из предыдущего задания, чтобы запрос выводил только те города, 
названия которых начинаются на “L” и заканчиваются на “a”, и названия не содержат пробелов.
Ожидаемый результат запроса: letsdocode.ru...in/2-2.png

Задание 3. Получите из таблицы платежей за прокат фильмов информацию по платежам, 
которые выполнялись в промежуток с 17 июня 2005 года по 19 июня 2005 года включительно и 
стоимость которых превышает 1.00. Платежи нужно отсортировать по дате платежа.
Ожидаемый результат запроса: letsdocode.ru...in/2-3.png

Задание 4. Выведите информацию о 10-ти последних платежах за прокат фильмов.
Ожидаемый результат запроса: letsdocode.ru...in/2-4.png

payment_id - serial 
integer  nextval(sequence) + 1

Задание 5. Выведите следующую информацию по покупателям:

Фамилия и имя (в одной колонке через пробел)
Электронная почта
Длину значения поля email
Дату последнего обновления записи о покупателе (без времени)
Каждой колонке задайте наименование на русском языке.
Ожидаемый результат запроса: letsdocode.ru...in/2-5.png

Задание 6. Выведите одним запросом только активных покупателей, имена которых KELLY или WILLIE. 
Все буквы в фамилии и имени из верхнего регистра должны быть переведены в нижний регистр.
Ожидаемый результат запроса: letsdocode.ru...in/2-6.png

Дополнительная часть:

Задание 1.Выведите одним запросом информацию о фильмах, у которых рейтинг “R” и стоимость аренды указана от 0.00 до 3.00 включительно, а также фильмы c рейтингом “PG-13” и стоимостью аренды больше или равной 4.00.
Ожидаемый результат запроса: letsdocode.ru...in/2-7.png

Задание 2. Получите информацию о трёх фильмах с самым длинным описанием фильма.
Ожидаемый результат запроса: letsdocode.ru...in/2-8.png

Задание 3. Выведите Email каждого покупателя, разделив значение Email на 2 отдельных колонки:

в первой колонке должно быть значение, указанное до @,
во второй колонке должно быть значение, указанное после @.
Ожидаемый результат запроса: letsdocode.ru...in/2-9.png
Задание 4. Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: первая буква должна быть заглавной, остальные строчными.
Ожидаемый результат запроса: letsdocode.ru...n/2-10.png