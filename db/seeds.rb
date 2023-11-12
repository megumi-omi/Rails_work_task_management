# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'user_sample01',
             email: 'user_sample01@example.com',
             password: 'password',
             password_confirmation: 'password',
            )

admin_user = User.create!(name: 'admin01',
                          email: 'admin01@example.com',
                          password: 'password',
                          password_confirmation: 'password',
                          admin: true,
                          )


5.times do | n |
  name = Faker::Types.rb_string
  Label.create!(name: name,)
end