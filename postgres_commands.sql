/* Question 2 - Inserted Documents */
create table movies (movie_id SERIAL PRIMARY KEY, title text NOT NULL, writer varchar(100), year integer);
create table actors (actor_id SERIAL PRIMARY KEY, name varchar(100) NOT NULL);
create table movies_actors (id SERIAL PRIMARY KEY, mov_id integer REFERENCES movies(movie_id), act_id integer REFERENCES actors(actor_id), UNIQUE(mov_id, act_id));

insert into movies (title, writer, year) VALUES ('Fight Club', 'Chuck Palahniuk', 1999);
insert into actors (name) VALUES ('Brad Pitt');
insert into actors (name) VALUES ('Edward Norton');
insert into movies_actors (mov_id, act_id) VALUES ((SELECT movie_id from movies where title = 'Fight Club'), (SELECT actor_id from actors where name = 'Brad Pitt'));
insert into movies_actors (mov_id, act_id) VALUES ((SELECT movie_id from movies where title = 'Fight Club'), (SELECT actor_id from actors where name = 'Edward Norton'));

insert into movies (title, writer, year) VALUES ('Pulp Fiction', 'Quentin Tarantino', 1994);
insert into actors (name) VALUES ('John Travolta');
insert into actors (name) VALUES ('Uma Thurman');
insert into movies_actors (mov_id, act_id) VALUES ((SELECT movie_id from movies where title = 'Pulp Fiction'), (SELECT actor_id from actors where name = 'John Travolta'));
insert into movies_actors (mov_id, act_id) VALUES ((SELECT movie_id from movies where title = 'Pulp Fiction'), (SELECT actor_id from actors where name = 'Uma Thurman'));

insert into movies (title, writer, year) VALUES ('Inglorius Basterds', 'Quentin Tarantino', 2009);
insert into actors (name) VALUES ('Diane Kruger');
insert into actors (name) VALUES ('Eli Roth');
insert into movies_actors (mov_id, act_id) VALUES ((SELECT movie_id from movies where title = 'Inglorius Basterds'), (SELECT actor_id from actors where name = 'Brad Pitt'));
insert into movies_actors (mov_id, act_id) VALUES ((SELECT movie_id from movies where title = 'Inglorius Basterds'), (SELECT actor_id from actors where name = 'Diane Kruger'));
insert into movies_actors (mov_id, act_id) VALUES ((SELECT movie_id from movies where title = 'Inglorius Basterds'), (SELECT actor_id from actors where name = 'Eli Roth'));

alter table movies add column franchise varchar(50);
insert into movies (title, writer, year, franchise) VALUES ('The Hobbit: An Unexpected Journey', 'J.R.R. Tolkein', 2012, 'The Hobbit');

insert into movies (title, writer, year, franchise) VALUES ('The Hobbit: The Desolation of Smaug', 'J.R.R. Tolkein', 2013, 'The Hobbit');

alter table movies add column synopsis text;
insert into movies (title, writer, year, franchise, synopsis) VALUES ('The Hobbit: The Battle of the Five Armies', 'J.R.R. Tolkein', 2012, 'The Hobbit', 'Bilbo and Company are forced to engage in a war against an array of combatants and keep the Lonely Mountain from falling into the hands of a rising darkness.');

insert into movies (title) VALUES ('Pee Wee Herman''s Big Adventure');
insert into movies (title) VALUES ('Avatar');

/* Question 3 - Query/Find Documents */
/* 1. */
select * from movies;
/* 2. */
select * from movies where writer = 'Quentin Tarantino';
/* 3. */
select m.* from movies m join movies_actors ma on m.movie_id = ma.mov_id join actors a on ma.act_id = a.actor_id where a.name = 'Brad Pitt';
/* THIS ONE TOOK A LONG TIME TO GET RIGHT, ABOUT 40 MINS*/
/* 4. */
select * from movies where franchise = 'The Hobbit';
/* 5. */
select * from movies where year between 1990 and 1999;
/* 6. */
select * from movies where year <= 2000 or year >= 2010;

/* Question 4 - Update Documents */
/* 1. */
update movies set synopsis = 'A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home - and the gold within it - from the dragon Smaug' where title = 'The Hobbit: An Unexpected Journey';
/* 2. */
update movies set synopsis = 'The dwarves, along with Bilbo Baggins and Gandalf the Grey, continue their quest to reclaim Erebor, their homeland, from Smaug. Bilbo Baggins is in possession of a mysterious and magical ring.' where title = 'The Hobbit: The Desolation of Smaug';
/* 3. */
insert into actors (name) VALUES ('Samuel L. Jackson');
insert into movies_actors (mov_id, act_id) VALUES ((SELECT movie_id from movies where title = 'Pulp Fiction'),(SELECT actor_id from actors WHERE name = 'Samuel L. Jackson'));

/* Question 5 - Text search Documents */
/* 1. */
select * from movies where synopsis like '%Bilbo%';
select * from movies where synopsis ~* 'Bilbo';
/* 2. */
select * from movies where synopsis like '%Gandalf%';
select * from movies where synopsis ~* 'Gandalf';
/* 3. */
select * from movies where synopsis ~ 'Bilbo' and synopsis !~* 'Gandalf';
select * from movies where synopsis like '%Bilbo%' and synopsis not like '%Gandalf%';
/* 4. */
 select * from movies where synopsis like '%dwarves%' or synopsis like '%hobbit%';
 select * from movies where synopsis ~ 'dwarves' or synopsis ~ 'hobbit';
/* 5. */
select * from movies where synopsis like '%gold%' and synopsis like '%dragon%';
select * from movies where synopsis ~ 'gold' and synopsis ~ 'dragon';

/* Question 6 - Delete Documents */
/* 1. */
/* double check it is the one you want to delete */ 
select * from movies where title = 'Pee Wee Herman''s Big Adventure';
delete from movies where title = 'Pee Wee Herman''s Big Adventure';
/* 2. */
/* double check it is the one you want to delete */ 
select * from movies where title = 'Avatar';
delete from movies where title = 'Avatar';


/* Question 7 - Relationships */
create table full_names (id SERIAL PRIMARY KEY, first_name varchar(50), last_name varchar(50));
create table users (id SERIAL PRIMARY KEY, username text);
create table users_full_names (id SERIAL PRIMARY KEY, user_id integer REFERENCES users(id), name_id integer REFERENCES full_names(id), UNIQUE(user_id, name_id));

insert into users (username) VALUES ('GoodGuyGreg');
insert into full_names (first_name, last_name) VALUES ('Good Guy', 'Greg');





/* 1. */

/* 2. */

/* 3. */

/* 4. */

/* 5. */

/* 6. */

/* 7. */

/* 8. */



















