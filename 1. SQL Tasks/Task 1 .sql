CREATE DATABASE [e-commerce];
go

use [e-commerce];
go

create table customer(
customer_id int identity(1,1) primary key,
full_name varchar(100) not null,
email varchar(100) not null unique,
phone varchar(15) not null unique
);
go

create table [Order]( 
order_id int primary key,
customer_id int,
foreign key (customer_id) references customer (customer_id)
);
go 

create table [product](
product_id int primary key,
product_name varchar(100) not null,
description varchar(150) not null
);
go

create table order_details(
order_details_id int primary key,
order_id int,
product_id int,
constraint fk_order_odetails
foreign key (order_id) references [Order](order_id),
constraint fk_product_odetails
foreign key (product_id) references [product](product_id)
);
go

