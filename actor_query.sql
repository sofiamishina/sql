/*Determine the pair of actors who cast together the most */
With table1 as 
(select f1.actor_id as first_actor, f2.actor_id as second_actor, count(*) as times from film_actor as f1
  join film_actor as f2 on f1.film_id = f2.film_id and f1.actor_id < f2.actor_id 
  group by f1.actor_id, f2.actor_id order by f1.actor_id, f2.actor_id),
  /*first actor id*/
actor1 as (select first_actor from table1 where times = (select max(times) from table1)),
/*second actor id*/
actor2 as (select second_actor from table1 where times = (select max(times) from table1))

/*select actors' first and last names from self-joined 'Actor' table*/
 select concat(a1.first_name, ' ', a1.last_name) as 'first_actor',
 concat(a2.first_name, ' ', a2.last_name) as 'second_actor', title
 from actor as a1
 join actor as a2 on a1.actor_id <>a2. actor_id
 /*Cross join the table 'Film'  to match the actors'names with the films they played in*/
 cross join film
 where film_id in
/*filtering films list*/
 (select f1.film_id from film_actor as f1 join film_actor as f2 on f1.film_id = f2.film_id 
where 
f1.actor_id = (select * from actor1) and f2.actor_id = (select * from actor2))
/*filtering actors list*/
 and a1. actor_id in (select * from actor1) and a2.actor_id in (select * from actor2)
/*ordering by title*/
order by title










