
/* Q1. Create a table called employees with the following structure
 emp_id (integer, should not be NULL and should be a primary key)
 emp_name (text, should not be NULL)
 age (integer, should have a check constraint to ensure the age is at least 18)
 email (text, should be unique for each employee)
 salary (decimal, with a default value of 30,000).
 Write the SQL query to create the above table with all constraints. */
 
 -- ANS:
 
create database sql_basics;
use sql_basics;
create table employees(
emp_id int not null primary key,
emp_name varchar(100) not null,
age int check(age>=18),
email varchar(100) unique,
salary decimal(10,2) default 30000.00
);


/* Q.2  Explain the purpose of constraints and how they help maintain 
data integrity in a database. Provide examples of common types of constraints.

ANS:
Constraints in a database serve to define rules that 
ensure data integrity and consistency. 
They restrict the type of data that can be entered 
into a table, preventing invalid or inconsistent data 
from being inserted, updated, or deleted. 
Constraints help maintain data integrity by:
Ensuring data accuracy and consistency,
Preventing data duplication or inconsistencies,
Limiting data entry to specific formats or ranges 
Example: Why Constraints Matter
Imagine a table without constraints: 

INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (NULL, NULL, -5, 'duplicate@example.com', -1000);

Without constraints, this invalid data would be accepted. 
But with constraints like NOT NULL, CHECK, and UNIQUE, 
the database would reject it—protecting your data from corruption.
*/


/* Q3. Why would you apply the NOT NULL constraint to a column?
 Can a primary key contain NULL values? Justify 
your answer.

ANS:
Applying NOT NULL Constraint:
You would apply the NOT NULL constraint to a column when:
The column requires a value for every row.
The column cannot be left blank or empty.
The data in the column is essential for the row to be meaningful.
By applying NOT NULL, you ensure that users must provide a value for that column, 
preventing null values and maintaining data integrity.
Primary Key and NULL Values:
No, a primary key cannot contain NULL values. A primary key uniquely identifies 
each row in a table, and NULL values would compromise this uniqueness. 
Primary keys implicitly have a NOT NULL constraint, ensuring every row has a valid, 
unique identifier.
This is because:
Primary keys require uniqueness.
NULL values cannot be unique.
Primary keys must identify each row, and NULL would make identification impossible.
Therefore, primary keys are inherently NOT NULL.
*/


/*Q4. Explain the steps and SQL commands used to add or remove constraints on 
an existing table. Provide an example for both adding and removing a constraint.

ANS:
Adding a Constraint to an Existing Table
Steps:
Identify the Constraint Type: Determine which constraint 
(e.g., PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK) you need to add.
Check Table Compatibility: Ensure the existing data in the table doesn’t violate the 
new constraint (e.g., no NULLs for a NOT NULL constraint, no duplicates for UNIQUE).
Use ALTER TABLE with ADD CONSTRAINT: Specify the constraint details, including a 
name (optional but recommended) and the column(s) affected.
Execute the Query: Run the SQL command to apply the constraint.
Verify: Check the table structure (e.g., using DESCRIBE or SHOW CREATE TABLE) to 
confirm the constraint was added.

*/
-- example of add constraints
alter table employees
add constraint unique_emp_id unique (emp_id);

/* Removing a Constraint from an Existing Table
Steps:
Identify the Constraint: Find the constraint’s name using SHOW CREATE TABLE or 
INFORMATION_SCHEMA queries, as MySQL requires the constraint 
name for removal (except for NOT NULL).
Use ALTER TABLE with DROP CONSTRAINT: Specify the constraint name to remove it.
Execute the Query: Run the SQL command to drop the constraint.
Verify: Confirm the constraint is removed by checking the table structure. */

-- example of removing contstraint
alter table employees
drop constraint unique_emp_id;

/* Q5. Explain the consequences of attempting to insert, update, or delete data in a 
way that violates constraints. 
Provide an example of an error message that might occur when violating a constraint.

ANS:
Consequences of Violating SQL Constraints:
In SQL, constraints enforce rules on the data in a table to ensure accuracy, 
reliability, and integrity. When a query violates one of these constraints 
during an INSERT, UPDATE, or DELETE operation, the database will block 
the action and return an error.
*/
-- example of error message
create table Q5(
student_id int primary key,
name varchar(30)
);
insert into Q5(student_id,name) values(11,'Abhinav'); -- this will work
insert into Q5(student_id,name) values(11,'Adu'); -- this will not work bcs 11 already exist


/*
 Q6. You created a products table without constraints as follows:
 CREATE TABLE products (
 product_id INT,
 product_name VARCHAR(50),
 price DECIMAL(10, 2));
 Now, you realise that
 The product_id should be a primary key
 The price should have a default value of 50.00
 */
 -- ANS:
 create table products(
 product_id int,
 product_name varchar(50),
 price decimal(10,2)
 );

-- Add primary key constraint on product_id
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

-- price default value=50.00
alter table products
alter column price set default 50.00;

select * from products;

select price
from products;


/* 
Q7. You have two tables: Students and Classes
Write a query to fetch the student_name and class_name 
for each student using an INNER JOIN
*/
-- ANS:
use sql_basics;
create table Students(
student_id int,
student_name varchar(30),
class_id int
);
insert into Students(student_id,student_name,class_id)
values 
(1,'Alice',101),
(2,'Bob',102),
(3,'Charlie',101);

-- creating another table Classes
create table Classes(
class_id int,
class_name varchar(11)
);
insert into Classes(class_id,class_name)
values
(101,'Math'),
(102,'Science'),
(103,'History');

-- fetching student_name & class_name using inner join
select Students.student_name, Classes.class_name
from Students 
inner join Classes on Students.class_id= Classes.class_id


/* 
Q8:Consider the following three tables:
orders,customers and products8.
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are 
listed even if they are not associated with an order 
*/

-- ANS:
create table orders(
order_id int,
order_date date,
customer_id int
);
insert into orders(order_id,order_date,customer_id)
values
(1,'2024-01-01',101),
(2,'2024-01-03',102);

create table customers(
customer_id int,
customer_name varchar(22)
);
insert into customers(customer_id,customer_name)
values
(101,'Alice'),
(102,'Bob');

create table products8(
product_id int,
product_name varchar(11),
order_id int
);
insert into products8(product_id,product_name,order_id)
values
(1,'Laptop',1),
(2,'Phone',Null);

select
products8.order_id,
customers.customer_name,
products8.product_name
from products8 -- left table
left join orders on products8.order_id= orders.order_id
left join customers on orders.customer_id=customers.customer_id;


/* 
Q9.  Given the following tables:sales9,products9
Write a query to find the total sales amount for 
each product using an INNER JOIN and the SUM() function
*/
-- ANS:
use sql_basics;
create table sales9(
sale_id int,
product_id int,
amount int
);
insert into sales9(sale_id,product_id,amount)
values
(1,101,500),
(2,102,300),
(3,101,700);

create table products9(
product_id int,
product_name varchar(11)
);
insert into products9(product_id,product_name)
values
(101,'Laptop'),
(102,'Phone');

select sum(sales9.amount) as total_amount, products9.product_name
from products9
inner join sales9 on sales9.product_id=products9.product_id
group by products9.product_name;


/* 
Q10. You are given three tables:
orders10,customers10,order_details10

Write a query to display the order_id, customer_name, 
and the quantity of products ordered by each 
customer using an INNER JOIN between all three tables.
*/

-- ANS:
create table orders10(
order_id int,
order_date date,
customer_id int
);
insert into orders10(order_id,order_date,customer_id)
values
(1,'2024-01-02',1),
(2,'2024-01-05',2);

create table customers10(
customer_id int,
customer_name varchar(22)
);
insert into customers10(customer_id,customer_name)
values
(1,'Alice'),
(2,'Bob');

create table order_details10(
order_id int,
product_id int,
quantity int
);
insert into order_details10(order_id,product_id,quantity)
values
(1,101,2),
(1,102,1),
(2,101,3);

select orders10.order_id, customers10.customer_name
from orders10
inner join customers10 on orders10.customer_id=customers10.customer_id
inner join order_details10 on order_details10.order_id=orders10.order_id;


-- MAVENMOVIES
-- SQL COMMANDS
/*
 Q1-Identify the primary keys and foreign keys in maven movies db. 
 Discuss the differences.
*/
-- ANS:
-- command for primary key
use mavenmovies;
select database();

SELECT 
    TABLE_NAME,
    COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = 'mavenmovies'
    AND CONSTRAINT_NAME = 'PRIMARY';

-- command for foreign key
SELECT 
    TABLE_NAME AS foreign_table,
    COLUMN_NAME AS foreign_column,
    REFERENCED_TABLE_NAME AS referenced_table,
    REFERENCED_COLUMN_NAME AS referenced_column
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = 'mavenmovies'
    AND REFERENCED_TABLE_NAME IS NOT NULL;
/* Differences b/w primary and foreign key
Primary Key:
A primary key uniquely identifies each row in a table.
Guarantees uniqueness: No two rows can have the same primary key.
Cannot be NULL: Every row must have a value for the primary key.

Foreign Key:
A foreign key establishes a relationship between two tables—it “points” to a primary key in another table.
Creates a link between tables for data integrity.
Helps maintain referential integrity by ensuring that related data actually exists.
Can be NULL if the relationship is optional.
*/


/* 
Q2-List all details of actors.
*/
-- ANS:

select*from actor;


/* 
Q 3 -List all customer information from DB.
*/
-- Ans:

select * from customer;

/* 
Q 4 -List different countries.
*/
select * from country;

/* 
 Q5 -Display all active customers.
*/
select * from customer
where active= 1;

/*
Q6 -List of all rental IDs for customer with ID 1.
*/
select * from customer
where store_id=1;

/* 
 7-Display all the films whose rental duration is greater than 5 .
*/
select * from film
where rental_duration>5;

/*
 8 -List the total number of films whose replacement cost is greater than $15 and less than $20.
*/
select * from film
where replacement_cost>15 AND replacement_cost<20;

/*
 9-Display the count of unique first names of actors.
*/
select count(distinct first_name) as unique_first_name_actor
from actor;

/*
 10- Display the first 10 records from the customer table .
*/
select * from customer
limit 10;

/*
 11-Display the first 3 records from the customer table whose first name starts with ‘b’.
*/
select * from customer
where first_name like 'B%'
limit 3;

/* 12 -Display the names of the first 5 movies which are rated as ‘G’
*/
select * from film
where rating= 'G'
limit 5;

/*
 13-Find all customers whose first name starts with "a".
*/
select * from customer
where first_name like 'a%';

/*
14- Find all customers whose first name ends with "a".
*/
select * from customer
where first_name like '%a';

/*
 15- Display the list of first 4 cities which start and end with ‘a’ .
*/
select * from city
where city like 'a%a'
limit 4;

/*
 16- Find all customers whose first name have "NI" in any position.
*/
select * from customer
where first_name like '%NI%';

/*
 17- Find all customers whose first name have "r" in the second position .
*/
select * from customer
where first_name like '_a%';

/*
 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length
*/
select * from customer
where first_name like 'a%' and 
length(first_name)>=5;

/*
 19- Find all customers whose first name starts with "a" and ends with "o".
*/
select * from customer
where first_name like 'a%a';

/*
 20 - Get the films with pg and pg-13 rating using IN operator.
*/
select * from film
where rating in ('pg','pg-13');

/*
 21-Get the films with length between 50 to 100 using between operator.
*/
select * from film
where length between 50 and 100;

/*
 22 - Get the top 50 actors using limit operator.
*/
select * from actor
limit 50;

/*
 23 - Get the distinct film ids from inventory table.
*/
select distinct film_id from inventory;

-- FUNCTIONS
-- Basic Aggregate Function:
/*
 Question 1:
 Retrieve the total number of rentals made in the Sakila database.
*/
select count(*)as total_rental from rental;

/*
 Question 2:
 Find the average rental duration (in days) of movies rented from the Sakila database.
*/
SELECT AVG(DATEDIFF(return_date, rental_date)) AS avg_rental_duration
FROM rental
WHERE return_date IS NOT NULL;

/*
Question 3:
 Display the first name and last name of customers in uppercase.
*/
select upper (first_name) as UPPER_first_name,
upper(last_name) as UPPER_last_name 
from customer;

/*
 Question 4:
 Extract the month from the rental date and display it alongside the rental ID.
*/
select rental_id,
month(rental_date) as rental_month
from rental;

-- GROUP BY:
/*
 Question 5:
 Retrieve the count of rentals for each customer (display customer ID and the count of rentals)
*/
select customer_id,
count(rental_id) as rental_count
 from rental
 group by customer_id;
 
 /*
  Question 6:
 Find the total revenue generated by each store.
 */
SELECT 
    staff.store_id,
    SUM(payment.amount) AS total_revenue
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id
GROUP BY staff.store_id;

/*
 Question 7:
 Determine the total number of rentals for each category of movies.
*/
SELECT 
    category.name AS category_name,
    COUNT(rental.rental_id) AS total_rentals
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY total_rentals DESC;

/*
 Question 8:
 Find the average rental rate of movies in each language.
*/
select 
language.name as language_name,
avg(film.rental_rate) as ave_rental_rate
from language
join film on film.language_id=language.language_id
group by language.name;


-- JOINS
/*
 Questions 9 -
 Display the title of the movie, customer s first name, and last name who rented it.
*/
SELECT 
    film.title AS movie_title,
    customer.first_name,
    customer.last_name
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN customer ON rental.customer_id = customer.customer_id;

/*
 Question 10:
 Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
*/
select
actor.first_name,actor.last_name
from actor
join film_actor on film_actor.actor_id=actor.actor_id
join film on film.film_id=film_actor.film_id
WHERE film.title = 'Gone with the Wind';

/* 
 Question 11:
 Retrieve the customer names along with the total amount they've spent on rentals.
*/
select
customer.first_name,customer.last_name,
sum(payment.amount) as total_amount,
payment.customer_id
from customer
join payment on payment.customer_id=customer.customer_id
group by customer_id;

/*
 Question 12:
 List the titles of movies rented by each customer in a particular city (e.g., 'London').
*/
SELECT 
    c.first_name,
    c.last_name,
    ci.city,
    f.title
FROM 
    customer c
JOIN 
    address a ON c.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    ci.city = 'London'
ORDER BY 
    c.last_name, c.first_name, f.title;


-- Advanced Joins and GROUP BY:
use mavenmovies;

/*
 Question 13:
 Display the top 5 rented movies along with the number of times they've been rented.
*/
SELECT film.title, COUNT(*) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
group by film.title
order by rental_count desc
limit 5;

/*
 Question 14:
 Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
*/
SELECT customer.customer_id, customer.first_name, customer.last_name
FROM customer
WHERE customer.customer_id IN (
    SELECT customer_id
    FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    WHERE inventory.store_id = 1
)
AND customer.customer_id IN (
    SELECT customer_id
    FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    WHERE inventory.store_id = 2
);

-- Windows Function:
/*
 1. Rank the customers based on the total amount they've spent on rentals.
*/
select
customer.first_name,customer.last_name,
sum(payment.amount) as total_amount
from customer
join payment on payment.customer_id=payment.customer_id
group by customer.customer_id,customer.first_name,customer.last_name
order by total_amount desc;

/*
 2. Calculate the cumulative revenue generated by each film over time.
*/
select 
film.title,
payment.payment_date,
sum(payment.amount)
over(partition by film.film_id
order by payment.payment_date
rows between unbounded preceding and current row
) as cumulative_revenue
from payment
join rental on payment.rental_id= rental.rental_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id=film.film_id;

/*
 3. Determine the average rental duration for each film, considering films with similar lengths
*/
SELECT film.title, film.length, AVG(DATEDIFF(rental.return_date, rental.rental_date)) AS average_rental_duration
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title, film.length;

/*
 4. Identify the top 3 films in each category based on their rental counts.
*/
WITH film_rental_counts AS (
  SELECT category.name AS category_name, category.category_id, film.title, COUNT(rental.rental_id) AS rental_count
  FROM film
  JOIN inventory ON film.film_id = inventory.film_id
  JOIN rental ON inventory.inventory_id = rental.inventory_id
  JOIN film_category ON film.film_id = film_category.film_id
  JOIN category ON film_category.category_id = category.category_id
  GROUP BY category.name, category.category_id, film.title
),
film_rental_ranks AS (
  SELECT category_name, title, rental_count,
         RANK() OVER (
           PARTITION BY category_id
           ORDER BY rental_count DESC
         ) AS rank_within_category
  FROM film_rental_counts
)

SELECT category_name, title, rental_count
FROM film_rental_ranks
WHERE rank_within_category <= 3;

/*
 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals
 across all customers.
*/
SELECT customer.customer_id, customer.first_name, customer.last_name,
       COUNT(rental.rental_id) AS total_rentals,
       COUNT(rental.rental_id) - (
         SELECT AVG(rental_count) 
         FROM (
           SELECT COUNT(rental.rental_id) AS rental_count
           FROM customer
           JOIN rental ON customer.customer_id = rental.customer_id
           GROUP BY customer.customer_id
         ) AS rental_summary
       ) AS rental_difference
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name;

/*
 6. Find the monthly revenue trend for the entire rental store over time.
*/
SELECT 
  YEAR(payment.payment_date) AS year,
  MONTH(payment.payment_date) AS month,
  SUM(payment.amount) AS monthly_revenue
FROM payment
GROUP BY YEAR(payment.payment_date), MONTH(payment.payment_date)
ORDER BY YEAR(payment.payment_date), MONTH(payment.payment_date);

/*
7. Identify the customers whose total spending on rentals falls within the top 20% of all customers
*/
WITH customer_spending AS (
  SELECT customer.customer_id, customer.first_name, customer.last_name,
         SUM(payment.amount) AS total_spent
  FROM customer
  JOIN payment ON customer.customer_id = payment.customer_id
  GROUP BY customer.customer_id, customer.first_name, customer.last_name
),
ranked_customers AS (
  SELECT customer_id, first_name, last_name, total_spent,
         NTILE(5) OVER (ORDER BY total_spent DESC) AS spend_bucket
  FROM customer_spending
)

SELECT customer_id, first_name, last_name, total_spent
FROM ranked_customers
WHERE spend_bucket = 1;

/*
 8. Calculate the running total of rentals per category, ordered by rental count
*/
WITH film_rentals AS (
  SELECT category.name AS category_name, category.category_id, film.title, COUNT(rental.rental_id) AS rental_count
  FROM film
  JOIN inventory ON film.film_id = inventory.film_id
  JOIN rental ON inventory.inventory_id = rental.inventory_id
  JOIN film_category ON film.film_id = film_category.film_id
  JOIN category ON film_category.category_id = category.category_id
  GROUP BY category.name, category.category_id, film.title
),
cumulative_rentals AS (
  SELECT category_name, title, rental_count,
         SUM(rental_count) OVER (
           PARTITION BY category_id
           ORDER BY rental_count DESC
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
         ) AS running_total
  FROM film_rentals
)

SELECT category_name, title, rental_count, running_total
FROM cumulative_rentals
ORDER BY category_name, running_total DESC;

/*
 9. Find the films that have been rented less than the average rental count for their respective categories.
*/
WITH film_rental_data AS (
  SELECT category.category_id, category.name AS category_name,
         film.film_id, film.title,
         COUNT(rental.rental_id) AS rental_count
  FROM film
  JOIN inventory ON film.film_id = inventory.film_id
  JOIN rental ON inventory.inventory_id = rental.inventory_id
  JOIN film_category ON film.film_id = film_category.film_id
  JOIN category ON film_category.category_id = category.category_id
  GROUP BY category.category_id, category.name, film.film_id, film.title
),
category_averages AS (
  SELECT category_id, AVG(rental_count) AS average_rentals
  FROM film_rental_data
  GROUP BY category_id
)

SELECT film_rental_data.category_name, film_rental_data.title, film_rental_data.rental_count
FROM film_rental_data
JOIN category_averages ON film_rental_data.category_id = category_averages.category_id
WHERE film_rental_data.rental_count < category_averages.average_rentals
ORDER BY film_rental_data.category_name, film_rental_data.rental_count ASC;

/*
 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month
*/
SELECT YEAR(payment.payment_date) AS year,
       MONTH(payment.payment_date) AS month,
       SUM(payment.amount) AS monthly_revenue
FROM payment
GROUP BY YEAR(payment.payment_date), MONTH(payment.payment_date)
ORDER BY monthly_revenue DESC
LIMIT 5;


-- Normalisation & CTE
/*
 1. First Normal Form (1NF):
               a. Identify a table in the Sakila database that violates 1NF. Explain how you
               would normalize it to achieve 1NF
*/
-- Step 1: Identify rows in the `film` table violating 1NF
select
film_id,
title,
special_features
from
mavenmovies.film
where
special_features is not null
and special_features like '%,%';

/*
How to Normalize the film Table to Achieve 1NF
To normalize the film table into 1NF, we need to eliminate the multi-valued special_features column by creating a new table to store each special feature as a separate row. This new table will have a foreign key referencing the film table, ensuring atomicity.

Steps:

Create a new table, film_special_features, to store individual special features.
Each row in this table will link a specific film_id to a single special feature.
Remove the special_features column from the film table.
*/



/*
Q2. Second Normal Form (2NF):
               a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
            If it violates 2NF, explain the steps to normalize it.
*/

/*
Second Normal Form (2NF) requires:

The table must already be in 1NF (all attributes are atomic, no repeating groups).
All non-key attributes must be fully functionally dependent on the entire primary key,
meaning no non-key attribute depends on only a part of a composite primary key.
*/
-- Step 1: Check the structure of the `film_actor` table
DESCRIBE mavenmovies.film_actor;

-- Step 2: Verify functional dependencies by inspecting sample data
SELECT 
    actor_id, 
    film_id, 
    last_update
FROM 
    mavenmovies.film_actor
LIMIT 10;

-- Step 3: Hypothetical - Add a violating attribute to demonstrate 2NF violation
ALTER TABLE mavenmovies.film_actor
ADD COLUMN actor_first_name VARCHAR(45);

-- Step 4: Populate the hypothetical column with data from the `actor` table
UPDATE mavenmovies.film_actor fa
JOIN mavenmovies.actor a ON fa.actor_id = a.actor_id
SET fa.actor_first_name = a.first_name;

-- Step 5: Check the violation (actor_first_name depends only on actor_id)
SELECT 
    actor_id, 
    actor_first_name, 
    film_id
FROM 
    mavenmovies.film_actor
WHERE 
    actor_first_name IS NOT NULL
LIMIT 10;

-- Step 6: Normalize to 2NF by removing actor_first_name from film_actor
ALTER TABLE mavenmovies.film_actor
DROP COLUMN actor_first_name;

-- Step 7: Ensure actor_first_name is in the `actor` table (already present in Sakila)
SELECT 
    actor_id, 
    first_name 
FROM 
    mavenmovies.actor
LIMIT 10;

/*
Q3. Third Normal Form (3NF):
               a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
               present and outline the steps to normalize the table to 3NF.
*/
-- Step 1: Check the structure of the `customer` table
DESCRIBE mavenmovies.customer;

-- Step 2: Hypothetical - Add a violating attribute to demonstrate 3NF violation
ALTER TABLE mavenmovies.customer
ADD COLUMN store_address VARCHAR(50);

-- Step 3: Populate the hypothetical column with data from the `store` and `address` tables
UPDATE mavenmovies.customer c
JOIN mavenmovies.store s ON c.store_id = s.store_id
JOIN mavenmovies.address a ON s.address_id = a.address_id
SET c.store_address = a.address;

-- Step 4: Check the transitive dependency (store_address depends on store_id)
SELECT 
    customer_id, 
    store_id, 
    store_address
FROM 
    mavenmovies.customer
WHERE 
    store_address IS NOT NULL
LIMIT 10;

-- Step 5: Normalize to 3NF by moving store_address to the `store` table
ALTER TABLE mavenmovies.store
ADD COLUMN store_address VARCHAR(50);

-- Step 6: Populate the `store` table with store_address
UPDATE mavenmovies.store s
JOIN mavenmovies.address a ON s.address_id = a.address_id
SET s.store_address = a.address;

-- Step 7: Remove store_address from the `customer` table
ALTER TABLE mavenmovies.customer
DROP COLUMN store_address;

-- Step 8: Verify the `store` table now contains store_address
SELECT 
    store_id, 
    store_address
FROM 
    mavenmovies.store
LIMIT 10;

-- Step 9: Verify the `customer` table structure after normalization
DESCRIBE mavenmovies.customer;

/*
Steps to Normalize to 3NF
To normalize the customer table to 3NF:

Identify the transitive dependency: store_id depends on address_id, which depends on customer_id.
Create a new table to store the relationship between customer_id and store_id.
Remove the transitive dependency by ensuring store_id is not stored in the customer table, as it can be derived through the address and store tables if needed.
However, in the Sakila schema, store_id is critical for business logic (indicating which store the customer rents from), so instead of removing it entirely, we ensure that any transitive dependencies involving store_id and address_id are resolved by verifying that store_id is functionally dependent on customer_id directly for the customer’s store assignment.
*/


/*
Q4. Normalization Process:
               a. Take a specific table in Sakila and guide through the process of normalizing it from the initial  
            unnormalized form up to at least 2NF.
*/
-- table: film(unnormalized)
/*
First Normal Form (1NF)
To achieve 1NF, we need to:

Eliminate multivalued attributes by creating a separate table for special_features.
Ensure all attributes contain atomic values.
Remove redundant data by referencing language_id instead of language_name.
1NF Tables:

film:
film_id (Primary Key)
title
description
release_year
language_id (Foreign Key to language table)
rental_duration
rental_rate
length
replacement_cost
rating
last_update
language:
language_id (Primary Key)
language_name
film_special_features (to handle the multivalued special_features):
film_id (Foreign Key to film)
feature (e.g., "Trailers", "Commentaries")

Second Normal Form (2NF)
To achieve 2NF, we need to:

Ensure the table is in 1NF.
Eliminate partial dependencies, where non-key attributes depend on only part of a composite primary key.
In the film table, the primary key is film_id (not composite), so all non-key attributes (e.g., title, description, language_id, etc.) depend fully on film_id. There are no partial dependencies in the film table.

In the film_special_features table, the primary key is composite (film_id, feature). The attribute feature depends on both film_id and itself, so there are no partial dependencies here either.
*/


/*
 5. CTE Basics:
                a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 
                have acted in from the actor and film_actor tables.
*/
WITH ActorNames AS (
    SELECT 
        actor_id,
        CONCAT(first_name, ' ', last_name) AS actor_name
    FROM actor
)
SELECT 
    an.actor_name,
    COUNT(fa.film_id) AS film_count
FROM ActorNames an
LEFT JOIN film_actor fa ON an.actor_id = fa.actor_id
GROUP BY an.actor_name
ORDER BY an.actor_name;


/*
 6. CTE with Joins:
 a. Create a CTE that combines information from the film and language tables to display the film title, 
language name, and rental rate.
*/
WITH film_language_cte AS (
    SELECT 
        film.title AS film_title,
        language.name AS language_name,
        film.rental_rate
    FROM mavenmovies.film
    JOIN mavenmovies.language ON film.language_id = language.language_id
)
SELECT * FROM film_language_cte
ORDER BY language_name, film_title;

/*
 7. CTE for Aggregation:
               a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
                from the customer and payment tables.
*/
with cust_pay_cte as(
select 
customer.first_name, customer.last_name,
customer.customer_id,
sum(payment.amount) as total_payment
from mavenmovies.customer
join mavenmovies.payment on payment.customer_id=customer.customer_id
GROUP BY customer.customer_id,customer.first_name, customer.last_name
)
select * from cust_pay_cte
order by total_payment desc;


/*
8 CTE with Window Functions:
 a. Utilize a CTE with a window function to rank films based on their rental duration from the film table
*/
with film_duration_ranks as(
select
film_id,
title,
rental_duration,
rank() over(
order by rental_duration desc
)as duration_rank
from mavenmovies.film
)
select * 
from film_duration_ranks
order by duration_rank;

/*
9.CTE and Filtering:
               a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 
            customer table to retrieve additional customer details.
*/
with active_customers as(
select
customer_id,
count(rental_id) as rental_count
from mavenmovies.rental
group by customer_id
having count(rental_id)>2
)
select
c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    a.rental_count
FROM active_customers a
JOIN mavenmovies.customer c ON a.customer_id = c.customer_id
ORDER BY a.rental_count DESC;

/*
10. CTE for Date Calculations:
 a. Write a query using a CTE to find the total number of rentals made each month, considering the 
rental_date from the rental table
*/
WITH monthly_rentals AS (
    SELECT 
        YEAR(rental_date) AS rental_year,
        MONTH(rental_date) AS rental_month,
        COUNT(*) AS total_rentals
    FROM mavenmovies.rental
    GROUP BY YEAR(rental_date), MONTH(rental_date)
)

SELECT *
FROM monthly_rentals
ORDER BY rental_year, rental_month;


/*
11.CTE and Self-Join:
 a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
together, using the film_actor table.
*/
WITH actor_pairs AS (
    SELECT 
        fa1.actor_id AS actor_1_id,
        fa2.actor_id AS actor_2_id,
        fa1.film_id
    FROM mavenmovies.film_actor fa1
    JOIN mavenmovies.film_actor fa2 
        ON fa1.film_id = fa2.film_id
        AND fa1.actor_id < fa2.actor_id
)

SELECT 
    ap.film_id,
    a1.first_name AS actor_1_first_name,
    a1.last_name AS actor_1_last_name,
    a2.first_name AS actor_2_first_name,
    a2.last_name AS actor_2_last_name
FROM actor_pairs ap
JOIN mavenmovies.actor a1 ON ap.actor_1_id = a1.actor_id
JOIN mavenmovies.actor a2 ON ap.actor_2_id = a2.actor_id
ORDER BY ap.film_id, actor_1_first_name, actor_2_first_name;


/*
12.CTE for Recursive Search:
 a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 
considering the reports_to column.
*/
WITH RECURSIVE StaffHierarchy AS (
    -- Anchor member: Start with the specific manager (e.g., staff_id = 1)
    SELECT 
        staff_id,
        CONCAT(first_name, ' ', last_name) AS employee_name,
        reports_to,
        0 AS hierarchy_level
    FROM staff
    WHERE staff_id = 1  -- Specify the manager's staff_id here
    UNION ALL
    -- Recursive member: Find employees who report to anyone in the hierarchy
    SELECT 
        s.staff_id,
        CONCAT(s.first_name, ' ', s.last_name) AS employee_name,
        s.reports_to,
        sh.hierarchy_level + 1 AS hierarchy_level
    FROM staff s
    INNER JOIN StaffHierarchy sh ON s.reports_to = sh.staff_id
)
SELECT 
    employee_name,
    staff_id,
    reports_to,
    hierarchy_level
FROM StaffHierarchy
ORDER BY hierarchy_level, employee_name;


