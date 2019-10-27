//Question 2 - Insert Documents
db.movies.insert({ title: "Fight Club", writer: "Chuck Palahniuk", year: 1999, actors: ["Brad Pitt", "Edward Norton"]})
// inserts a movie record with title Fight Club, writer Chuck Palahniuk, year 1999, actors Brad Pitt and Edward Norton
db.movies.insert({ title: "Pulp Fiction", writer: "Quentin Tarantino", year: 1994, actors: ["John Travolta", "Uma Thurman"]})

db.movies.insert({ title: "Inglorious Basterds", writer: "Quentin Tarantino", year: 2009, actors: ["Brad Pitt", "Diane Kruger", "Eli Roth"]})

db.movies.insert({ title: "The Hobbit: An Unexpected Journey", writer: "J.R.R. Tolkein", year: 2012, franchise: "The Hobbit"})

db.movies.insert({ title: "The Hobbit: The Desolation of Smaug", writer: "J.R.R. Tolkein", year: 2013, franchise: "The Hobbit"})

db.movies.insert({ title: "The Hobbit: The Battle of the Five Armies", writer: "J.R.R. Tolkein", year: 2012, franchise: "The Hobbit", synopsis: "Bilbo and the Company are forced to engage in a war against an array of combatants and keep the Lonely Mountain from falling into the hands of a rising darkness"})

db.movies.insert({ title: "Pee Wee Herman's Big Adventure" })

db.movies.insert({ title: "Avatar" })

//Question 3 - Query / Find Documents
// 1.
db.movies.find()
// 2.
db.movies.find({writer: "Quentin Tarantino"})
// 3.
db.movies.find({actors: "Brad Pitt"})
// 4.
db.movies.find({franchise: "The Hobbit"})
// 5.
db.movies.find({$or :[{year: {$lt: 2000}}, {year: {$gt: 1989}}]})
// 6.
db.movies.find({$or :[{year: {$lt: 2000}}, {year: {$gt: 2010}}]})

//Question 4 - Updated Documents
// 1.
db.movies.update({title: "The Hobbit: An Unexpected Journey"}, {$set: {synopsis: "A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home - and the gold within it - from the dragon Smaug."}})
// 2.
db.movies.update({title: "The Hobbit: The Desolation of Smaug"}, {$set: {synopsis: "The dwarves, along with Bilbo Baggins and Gandalf the Grey, continue their quest to reclaim Erebor, their homeland, from Smaug. Bilbo Baggins is in possession of a mysterious and magical ring."}})
// 3.
db.movies.update({title: "Pulp Fiction"}, {$push: { actors:  "Samuel L. Jackson"}})
// push appends a specified value to an array

// Question 5 - Text Search
// 1.
db.movies.find({synopsis: {$regex: "Bilbo"}})
// 2.
db.movies.find({synopsis: {$regex: "Gandalf"}})
// 3.
db.movies.find({synopsis: {$regex: "Bilbo", $not : {$regex: "Gandalf"}}})
// 4. 
db.movies.find({ $or : [{synopsis: {$regex: "dwarves"}}, {synopsis: {$regex: "hobbit"}}]})
// 5.
db.movies.find({synopsis: {$regex: "gold", $regex: "dragon"}})

// Question 6 - Delete Documents
// 1.
db.movies.find({title : "Pee Wee Herman's Big Adventure"})
db.movies.remove({title: "Pee Wee Herman's Big Adventure")
// 2.
db.movies.find({title : "Avatar"})
db.movies.remove({title : "Avatar"})

// Question 7 - Relationships
// 1.
db.users.insert({username: "GoodGuyGreg", first_name: "Good Guy", last_name: "Greg"})
// 2.
db.users.insert({username: "ScumbagSteve", full_name: [{first: "Scumbag", last: "Steve"}]})
// 3.
db.users.insert({username: "GoodGuyGreg", first_name: "Good Guy", last_name: "Greg"}) 
// 4.
db.users.insert({username: "ScumbagSteve", full_name: [{first: "Scumbag", last: "Steve"}]})
// 5. 
db.posts.insert({username: "GoodGuyGreg", title: "Passes out at party", body: "Wakes up early and cleans house"}) 
// 6. 
db.posts.insert({username: "GoodGuyGreg", title: "Steals your identity", body: "Raises your credit score"}) 
// 7. 
db.posts.insert({username: "GoodGuyGreg", title: "Reports a bug in your code", body: "Sends you a Pull Request"})
// 8.
db.posts.insert({username: "ScumbagSteve", title: "Borrows something", body: "Sells it"})
// 9.
db.posts.insert({username: "ScumbagSteve", title: "Borrows everything", body: "The end"}) 
// 10.
db.posts.insert({username: "ScumbagSteve", title: "Forks your repo on github", body: "Sets to private"}) 
// 11.
db.posts.find({title: "Borrows something"})
// get the object id
db.comments.insert({username: "GoodGuyGreg", comment: "Hope you got a good deal!", post: [ObjectId("5db5ee56c059d040926e09fa")]})
// 12.
db.posts.find({title : "Borrows everything"})
// get the object id
db.comments.insert({username: "GoodGuyGreg", comment: "What's mine is yours!", post: [ObjectId("5db5ee69c059d040926e09fb")]})
// 13.
db.posts.find({title : "Forks your repo on github"})
// get the object id
db.comments.insert({username: "ScumbagSteve", comment: "It still isn't clean", post: [ObjectId("5db5ee89c059d040926e09fc")]})

db.comments.insert({username: "ScumbagSteve", comment: "It still isn't clean", post: posts.findOne({title: "Reports a bug in your code"})[_id]})

// 14.
db.posts.find({title : "Reports a bug in your code"})
// get the object id
db.comments.insert({username: "ScumbagSteve", comment: "Denied your PR cause I found a hack", post: [ObjectId("5db5ee2bc059d040926e09f9")]})

// Question 8 - Querying Related collections
// 1.
db.users.find()
// 2.
db.posts.find()
// 3.
db.posts.find({username: "GoodGuyGreg"})
// 4.
db.posts.find({username: "ScumbagSteve"})
// 5.
db.comments.find()
// 6.
db.comments.find({username: "GoodGuyGreg"})
// 7.
db.comments.find({username: "ScumbagSteve"})
// 8.
db.comments.find({post : db.posts.findOne({title: "Reports a bug in your code"})._id})


