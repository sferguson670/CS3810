//open fresh database name books
use books

//create a new collection also named books
db.createCollection("books")

//insert some documents into books (at least 5)
db.books.insert({
	isbn : "978-0-399-16706-5",
	title : "Big Little Lies",
	author : "Liane Moriarty",
	date : {
		year : 2014,
		month : "July"
	},
	pages : 458
})

db.books.insert({
	isbn : "978-0307341570",
	title : "Dark Places",
	author : "Gillian Flynn",
	date : {
		year : 2009,
		month : "May"
	},
	pages : 349
})

db.books.insert({
	isbn : "978-0-385-53697-4",
	title : "Crazy Rich Asians",
	author : "Kevin Kwan",
	date : {
		year : 2013,
		month : "May"
	},
	pages : 349
})

db.books.insert({
	isbn : "978-0-385-53908-1",
	title : "Crazy Rich Girlfriend",
	author : "Kevin Kwan",
	date : {
		year : 2015,
		month : "June"
	},
	pages : 496
})

db.books.insert({
	isbn : "978-0-385-54232-6",
	title : "Rich People Problems",
	author : "Kevin Kwan",
	date : {
		year : 2017,
		month : "May"
	},
	pages : 582
})

//list all books
db.books.find()

//list all book titles
db.books.find({}, {title: true})

//list all books written by X, where X is an author that you know is listed in your collection
db.books.find({author: 'Kevin Kwan'})

//list all books published in Y, where Y is a year
db.books.find({"date.year": 2013 })

//list all books that have more than 100 pages, but less than 500 pages
db.books.find({pages: {$gt: 100, $lt: 500}})