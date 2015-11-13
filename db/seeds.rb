# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create(
  first_name: "Jerry",
  last_name: "Patterson",
  email: "info@peekskillwebdesign.com",
  password: "123",
  admin: true,
  location: "New York",
  occupation: "Ninja",
  bio: "My name is Jerry, and I like to party"
)

business = Catagory.create(
  name: "Business"
)