-- INSERTING THE VALUES INTO THE 3 TABLES
--inserting values into the sales table
insert into sales values('&customer_id','&order_date','&product_id');
--RETRIEVING DATA
select * from sales;

--INSERTING VALUES INTO THE MEMBERS TABLE
insert into members values('&customer_id','&join_date');
--RETRIEVING DATA
select * from members;


--INSERTING THE VALUES INTO THE MENU TABLE
insert into menu values('&product_id','&product_name','&price');
--RETRIEVING DATA
select * from menu;