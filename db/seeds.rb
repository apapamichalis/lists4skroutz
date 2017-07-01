# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#user = CreateAdminService.new.call
#puts 'CREATED ADMIN USER: ' << user.email

# Create 50 unique users. Each user has 50 lists
50.times do 
  name      =  Faker::Name.unique.name
  email     =  Faker::Internet.free_email(name)
  password  =  'password'
  user = User.create(name: name, email: email, password: password)
  50.times do
    list_name     = Faker::Commerce.unique.department
    creation_time = Faker::Time.backward(20)
    status        = Faker::Boolean.boolean
    user.lists.create(name: list_name, created_at:creation_time, active: status)
  end
end