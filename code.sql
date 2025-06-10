
--1. Find Top 3 Outlets by cuisine type without using limit and top function.
--like in italian cuisine what are the top 3 restaurant with maximum number of orders.
with cte as(
 SELECT cuisine,Restaurant_id,Count(*) as no_of_orders
 from orders
 group by Cuisine,Restaurant_id)
 SELECT * from(
 SELECT *,
	ROW_NUMBER() over(partition by cuisine order by no_of_orders desc) as rowno
 from cte) a
 where rowno<=3
 --TOP/LIMIT works on the entire result set, not per group



--2..Find the daily new customer count from the launch date (everyday how many new customers we are acquiring)
with cte as(
	SELECT Customer_code, cast(MIN(Placed_at)AS date) as first_order_date 
	FROM orders
	GROUP BY Customer_code
	ORDER BY first_order_date)
SELECT first_order_date, count(*) as no_of_new_customers
FROM cte
GROUP BY first_order_date
Order BY first_order_date;







--3. Count of all the users who were acquired in jan 2025 and only placed one order in Jan and did not place any other order
Select Customer_code,count(*) as no_of_orders
from orders
where MONTH(Placed_at)=1 AND YEAR(Placed_at)=2025
AND Customer_code NOT IN (Select distinct Customer_code from orders
where not(MONTH(placed_at)=1 AND YEAR (placed_at)=2025))
group by Customer_code
Having COUNT(*) =1


--4. List All the customers with no order in the last 7 days but were acquired one month ago with their first order on promo
With cte as(
SELECT customer_code, MIN(Placed_at) as first_order_date,
max(placed_at) as latest_order_date
from orders
group by Customer_code)
SELECT cte.*, orders.Promo_code_Name as first_order_promo from cte
inner join orders on cte.Customer_code=orders.Customer_code and cte.first_order_date=orders.Placed_at
where latest_order_date < dateadd(DAY,-7,'2025-03-31')
and first_order_date< dateadd(month,-1,'2025-03-31') and orders.Promo_code_Name is not null;


--5.Growth team is planning to create a trigger that will target customers after their every third order with a personalized communication and they have asked you to create a query for this.
with cte as(
SELECT *,
ROW_NUMBER() over(partition by customer_code order by placed_at) as order_number
FROM orders)
select*
from cte
where order_number%3=0 and cast(Placed_at as date)= cast('2025-03-31' as date);

--6.List customers who placed more than 1 order and all their orders on a promo only

select Customer_code,count(*) as no_of_orders, count(Promo_code_Name) as promo_orders
from orders
group by Customer_code
Having count(*)>1 and COUNT(*)=Count(Promo_code_Name)

--7.what percent of customers were organically acquired in Jan 2025. (placed their first promo code)
 with cte as(
 SELECT *,
 ROW_NUMBER() over(partition by customer_code order by placed_at) as rn
 from orders 
 where MONTH(placed_at)=1)
 SELECT count(case when rn=1 AND Promo_code_Name is NULL then customer_code end)*100.0/count(distinct Customer_code)
 from cte
