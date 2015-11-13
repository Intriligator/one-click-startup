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

emails = [
  "at@pwd.com",
  "jp@pwd.com",
  "di@pwd.com"
]

emails.each do |email|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: email,
    password: "123",
    admin: false,
    location: "Everywhere",
    occupation: Faker::Company.profession,
    bio: Faker::Hacker.say_something_smart
  )
end

5.times do |x|
  product = Product.create(
    name: Faker::Company.name,
    tagline: Faker::Company.catch_phrase,
    mission: Faker::Company.catch_phrase,
    website: "http://www.google.com",
    value_prop: Faker::Company.buzzword,
    description: "This is a description",
    catagory_id: business.id,
    user_id: rand(1..User.all.count),
    approved: true,
    paid: false,
    expiration: DateTime.now + 7.days
  )

  image = Image.create(
    url: "http://www.connexionsweb.com/wp-content/uploads/2015/03/businessLogo.png",
    product_id: product.id
  )
end
