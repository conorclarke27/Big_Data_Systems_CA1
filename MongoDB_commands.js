// Question 2 - Insert Documents
// inserts a new movie object into the movies collection
db.movies.insert({ title: "Fight Club", writer: "Chuck Palahniuk", year: 1999, actors: ["Brad Pitt", "Edward Norton"]})
// inserts a new movie object into the movies collection
db.movies.insert({ title: "Pulp Fiction", writer: "Quentin Tarantino", year: 1994, actors: ["John Travolta", "Uma Thurman"]})
// inserts a new movie object into the movies collection
db.movies.insert({ title: "Inglorious Basterds", writer: "Quentin Tarantino", year: 2009, actors: ["Brad Pitt", "Diane Kruger", "Eli Roth"]})
// inserts a new movie object into the cmovies ollection
db.movies.insert({ title: "The Hobbit: An Unexpected Journey", writer: "J.R.R. Tolkein", year: 2012, franchise: "The Hobbit"})
// inserts a new movie object into the movies collection
db.movies.insert({ title: "The Hobbit: The Desolation of Smaug", writer: "J.R.R. Tolkein", year: 2013, franchise: "The Hobbit"})
// inserts a new movie object into the movies collection
db.movies.insert({ title: "The Hobbit: The Battle of the Five Armies", writer: "J.R.R. Tolkein", year: 2012, franchise: "The Hobbit", synopsis: "Bilbo and the Company are forced to engage in a war against an array of combatants and keep the Lonely Mountain from falling into the hands of a rising darkness"})
// inserts a new movie object into the movies collection
db.movies.insert({ title: "Pee Wee Herman's Big Adventure" })
// inserts a new movie object into the movies collection
db.movies.insert({ title: "Avatar" })

//Question 3 - Query / Find Documents
// 1. get all documents 
//
db.movies.find()
// 2. get all documents with `writer` set to "Quentin Tarantino" 
db.movies.find({writer: "Quentin Tarantino"})
// 3. get all documents where `actors` include "Brad Pitt" 
db.movies.find({actors: "Brad Pitt"})
// 4. get all documents with `franchise` set to "The Hobbit" 
db.movies.find({franchise: "The Hobbit"})
// 5. get all movies released in the 90s 
db.movies.find({$or :[{year: {$lt: 2000, $gt: 1989}}]})
// 6. get all movies released before the year 2000 or after 2010
db.movies.find({$or :[{year: {$lt: 2000}}, {year: {$gt: 2010}}]})

//Question 4 - Updated Documents
// 1. add a synopsis to "The Hobbit: An Unexpected Journey" 
db.movies.update({title: "The Hobbit: An Unexpected Journey"}, {$set: {synopsis: "A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home - and the gold within it - from the dragon Smaug."}})
// 2. add a synopsis to "The Hobbit: The Desolation of Smaug" 
db.movies.update({title: "The Hobbit: The Desolation of Smaug"}, {$set: {synopsis: "The dwarves, along with Bilbo Baggins and Gandalf the Grey, continue their quest to reclaim Erebor, their homeland, from Smaug. Bilbo Baggins is in possession of a mysterious and magical ring."}})
// 3. add an actor named "Samuel L. Jackson" to the movie "Pulp Fiction"
db.movies.update({title: "Pulp Fiction"}, {$push: { actors:  "Samuel L. Jackson"}})
// push appends a specified value to an array

// Question 5 - Text Search
// 1. find all movies that have a synopsis that contains the word "Bilbo" 
db.movies.find({synopsis: {$regex: "Bilbo"}})
// 2. find all movies that have a synopsis that contains the word "Gandalf" 
db.movies.find({synopsis: {$regex: "Gandalf"}})
// 3. find all movies that have a synopsis that contains the word "Bilbo" and not the word "Gandalf" 
db.movies.find({synopsis: {$regex: "Bilbo", $not : {$regex: "Gandalf"}}})
// 4. find all movies that have a synopsis that contains the word "dwarves" or "hobbit" 
db.movies.find({ $or : [{synopsis: {$regex: "dwarves"}}, {synopsis: {$regex: "hobbit"}}]})
// 5. find all movies that have a synopsis that contains the word "gold" and "dragon"
db.movies.find({synopsis: {$regex: "gold", $regex: "dragon"}})

// Question 6 - Delete Documents
// 1. delete the movie "Pee Wee Herman's Big Adventure"
db.movies.find({title : "Pee Wee Herman's Big Adventure"})
db.movies.remove({title: "Pee Wee Herman's Big Adventure")
// 2. delete the movie "Avatar"
db.movies.find({title : "Avatar"})
db.movies.remove({title : "Avatar"})

// Question 7 - Relationships
// inserts a new user object into the users collection
db.users.insert({username: "GoodGuyGreg", first_name: "Good Guy", last_name: "Greg"})
// inserts a new user object into the users collection
db.users.insert({username: "ScumbagSteve", full_name: [{first: "Scumbag", last: "Steve"}]})
// inserts a new post object into the posts collection
db.posts.insert({username: "GoodGuyGreg", title: "Passes out at party", body: "Wakes up early and cleans house"}) 
// inserts a new post object into the posts collection
db.posts.insert({username: "GoodGuyGreg", title: "Steals your identity", body: "Raises your credit score"}) 
// inserts a new post object into the posts collection
db.posts.insert({username: "GoodGuyGreg", title: "Reports a bug in your code", body: "Sends you a Pull Request"})
// inserts a new post object into the posts collection
db.posts.insert({username: "ScumbagSteve", title: "Borrows something", body: "Sells it"})
// inserts a new post object into the posts collection
db.posts.insert({username: "ScumbagSteve", title: "Borrows everything", body: "The end"}) 
// inserts a new post object into the posts collection
db.posts.insert({username: "ScumbagSteve", title: "Forks your repo on github", body: "Sets to private"}) 

// get the object id and then copy it in
// db.posts.find({title: "Borrows something"})
// db.comments.insert({username: "GoodGuyGreg", comment: "Hope you got a good deal!", post: [ObjectId("5db5ee56c059d040926e09fa")]})
// OR find the post object id by using findOne and getting the id from it
db.comments.insert({username: "GoodGuyGreg", comment: "Hope you got a good deal!", post: posts.findOne({title: "Borrows something"})[_id]})

// get the object id and then copy it in
// db.posts.find({title : "Borrows everything"})
// db.comments.insert({username: "GoodGuyGreg", comment: "What's mine is yours!", post: [ObjectId("5db5ee69c059d040926e09fb")]})
// OR find the post object id by using findOne and getting the id from it
db.comments.insert({username: "GoodGuyGreg", comment: "What's mine is yours", post: posts.findOne({title: "Borrows everything"})[_id]})

// get the object id and then copy it in
// db.posts.find({title : "Forks your repo on github"})
// db.comments.insert({username: "GoodGuyGreg", comment: "Don't violate the licensing agreement!", post: [ObjectId("5db5ee89c059d040926e09fc")]})
// OR find the post object id by using findOne and getting the id from it
db.comments.insert({username: "GoodGuyGreg", comment: "Don't violate the licensing agreement!", post: posts.findOne({title: "Reports a bug in your code"})[_id]})

// get the object id and then copy it in
// db.posts.find({title : "Passes out at party"})
// db.comments.insert({username: "ScumbagSteve", comment: "It still isn't clean", post: [ObjectId("5db5eda4c059d040926e09f7")]})
// OR find the post object id by using findOne and getting the id from it
db.comments.insert({username: "ScumbagSteve", comment: "It still isn't clean", post: posts.findOne({title: "Passes out at party"})[_id]})

// get the object id and then copy it in
//db.posts.find({title : "Reports a bug in your code"})
//db.comments.insert({username: "ScumbagSteve", comment: "Denied your PR cause I found a hack", post: [ObjectId("5db5ee2bc059d040926e09f9")]})
// OR find the post object id by using findOne and getting the id from it
db.comments.insert({username: "ScumbagSteve", comment: "Denied your PR cause I found a hack", post: posts.findOne({title: "Reports a bug in your code"})[_id]})

// Question 8 - Querying Related collections
// 1. find all users 
// finds all users in collection
db.users.find()
// 2. find all posts
// finds all posts in collection 
db.posts.find()
// 3. find all posts that was authored by "GoodGuyGreg"
// finds all the posts that were authored by GoodGuyGreg 
db.posts.find({username: "GoodGuyGreg"})
// 4. find all posts that was authored by "ScumbagSteve"
// finds all the posts that were authored by ScumbagSteve  
db.posts.find({username: "ScumbagSteve"})
// 5. find all comments
// find all comments in collection 
db.comments.find()
// 6. find all comments that was authored by "GoodGuyGreg" 
// // finds all the comments that were authored by GoodGuyGreg 
db.comments.find({username: "GoodGuyGreg"})
// 7. find all comments that was authored by "ScumbagSteve"
// finds all the comments that were authored by ScumbagSteve 
db.comments.find({username: "ScumbagSteve"})
// 8. find all comments belonging to the post "Reports a bug in your code"
// finds all comments that belong to the post Reports a bug in your code
db.comments.find({post : db.posts.findOne({title: "Reports a bug in your code"})._id})


