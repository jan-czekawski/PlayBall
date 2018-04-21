# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: "harry",
            password: "password",
            email: "harry@email.com",
            activated: true,
            activated_at: 2.hours.ago)

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
    "Basketball City" => "Great place to play basketball. Around 8 full courts. Prices are a little expensive and it is difficult to get to.",
    "Washington Market Park" => "Nice though small little park next to BMCC campus.  It has a bathroom, so if you're out walking, be sure to stop in!",
    "Finsbury Park" => "Great place to walk and go to get away from it all. It's a lovely and big park which is usually buzzing with activity, but usually not too busy either. It's lovely to see people doing exercise or kids playing.",
    "Clissold Leisure Centre" => "The Clissold Leisure Center offers fantastic sport facilities which are greatly subsidized by the council. It has a large swimming pool, a gym, squash and tennis courts, basketball and a full range of exercise classes.",
    "Leopoldpark" => "It's hidden in between many residential buildings and relatively small. There is a huge kids play area area and one or two basketball courts.",
    "Agrykola" => "At Agrykola there are 2 and a half full basketball courts. Unfortunately on one of them surface is pretty worn out and needs to be replaced.",
    "321" => "It's worth mentioning that '321' is placed between School 321 and hers other buildings (not directly on school grounds), so it's open 24/7. Lines were drawn according to new FIBA rules. On the other hand court is lighted poorly and baskets are worn out."
    
  }


    
    
  }

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
