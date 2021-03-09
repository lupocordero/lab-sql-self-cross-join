-- SQL Self & Cross Join

#Get all pairs of actors that worked together
select fa1.film_id, a1.actor_id, concat(a1.first_name,' ',a1.last_name) as Actor1, 
a2.actor_id, concat(a2.first_name,' ',a2.last_name) as Actor2
from sakila.actor a1
join sakila.film_actor fa1
on a1.actor_id = fa1.actor_id
join sakila.film_actor fa2
on fa2.film_id=fa1.film_id and fa2.actor_id!=fa1.actor_id
join sakila.actor a2
on a2.actor_id=fa2.actor_id
order by fa1.film_id, a1.actor_id, concat(a1.first_name,' ',a1.last_name), a2.actor_id, concat(a2.first_name,' ',a2.last_name);

#Get all pairs of customers that have rented the same film more than 3 times

select c1.customer_id, c2.customer_id, count(f1.film_id) as N_Films from sakila.customer c1
join sakila.rental r1 on c1.customer_id = r1.customer_id
join sakila.inventory i1 on i1.inventory_id = r1.inventory_id
join sakila.film f1 on f1.film_id = i1.film_id
join sakila.inventory i2 on i2.film_id = f1.film_id
join sakila.rental r2 on r2.inventory_id = i2.inventory_id
join sakila.customer c2 on c2.customer_id = r2.customer_id
where c1.customer_id > c2.customer_id
group by c1.customer_id, c2.customer_id
having N_films >3
order by N_films desc;

#3 Get all possible pairs of actors and films.
select * from (
	select distinct actor_id from sakila.actor
) sub1
cross join (
	select distinct film_id from sakila.film
) sub2;