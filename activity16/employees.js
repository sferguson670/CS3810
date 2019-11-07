//create database
use employees

//create collection
db.createCollection("employees")

//insert data
db.employees.insertMany([
  {
      name: 'John', 
      department: 'sales', 
      projects: ['bluffee', 'jomoorjs', 'auton' ]
  },

  {
      name: 'Mary', 
      department: 'sales', 
      projects: ['codete', 'auton' ]
  },

  {
      name: 'Peter', 
      department: 'hr', 
      projects: ['auton', 'zoomblr', 'instory', 'bluffee' ]
  },

  {
      name: 'Janet', 
      department: 'marketing', 
  },

  {
      name: 'Sunny', 
      department: 'marketing', 
  },

  {
      name: 'Winter', 
      department: 'marketing', 
      projects: [ 'bluffee', 'auton' ]
  },

  {
      name: 'Fall', 
      department: 'marketing', 
      projects: [ 'bluffee', 'scrosnes' ]
  },

  {
      name: 'Summer', 
      department: 'marketing', 
  },

  {
      name: 'Sam', 
      department: 'marketing', 
      projects: ['scrosnes' ]
  },

  {
      name: 'Maria', 
      department: 'finances', 
      projects: ['conix', 'filemenup', 'scrosnes', 'specima', 'bluffee' ]
  }])

// number of employees per department
// hint: use the $group and $sum pipeline operators
db.employees.aggregate( 
[
	{
		$group:
			{	
				_id: '$department',
				total: { $sum:1 }
			}
		}
	]
)
  
// same but in alphabetical order
// hint: same as the previous query but ending with a $sort pipeline stage
db.employees.aggregate( 
[
	{
		$group:
			{	
				_id: '$department',
				total: { $sum:1 }
			}
		},
		{
			$sort:
			{
				department : 1
			}
		}
	]
)

// same but in descendant order by totals
db.employees.aggregate( 
[
	{
		$group:
			{	
				_id: '$department',
				total: { $sum:1 }
			}
		},
		{
			$sort:
			{
				total: -1
			}
		}
	]
)
  
// alphabetic list of all project names
// hint: first use $unwind to extract all projects from the array with the same name; then group by projects and use $sort to have the list in alphabetical order
db.employees.aggregate(
	[
		{
			$unwind: '$projects'
		},
		{
			$group:
			{
				_id: '$projects'
			}
		},
		{
			$sort:
			{
				_id: 1
			}
		}
	]
)

// number of employees per project (alphabetical order too)
// hint: same as the previous one but using $sum to count the number of employees
db.employees.aggregate(
	[
		{
			$unwind: '$projects'
		},
		{
			$group:
			{
				_id: '$projects',
				total: { $sum: 1}
			}
		},
		{
			$sort:
			{
				_id: 1
			}
		}
	]
)

// of the employees that work on projects, what it is the average number of projects that they work on
// hint: use $match to filter the employees that work on projects; then use $size to project the number of projects per employee; finally, compute the average of projects that each employee works on
db.employees.aggregate(
	[
		{
			$match: 
			{
				projects: { $exists: true }
			}
		},
		{
			$project:
			{
				num_project: { $size: '$projects'}
			}
		},
		{
			$group:
			{
				_id: null,
				avg: { $avg: '$num_project' }
			}
		}
	]
)