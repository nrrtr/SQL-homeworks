--=============== МОДУЛЬ 5. РАБОТА С POSTGRESQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Сделайте запрос к таблице payment и с помощью оконных функций добавьте вычисляемые колонки согласно условиям:
--Пронумеруйте все платежи от 1 до N по дате

select customer_id, payment_id , payment_date ,
	row_number () over (order by payment_date)
from payment p ;

--Пронумеруйте платежи для каждого покупателя, сортировка платежей должна быть по дате

select customer_id, payment_id , payment_date , 
	row_number () over (partition by customer_id order by payment_date)
from payment p;

--Посчитайте нарастающим итогом сумму всех платежей для каждого покупателя, сортировка должна 
--быть сперва по дате платежа, а затем по сумме платежа от наименьшей к большей

select customer_id, payment_id , payment_date , amount, 
	sum(amount) over (partition by customer_id order by payment_date, amount rows between unbounded preceding and current row)
from payment p; 

--Пронумеруйте платежи для каждого покупателя по стоимости платежа от наибольших к меньшим 
--так, чтобы платежи с одинаковым значением имели одинаковое значение номера.

select customer_id , payment_id , amount,
dense_rank  () over (partition by customer_id order by amount desc)
from payment p;

--Можно составить на каждый пункт отдельный SQL-запрос, а можно объединить все колонки в одном запросе.

select customer_id , payment_id , payment_date ,
	row_number () over (order by payment_date) as "column_1",
	row_number () over (partition by customer_id order by payment_date) as "column_2",
	sum(amount) over (partition by customer_id order by payment_date,amount rows between unbounded preceding and current row) as "column_3",
	dense_rank () over (partition by customer_id order by amount desc) as "column_4"
from payment p 
order by customer_id ;


--ЗАДАНИЕ №2
--С помощью оконной функции выведите для каждого покупателя стоимость платежа и стоимость 
--платежа из предыдущей строки со значением по умолчанию 0.0 с сортировкой по дате.

select customer_id , payment_id , payment_date , amount,
	lag(amount,1,0.00) over (partition by customer_id order by payment_date) as "last_amount"
from payment p;

--ЗАДАНИЕ №3
--С помощью оконной функции определите, на сколько каждый следующий платеж покупателя больше или меньше текущего.

select customer_id , payment_id , payment_date , amount ,
amount - lag(amount,-1) over (partition by customer_id order by payment_date) as "difference"
from payment p;

--ЗАДАНИЕ №4
--С помощью оконной функции для каждого покупателя выведите данные о его последней оплате аренды.

with cte as(
select customer_id , payment_id , payment_date , amount ,
	NTILE(payment_id) over (partition by customer_id order by payment_date desc) as lul
from payment)
select 
	customer_id ,
	payment_id ,
	payment_date, 
	amount  
from cte 
where lul=1;

--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--С помощью оконной функции выведите для каждого сотрудника сумму продаж за август 2005 года 
--с нарастающим итогом по каждому сотруднику и по каждой дате продажи (без учёта времени) 
--с сортировкой по дате.




--ЗАДАНИЕ №2
--20 августа 2005 года в магазинах проходила акция: покупатель каждого сотого платежа получал
--дополнительную скидку на следующую аренду. С помощью оконной функции выведите всех покупателей,
--которые в день проведения акции получили скидку




--ЗАДАНИЕ №3
--Для каждой страны определите и выведите одним SQL-запросом покупателей, которые попадают под условия:
-- 1. покупатель, арендовавший наибольшее количество фильмов
-- 2. покупатель, арендовавший фильмов на самую большую сумму
-- 3. покупатель, который последним арендовал фильм






