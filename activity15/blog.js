{
    "author" : "Sam Mai Tai",
    "created_at" : ISODate("2017-11-03T00:00:00Z"),
    "content" : "The pessimist sees difficulty in every opportunity. The optimist sees the opportunity in every difficulty.",
    "likes" : 12,
    "tags" : [
        "pessimist",
        "optimist"
    ]
}

{
    "author" : "Sam Mai Tai",
    "created_at" : ISODate("2017-11-03T09:30:00Z"),
    "content" : "Age is a case of mind over matter. If you don't mind, it don't matter.",
    "likes" : 10,
    "tags" : [
        "age",
        "optimist"
    ]
}

{
    "author" : "Sam Mai Tai",
    "created_at" : ISODate("2017-11-04T00:00:00Z"),
    "content" : "Failure will never overtake me if my determination to succeed is strong enough.",
    "likes" : 1,
    "tags" : [
        "optimist"
    ]
}

{
    "author" : "Morbid Mojito",
    "created_at" : ISODate("2017-11-04T00:00:00Z"),
    "content" : "Only I can change my life. No one can do it for me.",
    "tags" : [
        "life"
    ]
}

{
    "author" : "Morbid Mojito",
    "created_at" : ISODate("2017-11-07T00:00:00Z"),
    "content" : "Smile in the mirror. Do that every morning and you'll start to see a big difference in your life",
    "likes" : 1,
    "tags" : [
        "life",
        "optimist"
    ]
}

//list all posts that has the word 'you' in its content
//hint: use the $regex query operator
db.posts.find({
	content:
	{
		$regex: /you/
	}
});

db.posts.find({
	content: /you/
});

//list all posts of an author whose name ends with the leter 'o' or 'O'
//hint: use the $regex query operator
db.posts.find({
	author: /.*[oO]/
});

db.posts.find({
	author: /.*O/i
});

//list all posts that have the tag 'optimist'
//hint: search the documentation for how to "query an array"
db.posts.find({ tags: "optimist"});

//list all posts that have the tags 'optimist' and 'life'
//hint: you might want to try the $all query operator or just use the $and query operator
db.posts.find({tags: {$all: ['optimist', 'life']}});

//list all posts that have the tags 'optimist' or 'life'
//hint: use the $or query operator
db.posts.find({ 
	$or: [
    	{ tags: 'optimist' },
    	{ tags: 'life' }
	]
});

// list all posts that do not have the tag 'age'
// hint: use the $nin query operator
db.posts.find({
    tags: {
        $nin: [ 'age' ]
    }
}).pretty()

// list all posts that only have one tag
// hint: use the $size query operator
db.posts.find({
	tags: {
		$size: 1
	}
}).pretty();