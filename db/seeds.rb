# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1000.times do |x|
  firstName = Faker::Name.first_name
  lastName = Faker::Name.last_name
  title = Faker::Name.prefix
  phone = Faker::PhoneNumber.cell_phone
  email = Faker::Internet.safe_email(name: "#{firstName}#{x}")
  name = "#{lastName}, #{firstName}"
  status = x%4>0 ? true : false
  User.create!(name: name,
               email: email,
               title: title,
               phone: phone,
               status: status,
               created_at: Time.zone.now,
               updated_at: Time.zone.now)
end
