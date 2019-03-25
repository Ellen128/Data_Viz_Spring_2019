use sakila;

select * from actor limit 10;

-- Display the first and last names of all actors from the table `actor`.
select first_name, last_name from sakila.actor;

-- Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.
select concat(first_name,  ' ', last_name) as 'Actor Name' from actor;

-- find the ID number, first name, and last name of an actor, of whom you know 
-- only the first name, "Joe." What is one query would you use to obtain this information?
select actor_id, first_name, last_name
from actor
where first_name = 'Joe';

-- Find all actors whose last name contain the letters `GEN`:
select actor_id, first_name, last_name
from actor
where last_name like '%GEN%';

-- Find all actors whose last names contain the letters `LI`. This time, 
-- order the rows by last name and first name, in that order:
select actor_id, first_name, last_name
from actor
where last_name like '%LI%'
order by last_name, first_name;
 
-- Using `IN`, display the `country_id` and `country` columns of the following
-- countries: Afghanistan, Bangladesh, and China:
select ci.country_id, co.country
	from city ci
	inner join country co 
	on ci.country_id = co.country_id
    where country in ('Afghanistan', 'Bangladesh', 'China');
    
-- 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, 
-- so create a column in the table `actor` named `description` and use the data type `BLOB` 
-- (Make sure to research the type `BLOB`, as the difference between it and `VARCHAR` are significant).
ALTER TABLE actor ADD description BLOB( 100 );
select * from actor limit 10;

-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. 
-- Delete the `description` column.
ALTER TABLE actor DROP description;
select * from actor limit 10;

-- 4a. List the last names of actors, as well as how many actors have that last name.
select last_name  , count(last_name)
	from actor
    group by last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names 
-- that are shared by at least two actors
select last_name  , count(last_name)
	from actor
    group by last_name
    having count(last_name) > 2;
    
    select last_name  , count(last_name)
	from actor
    where count(last_name) >2
    group by last_name;

-- 4c. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' and last_name = "WILLIAMS";

-- 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.
SET FOREIGN_KEY_CHECKS=0;
delete from actor
WHERE first_name = 'HARPO' and last_name = "WILLIAMS";

-- 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?

-- Hint: [https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html](https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html)

-- * 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
select s.first_name, s.last_name, a.address
	from staff s
    left join address a
    on s.address_id = a.address_id;
    
-- * 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.
select s.first_name, s.last_name, p.amount, p.payment_date
	from staff s
    left join payment p
    on s.staff_id = p.staff_id
    where p.payment_date like "2005-08%";

-- * 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
select f.title, count(fa.film_id)
	from film f
    left join film_actor fa
    on f.film_id = fa.film_id
    group by fa.film_id;
    
-- * 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
select f.title, count(i.film_id)
	from film f
    left join inventory i
    on f.film_id = i.film_id
    where f.title = 'Hunchback Impossible'
    group by i.film_id;
select * from customer limit 5;
select * from language limit 5;    
-- * 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. 
-- List the customers alphabetically by last name:   ![Total amount paid](Images/total_payment.png)
select c.first_name, c.last_name, sum(p.amount)
	from customer c
    left join payment p
    on c.customer_id = p.customer_id
    group by p.customer_id
    order by c.last_name;

-- * 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, 
-- films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to 
-- display the titles of movies starting with the letters `K` and `Q` whose language is English.
select * 
	from film f
    left join language l
    on f. language_id = l.language_id
    where f.title like 'K%' or f.title like 'Q%' and l.name = 'English';
    
-- * 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
select a.first_name, a.last_name 
	from film f
    left join film_actor fa
    on f.film_id = fa.film_id
    left join actor a
    on fa.actor_id = a.actor_id
    where f.title = upper("Alone trip");
-- * 7c. You want to run an email marketing campaign in Canada, for which you will need the 
-- names and email addresses of all Canadian customers. Use joins to retrieve this information.
select cu.first_name, cu.last_name, cu.email
	from country c
    left join city ci
    on c.country_id = ci.country_id
    left join address a
    on ci.city_id = a.city_id
    left join customer cu
    on a.address_id = cu.address_id
    where c.country = upper('canada') or c.country = lower('canada');
-- * 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as _family_ films.
select f.title, c.name 
	from category c
    left join film_category fc
    on c.category_id = fc.category_id
    left join film f
    on fc.film_id = f.film_id
    where c.name = 'Family';

-- * 7e. Display the most frequently rented movies in descending order.
select *
	from film 
    order by film.rental_rate desc; 
select s.store_id, s.manager_staff_id, sum(p.amount)
	from payment p
    left join customer c
    on p.customer_id = c.customer_id
    left join store s
    on c.store_id = s.store_id
    group by s.store_id;

-- * 7f. Write a query to display how much business, in dollars, each store brought in.

-- * 7g. Write a query to display for each store its store ID, city, and country.
select s.store_id, c.city, co.country
	from store s
    inner join address a
    on s.address_id = a.address_id
    inner join city c
    on a.city_id = c.city
    inner join country co
    on c.country_id = co.country_id;

-- * 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

-- * 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.

-- * 8b. How would you display the view that you created in 8a?

-- * 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.


