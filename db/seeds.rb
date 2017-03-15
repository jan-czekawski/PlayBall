# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

40.times do
  user = Faker::Name.unique.first_name
  email = user + "@example.com"
  User.create!(:password => "password", :username => user, :email => email, :activated => true, :activated_at => 2.hours.ago)
end

# User.all.each do |user|
#   user.username = user.username.capitalize
#   user.save
# end

# Court.all.each do |court|
#   10.times do
#     courtID = court.id
#     arr = (1..48).to_a
#     userID = arr.sample
#     content = Faker::Hipster.paragraph
#     Comment.create!(:user_id => userID, :court_id => courtID, :content => content)
#   end
# end
