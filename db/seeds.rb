# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

	Bug.destroy_all
	Project.destroy_all
	User.destroy_all
	Role.destroy_all

	roles = []
	manager = Role.create(name: 'Manager')
	developer= Role.create(name: 'Developer')
	qa= Role.create(name: 'QA')


	users = User.create!([{
	  name: "Hira",
	  email: "h@gmail.com",
	  password: 123123,
	  role: manager
	},
	{
	  name: "Shahid",
	  email: "d@gmail.com",
	  password: 123123,
	  role: developer
	},
	{
	  name: "Maryam",
	  email: "qa@gmail.com",
	  password: 123123,
	  role: qa
	}])

	p "Created #{User.count} users"

	project= Project.create(title: 'First Project', description: 'This is my first project', manager: users[0])
	bug = Bug.create(title: 'Bug#1',description: 'First bug of first project', types: 'Bug',status:'New',project: project, creator: users[2])

