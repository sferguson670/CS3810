//create database
use companies

//create collection
db.createCollection("companies")

// a) number of companies in the collection
// answer: 18801
db.companies.count()

// b) number of employees at Google
// answer: 28000
dob.companies.find({name: 'Google'}, {'number_of_employees': 1})

// c) number of companies that have information about their number of employees, (be careful, some companies have number_of_employees set to null), hint: create an index first, otherwise the query takes too long to run
// answer: 8889
db.companies.createIndex({number_of_employees: 1})
db.companies.find(
	{
		'number_of_employees': { $exists: true },
		'number_of_employees': { $ne: null }
	}
).count()

// d) all company names and their number of employees; do not show companies with 'number_of_employees' equal to null or zero

// e) same as previous, but only show the top 10 companies in number of employees, hint: use $sort and $limit

// f) all company names and their products, *just do it as practice

// g) same as previous, but only show each product's name (instead of the whole product's document), *just do it as practice

// h) all company names and their total number of products
db.companies.aggregate(
	[
		{
			$project: {
				name: true,
				total: { $size: '$products' }
			}
		}
	]
)

// i) names of companies whose phone begin with 610
db.companies.aggregate(
	[
		{
			$project: {
				name: true,
				phone_number: true
			}
		},
		{
			$match:
			{
				'phone_number': /^610.*/
			}
		}
	]
)

// j) name of companies that have email (other than null or blank), but they do not end in '.com'
db.companies.aggregate(
	[
		{
			$match:
			{
				$and:
				[
					{'email_address': { $exists: true }},
		            {'email_address': { $ne: null }},
		            {'email_address': { $ne: '' }},
		            {'email_address': { $ne: ' ' }},
		            {'email_address': { $not: /.com$/ }}
					
				]
			}
		},
		{
			$project:
			{
				'name': true,
				'email_address': true
			}
		}
	]
)

// k) companies by category code (i.e. for each category code, a list of company names in the same categeory), hints: the fields we are interested in is named 'category_code'; use the $push operator (slide #12 of lesson 19 has an example)

// l) companies names that have offices overseas, (i.e. an office location different than 'USA'), note: this is an interesting one because field offices is an array of doccuments (the country_code info is in those documents). I suggest using $unwind and then searching for offices.country_code different than 'USA'. Then group by name to avoid repeating the name fo the company. (just do it as a challenge)

// m) the number of officies per company ordered by the numbers in descending order
db.companies.aggregate(
	{
		$project:
		{
			name: true,
			offices: { $size: '$officies' }
		}
	}
)

// n) the number of times the word "internet" (ignoring case) was used by each companie in their overview texts, note: also challenging because you have to break the strin ginto words and then unwind the string so you can apply gorup on company name and the word (just do it as a challenge)

// o) list of all companies that have a Twitter account (twitter_username) that is not null or blank; project only the name of the company and its username; sort by Twitter user_name
db.companies.aggregate(
	[
		{
			$match:
			{
				$and:
				[
					{'twitter_username': { $exists: true}},
					{'twitter_username': { $ne: null }},
					{'twitter_username': { $ne: '' }},
					{'twitter_username': { $ne: ' ' }}
				]
			}
		},
		{
			$project:
			{
				'name': true,
				'twitter_username': true
			}
		}
	]
)