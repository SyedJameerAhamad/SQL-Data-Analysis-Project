-- CREATING 3 KEY DATA SETS
-- SALES TABLE 
create table sales(
customer_id varchar2(5),
order_date date,
product_id integer);

--MEMBERS TABLE
create table members(
customer_id varchar2(5),
join_date timestamp);

--MENU TABLE
create table menu(
product_id integer,
product_name varchar2(5),
price integer);