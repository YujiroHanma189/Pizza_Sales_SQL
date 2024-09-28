create database pizzahut;
use pizzahut;

create table orders_details(
orders_details_id int primary key,
order_id int not null,
pizza_id text not null,
quantity int not null
);

-- Basic
-- Retrieve the total number of orders placed.
select count(*) from orders;


-- Calculate the total revenue generated from pizza sales.
select  round(sum(o.quantity * p.price),1) as total_revenue
from orders_details o 
inner join pizzas p 
on o.pizza_id = p.pizza_id;


-- Identify the highest-priced pizza.
select pizza_types.name,pizzas.price
from pizza_types
inner join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc
 limit 1;
 

-- Identify the most common pizza size ordered.
select pizzas.size,count(orders_details.orders_details_id) as orders_count
from pizzas
inner join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by pizzas.size
order by orders_count desc;


-- List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name,sum(orders_details.quantity) as quantity
from pizza_types
inner join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
inner join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by quantity desc limit 5;


-- Intermediate:
-- Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category,sum(orders_details.quantity) Quantity
from pizza_types
inner join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
inner join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category
order by quantity desc;


-- Determine the distribution of orders by hour of the day.
select hour(order_time) as Hour, count(order_id)as order_count from orders
group by hour(order_time);


-- Join relevant tables to find the category-wise distribution of pizzas.
select category, count(pizza_type_id)as counts from pizza_types
group by category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(quantity),1)as avg_pizza_order from 
(select orders.order_date,sum(orders_details.quantity)as quantity
from orders
inner join orders_details
on orders.order_id = orders_details.order_id
group by orders.order_date) as avg_per_day_order;


-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name,round(sum(orders_details.quantity * pizzas.price),1) as revenue
from pizza_types 
inner join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
inner join orders_details 
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by revenue desc 
limit 3;


-- Advanced:
-- Calculate the percentage contribution of each pizza type to total revenue.
select pizza_types.category, (sum(orders_details.quantity * pizzas.price) / (select  round(sum(o.quantity * p.price),1) as total_revenue
from orders_details o 
inner join pizzas p 
on o.pizza_id = p.pizza_id))*100 as revenue
from pizza_types
inner join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
inner join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category 
order by revenue desc;


-- Analyze the cumulative revenue generated over time.
select order_date, sum(revenue) over (order by order_date) as cuv from 
(select orders.order_date, sum(orders_details.quantity * pizzas.price) as revenue
from orders 
inner join orders_details
on orders_details.order_id = orders.order_id
inner join pizzas 
on pizzas.pizza_id = orders_details.pizza_id
group by orders.order_date) as a;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select category,name,revenue from
(select category,name,revenue, rank() over (partition by category order by revenue desc) rn
from	
(select pizza_types.category, pizza_types.name, sum(orders_details.quantity * pizzas.price) as revenue
from pizza_types 
inner join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id
inner join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category ,pizza_types.name) as a) as b
where rn <= 3 ;

