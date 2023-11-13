# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do | n |
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  title = Faker::Book.title
  content = Faker::Book.author
  status = 'waiting'
  priority = 'low'

  user = User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              )
  Task.create!(title: title,
              content: content,
              status: status,
              priority: priority,
              user: user,
              )
end

admin_user = User.create!(name: 'admin03',
                          email: 'admin03@example.com',
                          password: 'password',
                          password_confirmation: 'password',
                          admin: true,
                          )


10.times do | n |
  name = Faker::Book.publisher
  Label.create!(name: name,)
end