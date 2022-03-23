������� ' ' �� " "

' ' - ������
" " - ��������, �������� 


����������������� �����

select "select"
from "from"

�������������� ������� ���������� select;

select distinct �������, �������........
from .... 
join ..... on ������� ����������
where .........
group by ....
having ....
order by 
offset 
limit

���������� ������� ���������� select;

from 
on 
join 
where .........
group by ....
having ....
select -> ����� 
order by 
offset 
limit

1. �������� �������� id ������, ��������, ��������, ��� ������ �� ������� ������.
������������ ���� ���, ����� ��� ��� ���������� �� ����� Film (FilmTitle ������ title � ��)
- ����������� ER - ���������, ����� ����� ���������� �������
- as - ��� ������� ��������� 

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

select film_id "FilmFilm_id", title "FilmTitle", description "FilmDescription", release_year "��� ������� ������"
from film 

63
32

2. � ����� �� ������ ���� ��� ��������:
rental_duration - ����� ������� ������ � ����  
rental_rate - ��������� ������ ������ �� ���� ���������� �������. 
��� ������� ������ �� ������ ������� �������� ��������� ��� ������ � ����,
������� ������������ ������� ��������� cost_per_day
- ����������� ER - ���������, ����� ����� ���������� �������
- ��������� ������ � ���� - ��������� rental_rate � rental_duration
- as - ��� ������� ��������� 

select title, rental_rate / rental_duration as cost_per_day
from film 

select pg_typeof(100)

select pg_typeof(100.)

select pg_typeof('100')

select pg_typeof('100'::int)

select pg_typeof(cast('100' as text))

select pg_typeof('100')

integer 	varchar

�������� 
���������� 
���� � ����� 
����� ���
������� ���� 
is null
is not null
void

2*
- �������������� ��������
- �������� round

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


3.1 ������������� ������ ������� �� �������� ��������� �� ���� ������ (�.2)
- ����������� order by (�� ��������� ��������� �� �����������)
- desc - ���������� �� ��������

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

3.1* ������������ ������� �������� �� ����������� ����� ������� (amount)
- ����������� ER - ���������, ����� ����� ���������� �������
- ����������� order by 
- asc - ���������� �� ����������� 

select *
from payment 
order by amount

3.2 ������� ���-10 ����� ������� ������� �� ��������� �� ���� ������
- ����������� limit

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

3.3 ������� ���-10 ����� ������� ������� �� ��������� ������ �� ����, ������� � 58-�� �������
- �������������� Limit � offset

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc
offset 57
limit 10


3.3* ������� ���-15 ����� ������ ��������, ������� � ������� 14000
- �������������� Limit � Offset

select *
from payment 
order by amount
offset 13999
limit 15
	
4. ������� ��� ���������� ���� ������� �������
- �������������� distinct

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

4* ������� ���������� ����� �����������
- ����������� ER - ���������, ����� ����� ���������� �������
- �������������� distinct

select distinct first_name
from customer 

select distinct customer_id, payment_id, amount, payment_date --16�049
from payment 

select distinct on (customer_id) customer_id, payment_id, amount, payment_date --599
from payment

select distinct on (customer_id) customer_id, payment_id, amount, payment_date --599
from (select * from payment order by payment_date) t
order by customer_id, payment_date

select distinct on (customer_id) payment_id, amount, payment_date --599
from (select * from payment order by payment_date) t


5.1. ������� ���� ������ �������, ������� ������� 'PG-13', � ����: "�������� - ��� �������"
- ����������� ER - ���������, ����� ����� ���������� �������
- "||" - �������� ������������, ������� �� concat
- where - ����������� ����������
- "=" - �������� ���������

varchar(N) 0 - N ��������
varchar(150) 0 - 150
char(N) = N ��������
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

5.2 ������� ���� ������ �������, ������� �������, ������������ �� 'PG'
- cast(�������� ������� as ���) - ��������������
- like - ����� �� �������
- ilike - ������������������� �����
- lower
- upper
- length

select distinct rating
from film 

select pg_typeof(rating)
from film 

������: �������� �� ����������: mpaa_rating ~~ unknown

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

5.2* �������� ���������� �� ����������� � ������ ���������� ���������'jam' (���������� �� �������� ���������), � ����: "��� �������" - ����� �������.
- "||" - �������� ������������
- where - ����������� ����������
- ilike - ������������������� �����
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

���/���

select split_part(split_part('avxbvvaa', 'b', 1), 'v', 2)
	
6. �������� id �����������, ������������ ������ � ���� � 27-05-2005 �� 28-05-2005 ������������
- ����������� ER - ���������, ����� ����� ���������� �������
- between - ������ ���������� (������ ... >= ... and ... <= ...)
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

-- ������ �� ������
select payment_id, payment_date
from payment 
where payment_date >= '27-05-2005' and payment_date <= '28-05-2005'
order by payment_date desc

-- ������ �� ������
select payment_id, payment_date
from payment 
where payment_date between '27-05-2005' and '28-05-2005'
order by payment_date desc

select payment_id, pg_typeof(payment_date)
from payment 

--��� �����
select payment_id, payment_date
from payment 
where payment_date between '27-05-2005' and '28-05-2005 24:00:00'
order by payment_date desc

select payment_id, payment_date
from payment 
where payment_date between '27-05-2005' and '29-05-2005'
order by payment_date desc

--�����
select payment_id, payment_date
from payment 
where payment_date between '27-05-2005' and '28-05-2005'::date + interval '1 day'
order by payment_date desc

select payment_id, payment_date
from payment 
where payment_date between '27-05-2005' and '28-05-2005'::date + interval '24 hours'
order by payment_date desc

29-05-2005 00:00:00.000

--�����
select payment_id, payment_date
from payment 
where payment_date::date between '27-05-2005' and '28-05-2005'
order by payment_date desc
  
6* ������� ������� ����������� ����� 2005-07-08
- ����������� ER - ���������, ����� ����� ���������� �������
- > - ������� ������ (< - ������� ������)

select payment_id, payment_date
from payment 
where payment_date::date > '2005-07-08'

2005-07-09 13:24:07.000+8

'27/05/2005'
'27.05.2005'
'2005-07-08'
'2005/07/08'

���-�����-�����
��.��.����

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

7 �������� ���������� ���� � '30-04-2007' �� ����������� ����.
�������� ���������� ������� � '30-04-2007' �� ����������� ����.
�������� ���������� ��� � '30-04-2007' �� ����������� ����.


--���:
select current_date - '30-04-2007'

--������:
select date_part('year', age(now(), '30-04-2007')) * 12 + date_part('month', age(now(), '30-04-2007')) + 1

--����:
select date_part('year', age(now(), '30-04-2007'))

select age(now(), '30-04-2007')

���������� ��������� and � or

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

������� 1. �������� ���������� �������� ������� �� ������� �������.
��������� ��������� �������: letsdocode.ru...in/2-1.png

������� 2. ����������� ������ �� ����������� �������, ����� ������ ������� ������ �� ������, 
�������� ������� ���������� �� �L� � ������������� �� �a�, � �������� �� �������� ��������.
��������� ��������� �������: letsdocode.ru...in/2-2.png

������� 3. �������� �� ������� �������� �� ������ ������� ���������� �� ��������, 
������� ����������� � ���������� � 17 ���� 2005 ���� �� 19 ���� 2005 ���� ������������ � 
��������� ������� ��������� 1.00. ������� ����� ������������� �� ���� �������.
��������� ��������� �������: letsdocode.ru...in/2-3.png

������� 4. �������� ���������� � 10-�� ��������� �������� �� ������ �������.
��������� ��������� �������: letsdocode.ru...in/2-4.png

payment_id - serial 
integer  nextval(sequence) + 1

������� 5. �������� ��������� ���������� �� �����������:

������� � ��� (� ����� ������� ����� ������)
����������� �����
����� �������� ���� email
���� ���������� ���������� ������ � ���������� (��� �������)
������ ������� ������� ������������ �� ������� �����.
��������� ��������� �������: letsdocode.ru...in/2-5.png

������� 6. �������� ����� �������� ������ �������� �����������, ����� ������� KELLY ��� WILLIE. 
��� ����� � ������� � ����� �� �������� �������� ������ ���� ���������� � ������ �������.
��������� ��������� �������: letsdocode.ru...in/2-6.png

�������������� �����:

������� 1.�������� ����� �������� ���������� � �������, � ������� ������� �R� � ��������� ������ ������� �� 0.00 �� 3.00 ������������, � ����� ������ c ��������� �PG-13� � ���������� ������ ������ ��� ������ 4.00.
��������� ��������� �������: letsdocode.ru...in/2-7.png

������� 2. �������� ���������� � ��� ������� � ����� ������� ��������� ������.
��������� ��������� �������: letsdocode.ru...in/2-8.png

������� 3. �������� Email ������� ����������, �������� �������� Email �� 2 ��������� �������:

� ������ ������� ������ ���� ��������, ��������� �� @,
�� ������ ������� ������ ���� ��������, ��������� ����� @.
��������� ��������� �������: letsdocode.ru...in/2-9.png
������� 4. ����������� ������ �� ����������� �������, �������������� �������� � ����� ��������: ������ ����� ������ ���� ���������, ��������� ���������.
��������� ��������� �������: letsdocode.ru...n/2-10.png