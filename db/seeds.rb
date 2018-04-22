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
  User.create(password: "password",
              username: user,
              email: email,
              activated: true, 
              activated_at: 2.hours.ago)
end

COURTS = 
  { 
    "Basketball City" => [User.all.sample, -73.993718, 40.767124, "Great place to play basketball. Around 8 full courts. Prices are a little expensive and it is difficult to get to."],
    "Washington Market Park" => [User.all.sample, -74.011467, 40.716974,"Nice though small little park next to BMCC campus.  It has a bathroom, so if you're out walking, be sure to stop in!"],
    "Finsbury Park" => [User.all.sample, -0.107435, 51.563296, "Great place to walk and go to get away from it all. It's a lovely and big park which is usually buzzing with activity, but usually not too busy either. It's lovely to see people doing exercise or kids playing."],
    "Clissold Leisure Centre" => [User.all.sample,-0.084903, 51.558378, "The Clissold Leisure Center offers fantastic sport facilities which are greatly subsidized by the council. It has a large swimming pool, a gym, squash and tennis courts, basketball and a full range of exercise classes."],
    "Leopoldpark" => [User.all.sample, 4.380238, 50.838746, "It's hidden in between many residential buildings and relatively small. There is a huge kids play area area and one or two basketball courts."],
    "Agrykola" => [User.all.sample, 21.031989, 52.217862, "At Agrykola there are 2 and a half full basketball courts. Unfortunately on one of them surface is pretty worn out and needs to be replaced."],
    "321" => [User.all.sample, 20.919935, 52.251693, "It's worth mentioning that '321' is placed between School 321 and hers other buildings (not directly on school grounds), so it's open 24/7. Lines were drawn according to new FIBA rules. On the other hand court is lighted poorly and baskets are worn out."],
    "Park Kasprowicza" => [User.all.sample, 16.891484, 52.395353, "This is small little park in my neighborhood. Often used by many near by health conscious people to sweat out jogging in the  morning or evening."],
    "Buczka" => [User.all.sample, 16.886764, 52.364079,  "There was always someone playing there (even at night). Guys would go out to play after watching Bulls win their games in the finals. And no one bothered that surface was just a regular asphalt."]
  }

COURTS.each do |name, attrs|
  Court.create(name: name,
               user: attrs[0],
               longitude: attrs[1],
               latitude: attrs[2],
               description: attrs[3],
               created_at: rand(1.year.ago..2.days.ago))
end

# 20.times do
#   name = Faker::Ancient.hero
#   description = Faker::Hipster.sentences(3).join(" ")
#   longitude = Faker::Address.longitude
#   latitude = Faker::Address.latitude
#   user = User.all.sample
#   Court.create(name: name,
#               description: description,
#               longitude: longitude,
#               latitude: latitude,
#               user: user)
# end

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
