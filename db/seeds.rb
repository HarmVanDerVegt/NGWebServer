# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

MAX_CUSTOMERS = 500
MAX_DELIVERERS = 30

letters = "abcdefghijklmnopqrstuvwxyz"
numbers = "0123456789"
prepositions = ["van", "van der", "van den", "van de", "de", "", ""]

p "Creating Customers"

MAX_DELIVERERS.times do
  r = Random.new

  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name
  preposition = prepositions[r.rand(7)]

  Deliverer.create(firstname: firstname, lastname: lastname, preposition: preposition)
end

MAX_CUSTOMERS.times do
  r = Random.new


  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name
  preposition = prepositions[r.rand(7)]
  email = Faker::Internet.unique.email

  Customer.create(firstname: firstname, lastname: lastname, preposition: preposition, email: email)

end

p "Customers Created"

p "Creating Addresses"

Customer.all.each do |customer|
  r = Random.new

  zipcode = ""
  housenumber = 0
  street = Faker::Address.street_name
  city = Faker::Address.city
  annex = ""
  x = 0
  y = 0

  4.times do
    zipcode = zipcode + numbers[r.rand(10)]
  end

  2.times do
    zipcode = zipcode + letters[r.rand(26)]
  end

  housenumber = r.rand(255)

  r.rand(1).times do
    annex = annex + letters[r.rand(26)]
  end

  x = r.rand(599)
  y = r.rand(599)

  customer.address = Address.create(zipcode: zipcode, housenumber: housenumber,
                                    street: street, city: city, annex: annex, x: x, y: y)
end

p "Addresses Created"

p "Creating Products"

300.times do
  r = Random

  name = Faker::Appliance.equipment
  description = Faker::Music.album
  amount = 0
  price = 0.00

  amount = r.rand(1..100)
  price = r.rand(1.00..400.00).round(2)

  Product.create(name: name, description: description, amount: amount, price: price)

end

p "Products Created"

p "Creating Orders"

Customer.all.each do |customer|
  r = Random.new

  r.rand(1..8).times do
    statusArray = ["Niet verzonden", "Verzonden", "Bezorgd"]

    customer.orders.create(status: statusArray[r.rand(0..2)])
  end
end

p "-------"
p Order.all

p "Orders Created"

p "Creating OrderLines"

Order.all.each do |order|
  r = Random.new

  r.rand(1..4).times do
    product = Product.offset(rand(Product.count)).first
    amount = r.rand(1..3)

    order.order_lines.create(product: product, amount: amount, returned: false )

  end
end

p "OrderLines Created"

p "--------"
p OrderLine.all