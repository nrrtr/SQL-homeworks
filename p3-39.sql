============= теория =============

create table table_one (
	name_one varchar(255) not null
);

create table table_two (
	name_two varchar(255) not null
);

insert into table_one (name_one)
values ('one'), ('two'), ('three'), ('four'), ('five');

insert into table_two (name_two)
values ('four'), ('five'), ('six'), ('seven'), ('eight');

select * from table_one;

select * from table_two;

--left, right, inner, full outer, cross

select t1.name_one, t2.name_two
from table_one t1
inner join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1
join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1
left join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1
right join table_two t2 on t1.name_one = t2.name_two

select c.last_name, a.address --596
from customer c
join address a on c.address_id = a.address_id

select c.last_name, a.address --599
from customer c
left join address a on c.address_id = a.address_id

select t1.name_one, t2.name_two
from table_one t1
full join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1
full join table_two t2 on t1.name_one = t2.name_two
where t1.name_one is null or t2.name_two is null

select t1.name_one, t2.name_two
from table_one t1
cross join table_two t2

select t1.name_one, t2.name_two
from table_one t1, table_two t2

select t1.name_one, t2.name_two
from table_one t1
inner join table_two t2 on t1.name_one != t2.name_two

select t1.name_one, t2.name_two
from table_one t1, table_two t2
where t1.name_one = t2.name_two

cross join / inner join / left,right,full

select c.first_name, c2.first_name --358 801
from customer c, customer c2

select c.first_name, c2.first_name --358 186
from customer c, customer c2
where c.first_name != c2.first_name

А - Б
Б - А

А - А

select c.first_name, c2.first_name --179 093
from customer c, customer c2
where c.first_name > c2.first_name

select distinct c.first_name, c2.first_name --349 281
from customer c, customer c2

delete from table_one;

delete from table_two;

insert into table_one (name_one)
select unnest(array[1,1,2]);

insert into table_two (name_two)
select unnest(array[1,1,3]);

select * from table_one

select * from table_two

select t1.name_one, t2.name_two
from table_one t1
join table_two t2 on t1.name_one = t2.name_two

1A	1B
1a	1b
2c	3d

1A1B
1A1b
1a1B
1a1b

select count(*) --599
from customer c

select count(*) --16044
from customer c
join rental r on r.customer_id = c.customer_id

select count(*) --16044
from rental c

select count(*) --445 483
from customer c
join rental r on r.customer_id = c.customer_id
join payment p on p.customer_id = c.customer_id

select count(*) --16049
from payment c

select count(*) --16049
from customer c
join rental r on r.customer_id = c.customer_id
join payment p on p.rental_id = r.rental_id and p.customer_id = c.customer_id

select t1.name_one, t2.name_two
from table_one t1
left join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1
right join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1
full join table_two t2 on t1.name_one = t2.name_two
where t1.name_one is null or t2.name_two is null

select t1.name_one, t2.name_two
from table_one t1
cross join table_two t2

select p.customer_id, p.amount, x
from payment p
cross join (select 10 as x) x

--union / except

select 1 as x, 1 as y
union --distinct
select 1 as x, 2 as y
union --distinct
select 1 as x, 3 as y
union --distinct
select 1 as x, 4 as y
union --distinct
select 1 as x, 5 as y

select 1 as x, 1 as y
union all
select 1 as x, 1 as y
union all
select 1 as x, 1 as y
union all
select 1 as x, 1 as y
union all
select 1 as x, 2 as y

select 1 as x, 1 as y
except 
select 1 as x, 1 as y

select 1 as x, 1 as y
except 
select 1 as x, 2 as y

select *
from (
	select 1 as x, 1 as y
union all
select 1 as x, 1 as y
union all
select 1 as x, 1 as y
union all
select 1 as x, 1 as y
union all
select 1 as x, 2 as y) t
except --distinct
select 1 as x, 1 as y

select *
from (
	select 1 as x, 1 as y
union all
select 1 as x, 1 as y
union all
select 1 as x, 1 as y
union all
select 1 as x, 1 as y
union all
select 1 as x, 2 as y) t
except all
select 1 as x, 1 as y


select address_id
from "dvd-rental_from_35".customer 
except
select address_id
from customer 

-- case

select last_name, 
	case 
		when length(last_name) < 5 then first_name
		when length(last_name) between 5 and 7 then 'средняя фамилия'
		else 'длинная фамилия'
	end "странная метрика"
from customer 

============= соединения =============

1. Выведите список названий всех фильмов и их языков
* Используйте таблицу film
* Соедините с language
* Выведите информацию о фильмах:
title, language."name"

select f.title, l."name"
from film f
join "language" l on f.language_id = l.language_id

1. Выведите все фильмы и их категории:
* Используйте таблицу film
* Соедините с таблицей film_category
* Соедините с таблицей category
* Соедините используя оператор using

select f.title, a.last_name
from film f
join film_actor fa on fa.film_id = f.film_id
join actor a on a.actor_id = fa.actor_id

select f.title, a.last_name
from film f
join film_actor fa using(film_id)
join actor a using(actor_id)

select c.address_id, s.address_id, s2.address_id
from customer c
join address a using(address_id)
join store s on s.store_id = c.store_id
join staff s2 on s2.staff_id = s.manager_staff_id


2. Выведите уникальный список фильмов, которые брали в аренду '24-05-2005'. 
* Используйте таблицу film
* Соедините с inventory
* Соедините с rental
* Отфильтруйте, используя where 

select f.title, r.rental_date
from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
where r.rental_date::date = '24-05-2005'

select f.title, r.rental_date
from film f
join inventory i on i.film_id = f.film_id
left join rental r on r.inventory_id = i.inventory_id and r.rental_date::date = '24-05-2005'

select f.title, r.rental_date
from film f
join inventory i on i.film_id = f.film_id
left join rental r on r.inventory_id = i.inventory_id
where r.rental_date::date = '24-05-2005'

2.1 Выведите все магазины из города Woodridge (city_id = 576)
* Используйте таблицу store
* Соедините таблицу с address 
* Соедините таблицу с city 
* Соедините таблицу с country 
* отфильтруйте по "city_id"
* Выведите полный адрес искомых магазинов и их id:
store_id, postal_code, country, city, district, address, address2, phone

select store_id, postal_code, country, city, district, address, address2, phone, s.address_id
from store s
join address a on a.address_id = s.address_id
join city c on c.city_id = a.city_id
join country c2 on c2.country_id = c.country_id
where c.city_id = 576

explain analyze
select store_id, postal_code, country, city, district, address, address2, phone, s.address_id
from store s
join address a on a.address_id = s.address_id
join city c on c.city_id = a.city_id
join country c2 on c2.country_id = c.country_id
where c.city_id = 576

============= агрегатные функции =============

count 
sum 
avg
min 
max 
array_agg
string_agg

3. Подсчитайте количество актеров в фильме Grosse Wonderful (id - 384)
* Используйте таблицу film
* Соедините с film_actor
* Отфильтруйте, используя where и "film_id" 
* Для подсчета используйте функцию count, используйте actor_id в качестве выражения внутри функции
* Примените функцильные зависимости

select count(*)
from film_actor fa
where fa.film_id = 384

select f.title, count(*)
from film f
join film_actor fa on fa.film_id = f.film_id
where fa.film_id = 384
group by f.title

select f.title, count(fa.actor_id)
from film f
join film_actor fa on fa.film_id = f.film_id
where fa.film_id = 384
group by f.title

select f.title, count(*), f.release_year, f.length, f.rental_duration
from film f
join film_actor fa on fa.film_id = f.film_id
where fa.film_id = 384
group by f.title, f.release_year, f.length, f.rental_duration

select f.title, count(*), f.release_year, f.length, f.rental_duration
from film f
join film_actor fa on fa.film_id = f.film_id
group by f.film_id

select f.title, count(*), f.release_year, f.length, f.rental_duration
from film f
join film_actor fa on fa.film_id = f.film_id
group by f.film_id, f.release_year

3.1 Посчитайте среднюю стоимость аренды за день по всем фильмам
* Используйте таблицу film
* Стоимость аренды за день rental_rate/rental_duration
* avg - функция, вычисляющая среднее значение
--4 агрегации

select avg(rental_rate/rental_duration),
	sum(rental_rate/rental_duration),
	min(rental_rate/rental_duration),
	max(rental_rate/rental_duration)
from film 

select payment_date::date, array_agg(customer_id)
from payment 
group by payment_date::date

select payment_date::date, string_agg(customer_id::text, ', ')
from payment 
group by payment_date::date

select count(1)
from customer 

select count(distinct first_name)
from customer 

============= группировки =============

4. Выведите месяцы, в которые было сдано в аренду более чем на 10 000 у.е.

* Используйте таблицу payment
* Сгруппируйте данные по месяцу используя date_trunc
* Для каждой группы посчитайте сумму платежей
* Воспользуйтесь фильтрацией групп, для выбора месяцев с суммой продаж более чем на 10 000 у.е.

select date_trunc('month', payment_date), sum(amount)
from payment 
group by date_trunc('month', payment_date)

select date_trunc('month', payment_date), sum(amount)
from payment 
where date_trunc('month', payment_date) > '2005-07-01'
group by date_trunc('month', payment_date)
having sum(amount) > 10000

-- найти сумму платежей пользователей меньше 5 и сумму платежей пользователей больше 5

select customer_id, sum(amount) filter (where amount < 5) "где меньше 5",
	sum(amount) filter (where amount > 5) "где больше 5"
from payment 
group by customer_id

select customer_id, staff_id, date_trunc('month', payment_date), sum(amount)
from payment 
where customer_id < 4
group by customer_id, staff_id, date_trunc('month', payment_date)
order by 1, 2, 3

select customer_id, staff_id, date_trunc('month', payment_date), sum(amount)
from payment 
where customer_id < 4
group by 1, 2, 3
order by 1, 2, 3

select customer_id, staff_id, date_trunc('month', payment_date), sum(amount)
from payment 
where customer_id < 4
group by grouping sets(1, 2, 3)
order by 1, 2, 3

select customer_id, staff_id, date_trunc('month', payment_date), sum(amount)
from payment 
where customer_id < 4
group by cube(1, 2, 3)
order by 1, 2, 3

select *
from (
	select customer_id, staff_id, date_trunc('month', payment_date), sum(amount)
	from payment 
	where customer_id < 4
	group by cube(1, 2, 3)
	order by 1, 2, 3) t
where customer_id is null

select customer_id, staff_id, date_trunc('month', payment_date), sum(amount)
from payment 
where customer_id < 4
group by rollup(1, 2, 3)
order by 1, 2, 3

4.1 Выведите список категорий фильмов, средняя продолжительность аренды которых более 5 дней
* Используйте таблицу film
* Соедините с таблицей film_category
* Соедините с таблицей category
* Сгруппируйте полученную таблицу по category.name
* Для каждой группы посчитайте средню продолжительность аренды фильмов
* Воспользуйтесь фильтрацией групп, для выбора категории со средней продолжительностью > 5 дней

select c.name
from film f
join film_category fc on fc.film_id = f.film_id
join category c on c.category_id = fc.category_id
group by c.category_id
having avg(f.rental_duration) > 5
============= подзапросы =============

5. Выведите количество фильмов, со стоимостью аренды за день больше, 
чем среднее значение по всем фильмам
* Напишите подзапрос, который будет вычислять среднее значение стоимости 
аренды за день (задание 3.1)
* Используйте таблицу film
* Отфильтруйте строки в результирующей таблице, используя опретаор > (подзапрос)
* count - агрегатная функция подсчета значений

select title
from film 
where rental_rate/rental_duration > (select avg(rental_rate/rental_duration) from film)

select count(*)
from film 
where rental_rate/rental_duration > (select avg(rental_rate/rental_duration) from film)

скаляр  - не имеет алиаса и используется в select, условии и крайне редко в cross join
таблицу - обязательно алиас используется во from и join 
одномерный массив - не миеет алиаса используется в условиях

select customer_id, sum(amount) / (select sum(amount) from payment) * 100
from payment 
group by customer_id

select customer_id, sum(amount) / x * 100
from payment 
cross join (select sum(amount) as x from payment) t
group by customer_id, x

6. Выведите фильмы, с категорией начинающейся с буквы "C"
* Напишите подзапрос:
 - Используйте таблицу category
 - Отфильтруйте строки с помощью оператора like 
* Соедините с таблицей film_category
* Соедините с таблицей film
* Выведите информацию о фильмах:
title, category."name"
* Используйте подзапрос во from, join, where

select category_id, "name"
from category 
where "name" like 'C%'

explain analyse
select f.title, t.name
from (
	select category_id, "name"
	from category 
	where "name" like 'C%') t 
join film_category fc on fc.category_id = t.category_id
join film f on f.film_id = fc.film_id --175 / 53.54 / 0.47

explain analyse
select f.title, t.name
from (
	select category_id, "name"
	from category 
	where "name" like 'C%') t 
left join film_category fc on fc.category_id = t.category_id
left join film f on f.film_id = fc.film_id --175 / 53.54 / 0.47

explain analyse
select f.title, t.name
from film f
join film_category fc on fc.film_id = f.film_id
join (
	select category_id, "name"
	from category 
	where "name" like 'C%') t on t.category_id = fc.category_id --175 / 53.54 / 0.47

explain analyse
select f.title, c.name
from film f
join film_category fc on fc.film_id = f.film_id and 
	fc.category_id in --(3, 4, 5)
		(select category_id
		from category 
		where "name" like 'C%')
join category c on c.category_id = fc.category_id --175 / 47.36 / 0.45

explain analyse
select f.title, c.name
from film f
join film_category fc on fc.film_id = f.film_id 
join category c on c.category_id = fc.category_id
where c.category_id in (
	select category_id
	from category 
	where "name" like 'C%') --175 / 47.21 / 0.43

explain analyze
select f.title, t.name
from film f
right join film_category fc on fc.film_id = f.film_id
right join (
	select category_id, "name"
	from category 
	where "name" like 'C%') t on t.category_id = fc.category_id --175 / 53.54 / 0.43

explain analyze
select f.title, c.name
from film f
join film_category fc on fc.film_id = f.film_id 
join category c on c.category_id = fc.category_id
where c."name" like 'C%'  --175 / 53.54

explain analyze --558
select customer_id, sum(amount), count(1), min(amount), max(amount), avg(amount)
from payment
group by customer_id
order by 1

select 738210 / 558

-- ТАК ДЕЛАТЬ НЕЛЬЗЯ
explain analyze --738210
select distinct customer_id, 
	(select sum(amount) 
	from payment p1
	where p1.customer_id = p.customer_id
	group by p1.customer_id),
	(select count(amount) 
	from payment p1
	where p1.customer_id = p.customer_id
	group by p1.customer_id),
	(select min(amount) 
	from payment p1
	where p1.customer_id = p.customer_id
	group by p1.customer_id),
	(select max(amount) 
	from payment p1
	where p1.customer_id = p.customer_id
	group by p1.customer_id),
	(select avg(amount) 
	from payment p1
	where p1.customer_id = p.customer_id
	group by p1.customer_id)
from payment p
order by 1

select t.concat, t1.amount
from (
	select customer_id, concat(first_name, ' ', last_name)
	from customer) t
cross join lateral (
	select *
	from payment p
	where p.customer_id = t.customer_id) t1
	
select t.concat, t1.amount
from (
	select customer_id, concat(first_name, ' ', last_name)
	from customer) t
cross join (
	select *
	from payment p
	where p.customer_id = t.customer_id) t1

Перед подзапросами в предложении FROM можно добавить ключевое слово LATERAL. 
Это позволит ссылаться в них на столбцы предшествующих элементов списка FROM. 
(Без LATERAL каждый подзапрос выполняется независимо и поэтому не может обращаться к другим элементам FROM.)

Перед табличными функциями в предложении FROM также можно указать LATERAL, но для них это ключевое слово необязательно; 
в аргументах функций в любом случае можно обращаться к столбцам в предыдущих элементах FROM.

Элемент LATERAL может находиться на верхнем уровне списка FROM или в дереве JOIN. 
В последнем случае он может также ссылаться на любые элементы в левой части JOIN, справа от которого он находится.

Когда элемент FROM содержит ссылки LATERAL, запрос выполняется следующим образом: сначала для строки элемента FROM с 
целевыми столбцами, или набора строк из нескольких элементов FROM, содержащих целевые столбцы, вычисляется элемент 
LATERAL со значениями этих столбцов. Затем результирующие строки обычным образом соединяются со строками, из которых 
они были вычислены. Эта процедура повторяется для всех строк исходных таблиц.