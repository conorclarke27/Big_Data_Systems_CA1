/* Question 2 - Inserted Documents */
create table movies (id SERIAL PRIMARY KEY, title text NOT NULL, writer varchar(100), year int);
create table actors (id SERIAL PRIMARY KEY, name varchar(100) NOT NULL);
create table movies_actors (movie_id int, actor_id int, FOREIGN KEY (movie_id) REFERENCES movies(id), FOREIGN KEY (actor_id) REFERENCES actors(id), UNIQUE (movie_id, actor_id));

insert into movies (title, writer, year) VALUES ('Fight Club', 'Chuck Palahniuk', 1999);
insert into actors (name) VALUES ('Brad Pitt');
insert into actors (name) VALUES ('Edward Norton');
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Fight Club' LIMIT 1), (SELECT id from actors where name = 'Brad Pitt' LIMIT 1));
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Fight Club' LIMIT 1), (SELECT id from actors where name = 'Edward Norton' LIMIT 1));

insert into movies (title, writer, year) VALUES ('Pulp Fiction', 'Quentin Tarantino', 1994);
insert into actors (name) VALUES ('John Travolta');
insert into actors (name) VALUES ('Uma Thurman');
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Pulp Fiction' LIMIT 1), (SELECT id from actors where name = 'John Travolta' LIMIT 1));
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Pulp Fiction' LIMIT 1), (SELECT id from actors where name = 'Uma Thurman' LIMIT 1));

insert into movies (title, writer, year) VALUES ('Inglorius Basterds', 'Quentin Tarantino', 2009);
insert into actors (name) VALUES ('Diane Kruger');
insert into actors (name) VALUES ('Eli Roth');
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Inglorius Basterds' LIMIT 1), (SELECT id from actors where name = 'Brad Pitt' LIMIT 1));
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Inglorius Basterds' LIMIT 1), (SELECT id from actors where name = 'Diane Kruger' LIMIT 1));
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Inglorius Basterds' LIMIT 1), (SELECT id from actors where name = 'Eli Roth' LIMIT 1));

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
select m.* from movies m join movies_actors ma on m.id = ma.movie_id join actors a on ma.actor_id = a.id where a.name = 'Brad Pitt';
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
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Pulp Fiction' LIMIT 1),(SELECT id from actors WHERE name = 'Samuel L. Jackson' LIMIT 1));

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
-- create table full_names (id SERIAL PRIMARY KEY, first_name varchar(50), last_name varchar(50));
create table users (id SERIAL PRIMARY KEY, username text, first_name varchar(50), last_name varchar(50));
-- create table users_full_names (id SERIAL PRIMARY KEY, user_id int REFERENCES users(id), name_id int REFERENCES full_names(id), UNIQUE(user_id, name_id));

insert into users (username, first_name, last_name) VALUES ('GoodGuyGreg', 'Good Guy', 'Greg');
insert into users (username, first_name, last_name) VALUES ('ScumbagSteve', 'Scumbag', 'Steve');

-- insert into full_names (first_name, last_name) VALUES ('Good Guy', 'Greg');
-- insert into users_full_names (user_id, name_id) VALUES ((SELECT id from users where username = 'GoodGuyGreg'), (SELECT id from full_names where first_name = 'Good Guy' and last_name ='Greg'));

create table posts (id SERIAL PRIMARY KEY, user_id int, title varchar(100), body text, FOREIGN KEY (user_id) REFERENCES users(id));
create table comments(id SERIAL PRIMARY KEY, user_id int, comment text, post int, FOREIGN KEY (user_id) REFERENCES users(id), FOREIGN KEY (post) REFERENCES posts(id));

-- create table comments(id SERIAL PRIMARY KEY, username varchar(100), comment text);
-- create table posts_comments(id SERIAL PRIMARY KEY, post_id int REFERENCES posts(id), comment_id int REFERENCES comments(id));



insert into posts (user_id, title, body) VALUES ((SELECT id from users where username = 'GoodGuyGreg'), 'Passes out at party', 'Wakes up early and cleans house');
insert into posts (user_id, title, body) VALUES ((SELECT id from users where username = 'GoodGuyGreg'), 'Steals your identity', 'Raises your credit score');
insert into posts (user_id, title, body) VALUES ((SELECT id from users where username = 'GoodGuyGreg'), 'Reports a bug in your code', 'Sends you a Pull Request');
insert into posts (user_id, title, body) VALUES ((SELECT id from users where username = 'ScumbagSteve'), 'Borrows something', 'Sells it');
insert into posts (user_id, title, body) VALUES ((SELECT id from users where username = 'ScumbagSteve'), 'Borrows everything', 'The end');
insert into posts (user_id, title, body) VALUES ((SELECT id from users where username = 'ScumbagSteve'), 'Forks your repo on github', 'Sets it to private');

insert into comments (user_id, comment, post) VALUES ((SELECT id from users where username = 'GoodGuyGreg'), 'Hope you got a good deal!', (SELECT id from posts where title = 'Borrows something'));
insert into comments (user_id, comment, post) VALUES ((SELECT id from users where username = 'GoodGuyGreg'), 'What''s mine is yours!', (SELECT id from posts where title = 'Borrows everything'));
insert into comments (user_id, comment, post) VALUES ((SELECT id from users where username = 'GoodGuyGreg'), 'Don''t violate the licensing agreement!', (SELECT id from posts where title = 'Forks your repo on github'));
insert into comments (user_id, comment, post) VALUES ((SELECT id from users where username = 'ScumbagSteve'), 'It still isn''t clean', (SELECT id from posts where title = 'Passes out at party'));
insert into comments (user_id, comment, post) VALUES ((SELECT id from users where username = 'ScumbagSteve'), 'Denied your PR cause I found a hack', (SELECT id from posts where title = 'Reports a bug in your code'));

-- insert into posts_comments (post_id, comment_id) VALUES ((SELECT id from posts where title = 'Passes out at party'), (SELECT id from comments where  comment = ''));


/* 1. */
select * from users;
/* 2. */
 select * from posts;
/* 3. */
select p.*, u.username from posts p join users u on p.user_id = u.id where u.username = 'GoodGuyGreg';
/* 4. */
select p.*, u.username from posts p join users u on p.user_id = u.id where u.username = 'ScumbagSteve';
/* 5. */
select * from comments;
/* 6. */
select c.*, u.username from comments c join users u on c.user_id = u.id where username = 'GoodGuyGreg';
/* 7. */
select c.*, u.username from comments c join users u on c.user_id = u.id where username = 'ScumbagSteve';
/* 8. */
-- select c.* from comments c join comments_posts cp on c.id = cp.comment_id join posts p on cp.post_id = p.id where p.body = 'Reports a bug in your code';
select c.*, u.username from comments c join users u on c.user_id = u.id join posts p on c.post = p.id where p.title = 'Reports a bug in your code';

















