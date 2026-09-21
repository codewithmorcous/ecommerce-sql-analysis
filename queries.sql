create database ecommerce_db;
use ecommerce_db;
select * from customers;
select * from products;
select * from orders;
select * from order_items;

-- Basic Queries
select customer_id, first_name, last_name, city, customer_segment 
  FROM customers WHERE city = 'Mumbai';
select product_id, product_name, category, unit_price 
  FROM products WHERE unit_price > 2000 
  ORDER BY  unit_price DESC;
select order_id, customer_id, order_date, order_status 
  FROM orders WHERE order_status = 'Cancelled'; # No cancelled orders 
select customer_segment, count(*) AS customer_count 
  FROM customers GROUP BY customer_segment 
  ORDER BY customer_count DESC;
select product_name, category, unit_price 
  FROM products 
  ORDER BY unit_price DESC LIMIT 5;

-- Joins & Aggregations 
select p.category, 
     Round(SUM(OI.quantity * OI.unit_price *(1 - OI.discount_ptc/100.0))) AS Revenue
FROM order_items OI  
JOIN products P ON OI.product_id = P.product_id
GROUP BY P.category
ORDER BY Revenue DESC;
 
select  payment_method, count(*) AS Ordr_per_payment
FROM orders
GROUP BY payment_method;

select O.ship_mode,
    ROUND(AVG(OI.quantity * OI.unit_price * (1 - OI.discount_pct / 100.0))) AS avg_order_value 
FROM orders O
JOIN order_items OI on O.order_id = OI.order_id
GROUP BY O.ship_mode
ORDER BY avg_order_value DESC; 

select P.product_id,
	count(OI.order_item_id) AS Times_orders
from products P
join order_items OI
on P.product_id=OI.product_id
Group by OI.product_id
having Times_orders > 5
order by P.product_id DESC;

select OI.order_item_id, OI.order_id, 
	 O.order_date, O.order_status,
    concat(C.first_name, ' ' , C.last_name) AS Full_name,
    P.product_name, P.category
from order_items OI
inner join orders O on OI.order_id=O.order_id
inner join customers C on O.customer_id=C.customer_id
inner join products P on OI.product_id=P.product_id
order by OI.order_item_id
limit 20;

-- SUBQUERIES 
select * from orders
where customer_id in (select customer_id from customers
where city = 'Mumbai');-- Only print customer who belong to Mumbai

select product_name, unit_price 
from products 
where unit_price > (select avg(unit_price) from products);

select customer_id,
	concat(first_name, ' ' , last_name) as Full_name
from customers 
where customer_id not in (select distinct customer_id from orders);

-- WINDOW FUNCTIONS
select product_name, unit_price,
	row_number() over (order by  unit_price DESC) AS Row_num,
    rank() over (order by unit_price DESC) AS Rank_num
from products;

select product_name, category, unit_price,
	RANK() OVER (partition by category order by unit_price DESC) 
    AS Rank_num
from products;

SELECT 
    customer_id,
    order_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_date
FROM orders
ORDER BY customer_id, order_date;