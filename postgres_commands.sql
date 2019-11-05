/* Question 2 - Inserted Documents */
-- creates a table movies with a pkey of id, a title, a writer and a year
create table movies (id SERIAL PRIMARY KEY, title text NOT NULL, writer varchar(100), year int);
-- creates a table actors with a pkey of id, and a name
create table actors (id SERIAL PRIMARY KEY, name varchar(100) NOT NULL);
-- create a table movies_actors with foreign keys for the movie_id and the actor_id
create table movies_actors (movie_id int, actor_id int, FOREIGN KEY (movie_id) REFERENCES movies(id), FOREIGN KEY (actor_id) REFERENCES actors(id), UNIQUE (movie_id, actor_id));

-- insert a movie into movies table 
insert into movies (title, writer, year) VALUES ('Fight Club', 'Chuck Palahniuk', 1999);
-- inserts actors into actors table
insert into actors (name) VALUES ('Brad Pitt');
insert into actors (name) VALUES ('Edward Norton');
-- inserts the ids from the movies and actors table into the movie_id and actor_id columns
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Fight Club' LIMIT 1), (SELECT id from actors where name = 'Brad Pitt' LIMIT 1));
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Fight Club' LIMIT 1), (SELECT id from actors where name = 'Edward Norton' LIMIT 1));

-- insert a movie into movies table 
insert into movies (title, writer, year) VALUES ('Pulp Fiction', 'Quentin Tarantino', 1994);
-- inserts actors into actors table
insert into actors (name) VALUES ('John Travolta');
insert into actors (name) VALUES ('Uma Thurman');
-- inserts the ids from the movies and actors table into the movie_id and actor_id columns
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Pulp Fiction' LIMIT 1), (SELECT id from actors where name = 'John Travolta' LIMIT 1));
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Pulp Fiction' LIMIT 1), (SELECT id from actors where name = 'Uma Thurman' LIMIT 1));

-- insert a movie into movies table 
insert into movies (title, writer, year) VALUES ('Inglorius Basterds', 'Quentin Tarantino', 2009);
-- inserts actors into actors table
insert into actors (name) VALUES ('Diane Kruger');
insert into actors (name) VALUES ('Eli Roth');
-- inserts the ids from the movies and actors table into the movie_id and actor_id columns
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Inglorius Basterds' LIMIT 1), (SELECT id from actors where name = 'Brad Pitt' LIMIT 1));
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Inglorius Basterds' LIMIT 1), (SELECT id from actors where name = 'Diane Kruger' LIMIT 1));
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Inglorius Basterds' LIMIT 1), (SELECT id from actors where name = 'Eli Roth' LIMIT 1));

-- alter the movies table to include the franchise column
alter table movies add column franchise varchar(50);
-- insert a movie into movies table 
insert into movies (title, writer, year, franchise) VALUES ('The Hobbit: An Unexpected Journey', 'J.R.R. Tolkein', 2012, 'The Hobbit');
-- insert a movie into movies table 
insert into movies (title, writer, year, franchise) VALUES ('The Hobbit: The Desolation of Smaug', 'J.R.R. Tolkein', 2013, 'The Hobbit');

-- alter the movies table to include the synopsis column
alter table movies add column synopsis text;
-- insert a movie into movies table 
insert into movies (title, writer, year, franchise, synopsis) VALUES ('The Hobbit: The Battle of the Five Armies', 'J.R.R. Tolkein', 2012, 'The Hobbit', 'Bilbo and Company are forced to engage in a war against an array of combatants and keep the Lonely Mountain from falling into the hands of a rising darkness.');
-- insert a movie into movies table 
insert into movies (title) VALUES ('Pee Wee Herman''s Big Adventure');
-- insert a movie into movies table 
insert into movies (title) VALUES ('Avatar');

/* Question 3 - Query/Find Documents */
/* 1. get all documents */
-- gets all documents from the movies table
/* select * from movies; */
-- gets all documents from the actors table
/* select * from actors; */
-- gets all documents
select m.*, a.name from movies m join movies_actors ma on m.id = ma.movie_id join actors a on ma.actor_id = a.id;
/* 2. get all documents with `writer` set to "Quentin Tarantino" */
-- gets all movies written by Quentin Tarantino
select * from movies where writer = 'Quentin Tarantino';
-- gets all movies written by Quentin Tarantino and the actors involved
select m.*, a.name from movies m join movies_actors ma on m.id = ma.movie_id join actors a on ma.actor_id = a.id where m.writer = 'Quentin Tarantino';
/* 3. get all documents where `actors` include "Brad Pitt" */
-- gets all the movies that Brad Pitt has been in
select m.*, a.name from movies m join movies_actors ma on m.id = ma.movie_id join actors a on ma.actor_id = a.id where a.name = 'Brad Pitt';
/* 4. get all documents with `franchise` set to "The Hobbit" */
-- gets all the movies in the "The Hobbit" franchise
select * from movies where franchise = 'The Hobbit';
/* 5. get all movies released in the 90s */
-- gets the movies released between the years 1990 and 1999
select * from movies where year between 1990 and 1999;
/* 6. get all movies released before the year 2000 or after 2010 */
-- gets all movies released in the years before 2000 and after 2010
select * from movies where year <= 2000 or year >= 2010;

/* Question 4 - Update Documents */
/* 1. add a synopsis to "The Hobbit: An Unexpected Journey" */
-- adds a synopsis to the movie where the title is "The Hobbit: An Unexpected Journey"
update movies set synopsis = 'A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home - and the gold within it - from the dragon Smaug' where title = 'The Hobbit: An Unexpected Journey';
/* 2. add a synopsis to "The Hobbit: The Desolation of Smaug" */
-- adds a synopsis to the movie where the title is "The Hobbit: The Desolation of Smaug"
update movies set synopsis = 'The dwarves, along with Bilbo Baggins and Gandalf the Grey, continue their quest to reclaim Erebor, their homeland, from Smaug. Bilbo Baggins is in possession of a mysterious and magical ring.' where title = 'The Hobbit: The Desolation of Smaug';
/* 3. add an actor named "Samuel L. Jackson" to the movie "Pulp Fiction" */
-- inserts actors into actors table
insert into actors (name) VALUES ('Samuel L. Jackson');
-- inserts the ids from the movies and actors table into the movie_id and actor_id columns
insert into movies_actors (movie_id, actor_id) VALUES ((SELECT id from movies where title = 'Pulp Fiction' LIMIT 1),(SELECT id from actors WHERE name = 'Samuel L. Jackson' LIMIT 1));

/* Question 5 - Text search Documents */
-- muliple ways to do the search document
/* 1. find all movies that have a synopsis that contains the word "Bilbo" */
-- gets all the movies with bilbo in the synopsis
select * from movies where synopsis like '%Bilbo%';
select * from movies where synopsis ilike '%Bilbo%';
select * from movies where synopsis ~* 'Bilbo';
/* 2. find all movies that have a synopsis that contains the word "Gandalf" */
-- gets all the movies with gandalf in the synopsis
select * from movies where synopsis like '%Gandalf%';
select * from movies where synopsis ilike '%Gandalf%';
select * from movies where synopsis ~* 'Gandalf';
/* 3. find all movies that have a synopsis that contains the word "Bilbo" and not the word "Gandalf" */
-- gets all the movies with biblbo and not gandalf in the synopsis
select * from movies where synopsis like '%Bilbo%' and synopsis not like '%Gandalf%';
select * from movies where synopsis ilike '%Bilbo%' and synopsis not ilike '%Gandalf%';
select * from movies where synopsis ~ 'Bilbo' and synopsis !~* 'Gandalf';
/* 4. find all movies that have a synopsis that contains the word "dwarves" or "hobbit" */
-- gets all movies with dwarves or hobbit in the synopsis
select * from movies where synopsis like '%dwarves%' or synopsis like '%hobbit%';
select * from movies where synopsis ilike '%dwarves%' or synopsis ilike '%hobbit%';
select * from movies where synopsis ~ 'dwarves' or synopsis ~ 'hobbit';
/* 5. find all movies that have a synopsis that contains the word "gold" and "dragon" */
-- gets all movies with gold and dragon in the synopsis
select * from movies where synopsis like '%gold%' and synopsis like '%dragon%';
select * from movies where synopsis ilike '%gold%' and synopsis ilike '%dragon%';
select * from movies where synopsis ~ 'gold' and synopsis ~ 'dragon';

/* Question 6 - Delete Documents */
/* 1. delete the movie "Pee Wee Herman's Big Adventure" */
-- double check it is the one you want to delete 
select * from movies where title = 'Pee Wee Herman''s Big Adventure';
-- delete from table
delete from movies where title = 'Pee Wee Herman''s Big Adventure';
/* 2. delete the movie "Avatar" */
-- double check it is the one you want to delete 
select * from movies where title = 'Avatar';
-- delete from table
delete from movies where title = 'Avatar';

/* Question 7 - Relationships */
-- create a table users with pkey id, a username, first name and last name
create table users (id SERIAL PRIMARY KEY, username text, first_name varchar(50), last_name varchar(50));
-- inserts users into user table
insert into users (username, first_name, last_name) VALUES ('GoodGuyGreg', 'Good Guy', 'Greg');
insert into users (username, first_name, last_name) VALUES ('ScumbagSteve', 'Scumbag', 'Steve');

-- create a table posts with pkey id, a user_id from users table, a title, and a body
create table posts (id SERIAL PRIMARY KEY, user_id int, title varchar(100), body text, FOREIGN KEY (user_id) REFERENCES users(id));
-- create a table comments with pkey id, a user_id from users table, a comment, and a post from posts table
create table comments(id SERIAL PRIMARY KEY, user_id int, comment text, post int, FOREIGN KEY (user_id) REFERENCES users(id), FOREIGN KEY (post) REFERENCES posts(id));

-- inserts into posts table user_id, title and body
insert into posts (user_id, title, body) VALUES ((SELECT id from users where username = 'GoodGuyGreg'), 'Passes out at party', 'Wakes up early and cleans house');
insert into posts (user_id, title, body) VALUES ((SELECT id from users where username = 'GoodGuyGreg'), 'Steals your identity', 'Raises your credit score');
insert into posts (user_id, title, body) VALUES ((SELECT id from users where username = 'GoodGuyGreg'), 'Reports a bug in your code', 'Sends you a Pull Request');
insert into posts (user_id, title, body) VALUES ((SELECT id from users where username = 'ScumbagSteve'), 'Borrows something', 'Sells it');
insert into posts (user_id, title, body) VALUES ((SELECT id from users where username = 'ScumbagSteve'), 'Borrows everything', 'The end');
insert into posts (user_id, title, body) VALUES ((SELECT id from users where username = 'ScumbagSteve'), 'Forks your repo on github', 'Sets it to private');

-- inserts into comments table user_id, comment and post
insert into comments (user_id, comment, post) VALUES ((SELECT id from users where username = 'GoodGuyGreg'), 'Hope you got a good deal!', (SELECT id from posts where title = 'Borrows something'));
insert into comments (user_id, comment, post) VALUES ((SELECT id from users where username = 'GoodGuyGreg'), 'What''s mine is yours!', (SELECT id from posts where title = 'Borrows everything'));
insert into comments (user_id, comment, post) VALUES ((SELECT id from users where username = 'GoodGuyGreg'), 'Don''t violate the licensing agreement!', (SELECT id from posts where title = 'Forks your repo on github'));
insert into comments (user_id, comment, post) VALUES ((SELECT id from users where username = 'ScumbagSteve'), 'It still isn''t clean', (SELECT id from posts where title = 'Passes out at party'));
insert into comments (user_id, comment, post) VALUES ((SELECT id from users where username = 'ScumbagSteve'), 'Denied your PR cause I found a hack', (SELECT id from posts where title = 'Reports a bug in your code'));

/* 1. find all users */
-- gets all the users 
select * from users;
/* 2. find all posts */
-- gets all the posts
 select * from posts;
/* 3. find all posts that was authored by "GoodGuyGreg" */
-- gets all the posts that are authored by a user with a username GoodGuyGreg
select p.*, u.username from posts p join users u on p.user_id = u.id where u.username = 'GoodGuyGreg';
/* 4. find all posts that was authored by "ScumbagSteve" */
-- gets all the posts that are authored by a user with a username ScumbagSteve
select p.*, u.username from posts p join users u on p.user_id = u.id where u.username = 'ScumbagSteve';
/* 5. find all comments */
-- gets all the comments
select * from comments;
/* 6. find all comments that was authored by "GoodGuyGreg" */
-- gets all the comments that are authored by a user with a username GoodGuyGreg
select c.*, u.username from comments c join users u on c.user_id = u.id where username = 'GoodGuyGreg';
/* 7. find all comments that was authored by "ScumbagSteve" */
-- gets all the posts that are authored by a user with a username ScumbagSteve
select c.*, u.username from comments c join users u on c.user_id = u.id where username = 'ScumbagSteve';
/* 8. find all comments belonging to the post "Reports a bug in your code" */
-- gets all comments and username that are related to the post 'Reports a bug in your code'
select c.*, u.username from comments c join users u on c.user_id = u.id join posts p on c.post = p.id where p.title = 'Reports a bug in your code';

















