# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 40.times do
#   user = Faker::Name.unique.first_name
#   email = user + "@example.com"
#   User.create!(:password => "password", :username => user, :email => email, :activated => true, :activated_at => 2.hours.ago)
# end

20.times do
  name = Faker::Ancient.hero
  description = Faker::Hipster.sentences(3).join(" ")
  longitude = Faker::Address.longitude
  latitude = Faker::Address.latitude
  user = User.all.sample
  Court.create(name: name,
               description: description,
               longitude: longitude,
               latitude: latitude,
               user: user)
end

# User.all.each do |user|
#   user.username = user.username.capitalize
#   user.save
# end

# Court.all.each do |court|
#   10.times do
#     courtID = court.id
#     userID = User.all.sample.id
#     content = Faker::Hipster.paragraph
#     Comment.create!(:user_id => userID, :court_id => courtID, :content => content)
#   end
# end
