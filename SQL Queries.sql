
--functional "SQL queries" that help answer his questions
--- What is the total amount each customer spent at the restaurant
select s.customer_id,sum(price) 
    from sales s join menu m 
    on s.product_id = m.product_id
    group by customer_id 
    order by customer_id;

--- How many days has each customer visited the restaurant?
select customer_id,count(distinct(order_date)) as days 
    from sales 
    group by customer_id
    order by customer_id;
    
--- What was the first iteam from the menu purchased by the ecah customer
select customer_id,s.product_id,product_name 
    from sales s join menu m
    on s.product_id = m.product_id;
    
--- What is the most purchased item on the menu and how many times was it purchased by all customers?
select count(s.product_id) as count,product_name 
    from sales s join menu m 
    on s.product_id = m.product_id
    group by product_name;
    
-- Which item was the most popular for each customer?
select customer_id,product_name,count(s.product_id) as order_count 
    from sales s join menu m 
    on s.product_id = m.product_id
    group by customer_id,product_name
    order by customer_id;
    
--- Which item was purchase first by the customer after they become a member?
select s.customer_id,me.product_name,order_date,join_date 
    from sales s join menu me 
    on s.product_id = me.product_id
    join members m
    on s.customer_id = m.customer_id
    where order_date = join_date
    order by customer_id;
    
--- What is the total items and amount spent for each member before they become a member?
select s.customer_id,sum(price) total_amount,count(s.product_id) total_items 
    from sales s join menu m 
    on s.product_id = m.product_id 
    join members me
    on s.customer_id = me.customer_id
    where order_date < join_date
    group by s.customer_id 
    order by s.customer_id;
    
--- If each $1 spent eqautes 10 points and 
--- sushi has a 2x points multiplier - How many points would
--- each customer have?
select customer_id,sum(case
    when product_name = 'sushi' then price*20
    else price*10
    end)as points
    from sales s join menu m
    on s.product_id = m.product_id
    group by  customer_id
    order by customer_id;
    
--- In the first week after a customer joins a program 
--- (Including their join data) they earn 2x points on all items,
--- not just sushi. How many points do customer A and B
--- have at the end of january?
select s.customer_id,price*20 as total_points
    from sales s join menu m
    on s.product_id = m.product_id
    join members me
    on s.customer_id = me.customer_id
    where order_date = join_date 
    order by s.customer_id;
--- Main query of last question  
SELECT DISTINCT customer_id,
       SUM(total_points) OVER(PARTITION BY customer_id) AS total_points
FROM
  (SELECT sales.customer_id,
          order_date,
          price * 20 AS total_points,
          join_date
   FROM sales
   JOIN menu ON sales.product_id = menu.product_id
   JOIN members ON sales.customer_id = members.customer_id)
WHERE order_date = join_date
  AND EXTRACT(MONTH FROM order_date) = 1;