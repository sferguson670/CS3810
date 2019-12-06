// Sarah Ferguson
// Homework 10

// d) all company names and their number of employees; do not show companies with ‘number_of_employees’ equal to null or zero
db.companies.find(
{
	number_of_employees: 
	{ 
		$ne: null,
		$gt: 0 
	}
   },
   {
	   name: 1,
	    number_of_employees:1
   }
)

// e) same as previous but only show the top 10 companies in number of employees; hint: use $sort and $limit.
db.companies.aggregate(
 [
 	{
		$project: 
		{
			name: 1,
			number_of_employees: 1
		}
	},
    {
		$match:
		{
			number_of_employees: 
			{ 
				$ne: null,
				$gt: 0 
			}
		}
	},
    {
		$sort: 
		{ 
			number_of_employees : -1 
		}
	},
    {
		$limit:10
	}
 ]
)

// k) companies by category code, i.e., for each category code, a list of company names in the same category. Hints: the field we are interested in is named ‘category_code’; use the $push operator (slide #12 of lesson 19 has an example).
db.companies.aggregate(
{
	$group:
	  {
		  _id:
		  {
			'category':'$category_code'
		  },
		  'company name':
		  {
			  $push:'$name'
		  }
	  }
  }
)