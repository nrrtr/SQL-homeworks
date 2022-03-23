--=============== МОДУЛЬ 3. ОСНОВЫ SQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите для каждого покупателя его адрес проживания, 
--город и страну проживания.

select
	concat (last_name ,' ',first_name) AS "Customer name",
	address ,
	city ,
	country 
from 
	customer
inner join 
	public.address 
	on 
	public.customer.address_id = public.address.address_id --JOIN address USING (address_id)
inner join 
	public.city 
	on 
	public.address.city_id = public.city.city_id --JOIN city USING (city_id)
inner join 
	public.country 
	on 
	public.city.country_id = public.country.country_id --JOIN country USING (country_id)
;

--ЗАДАНИЕ №2
--С помощью SQL-запроса посчитайте для каждого магазина количество его покупателей.

select 
	store_id as "ID магазина", 
	count(*) as "Количество покупателей" 
from 
	customer
group by 
	store_id
	;  

--Доработайте запрос и выведите только те магазины, 
--у которых количество покупателей больше 300-от.
--Для решения используйте фильтрацию по сгруппированным строкам 
--с использованием функции агрегации.

select 
	store_id as "ID магазина", 
	count(*) as "Количество покупателей" 
from 
	customer
group by 
	store_id
having 
	count(*) > 300
	;  

-- Доработайте запрос, добавив в него информацию о городе магазина, 
--а также фамилию и имя продавца, который работает в этом магазине.

select 
	store_id as "ID магазина", 
	count(*) as "Количество покупателей" ,
	city as "Город",
	concat (staff.last_name ,' ',staff.first_name) as "Имя сотрудника"
from 
	customer
join store using (store_id)
inner join address on store.address_id = address.address_id 
inner join city on address.city_id = city.city_id 
join staff using (store_id)
group by -- GROUP BY 1,3,4
	store_id ,
	address.address_id , 
	city.city_id ,
	staff.last_name ,
	staff.first_name  
having 
	count(*) > 300
	;  

--ЗАДАНИЕ №3
--Выведите ТОП-5 покупателей, 
--которые взяли в аренду за всё время наибольшее количество фильмов

select 
	concat (customer.last_name, ' ',customer.first_name) as "Фамилия и имя покупателя",
	count(payment_id) as "Количество фильмов"
from
	payment
join customer using (customer_id)
group by 1
order by "Количество фильмов" 
desc limit 5
;

--ЗАДАНИЕ №4
--Посчитайте для каждого покупателя 4 аналитических показателя:
--  1. количество фильмов, которые он взял в аренду
--  2. общую стоимость платежей за аренду всех фильмов (значение округлите до целого числа)
--  3. минимальное значение платежа за аренду фильма
--  4. максимальное значение платежа за аренду фильма

select 
	concat(customer.last_name, ' ', customer.first_name) as "Фамилия и имя покупателя" ,
	count (payment_id) as "Количество фильмов" ,
	round(sum(amount)) as "Общая стоимость платежей" ,
	min(amount) as "Минимальная стоимость платежа" ,
	max(amount) as "Максимальная стоимость платежа" 
from 
	customer
join payment using (customer_id)
group by 1
;

--ЗАДАНИЕ №5
--Используя данные из таблицы городов составьте одним запросом всевозможные пары городов таким образом,
 --чтобы в результате не было пар с одинаковыми названиями городов. 
 --Для решения необходимо использовать декартово произведение.
 
select distinct 
	A.city as "Город 1",
	B.city as "Город 2"
from  -- from city A cross join city B 
	city A , 
	city B 
where 
	A.city != B.city
;

--ЗАДАНИЕ №6
--Используя данные из таблицы rental о дате выдачи фильма в аренду (поле rental_date)
--и дате возврата фильма (поле return_date), 
--вычислите для каждого покупателя среднее количество дней, за которые покупатель возвращает фильмы.
 
select customer_id ,
	avg( date_part('day' , return_date- rental_date))  
from
	rental r 
group by 1
order by customer_id 



--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Посчитайте для каждого фильма сколько раз его брали в аренду и значение общей стоимости аренды фильма за всё время.





--ЗАДАНИЕ №2
--Доработайте запрос из предыдущего задания и выведите с помощью запроса фильмы, которые ни разу не брали в аренду.





--ЗАДАНИЕ №3
--Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку "Премия".
--Если количество продаж превышает 7300, то значение в колонке будет "Да", иначе должно быть значение "Нет".







