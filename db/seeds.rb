# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

MAX_CUSTOMERS = 1000
MAX_DELIVERERS = 30

letters = "abcdefghijklmnopqrstuvwxyz"
numbers = "0123456789"

p "Creating Customers"

MAX_CUSTOMERS.times do
  r = Random.new

  firstname = ""
  lastname = ""
  preposition = ""
  email = ""

  r.rand(2..15).times do
    firstname = firstname + letters[r.rand(26)]
  end

  r.rand(3..16).times do
    lastname = lastname + letters[r.rand(26)]
  end

  r.rand(2..4).times do
    preposition = preposition + letters[r.rand(26)]
  end

  r.rand(5).times do
    email = email + letters[r.rand(26)]
  end

  email = email + "@random.org"

  Customer.create(firstname: firstname, lastname: lastname, preposition: preposition, email: email)

end

p "Customers Created"

p "Creating Addresses"

Customer.all.each do |customer|
  r = Random.new

  zipcode = ""
  housenumber = 0
  street = ""
  city = ""
  annex = ""
  x = 0
  y = 0

  4.times do
    zipcode = zipcode + numbers[r.rand(10)]
  end

  2.times do
    zipcode = zipcode + letters[r.rand(26)]
  end

  r.rand(5..15).times do
    street = street + letters[r.rand(26)]
  end

  r.rand(4..9).times do
    city = city + letters[r.rand(26)]
  end

  housenumber = r.rand(255)

  r.rand(2).times do
    annex = annex + letters[r.rand(26)]
  end

  x = r.rand(1000)
  y = r.rand(1000)

  customer.address = Address.create(zipcode: zipcode, housenumber: housenumber,
                                    street: street, city: city, annex: annex, x: x, y: y)
end

p "Addresses Created"

p "Creating Products"

300.times do
  r = Random

  name = ""
  description = ""
  amount = 0
  price = 0.00

  r.rand(6..20).times do
    name = name + letters[r.rand(26)]
  end

  r.rand(10..200).times do
    description = description + letters[r.rand(26)]
  end

  amount = r.rand(1..100)
  price = r.rand(1.00..400.00).round(2)

  Product.create(name: name, description: description, amount: amount, price: price)

end

p "Products Created"

p "Creating Orders"

Customer.all.each do |customer|
  r = Random.new

  r.rand(1..10).times do
    statusArray = ["Niet verzonden", "Verzonden"]

    customer.orders.create(status: statusArray[r.rand(0..1)])
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
    amount = r.rand(1..10)

    order.order_lines.create(product: product, amount: amount)

  end
end

p "OrderLines Created"

p "--------"
p OrderLine.all