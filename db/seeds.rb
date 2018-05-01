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

COMMENTS = 
  [
    "Basketball courts close at around 11:15pm", "Check it out on a weekend, (the path there will be packed) lots of basketball courts and the free aerobics classes are good to watch for a laugh.", "A child friendly park with playground and basketball court, blocks away from the skyscrapers. A peaceful green spot, with scyscrapers looming in the background",
    "Watch out for presents on the basketball court, in the morning it's an illegal dog run.", "Halfcourt basketball court is fun!", "Commonly known as “The Cage,” this basketball court hosts some of the most competitive amateur tournaments in the city.", "AM Boot Camp on the basketball courts", "Where you could find the whole neighborhood hanging out.", "Great energy level! So many options and great facilities.",
    "Safe, family-friendly playground, kept busy by nearby grade and middle schools.", "This court has seen more All Stars (playground legends & professionals) than any arena in the country. Arrive early or you'll regret it!", "A wide variety of NBA, college & streetball players have added to the historic legacy of the park.", "Streetball has its roots there and elements of this style are part of Carmelo Anthony’s arsenal.",
    "amazing space. great basketball, spectacular events. A+", "Great event space, huge white walled bball court. Went for a nba live 16 preview party. Its a court for prof players and some kids league stuff. Not open to public", "It's really nice! The basketball court is big. And the view from here is impeccable. Highly recommend", "Great facility kept in excellent shape. Staff is accommodating and professional.", "Lots of basketball courts. I practice there with my team often and we really enjoy it.",
    "What a spot. On a warm evening the breeze coming off the river is perfect as you gaze at the cacophony of lights on the other side.", "Clean, safe, lots of kids, lots of dogs, lots of food/desert vendors. Great place to spend the day.", "Absolutely breath-taking view, trendy, family-oriented!  Love the place", "The playground is clean and beautiful with a great view of the city.",
    "The best playground in town. Many good players and a basket at a high level", "It's got your standard basketball hoops, plus a decent selection of outdoor workout equipment where young guys like to impress their ladies (and check out each other's pecs).", "What to write, great basketball court...", "Free pitch. The artificial surface.", "I grew up in the neighborhood where this wonderful park is located.  This park sure brings back the happier memories in my childhood.",
    "I love the fact that it's mostly shaded, making it an ideal gateway in summertime for the little ones.", "It is always buzzing with kids from the nearby school", "I had NO IDEA this place existed. It's funny the things you discover when you decide against renting a car for a trip", "This is a cool basketball court to come and ball up at.  Its hidden and kept up by the city so I appreciate it.  Definitely lots of parking, would love to find some other people that would want to set up games here.",
    "I absolutely love this park it's a huge gem next to the grove with three playground areas basketball court picnic tables and enough space for the whole family to ride bikes", "There are outdoor basketball courts as well and I usually see people practicing their Tai Chi outside which is great to see."
  ]
  
COMMENTS.each do |comment|
  court_id = Court.all.sample.id
  user_id = User.all.sample.id
  Comment.create(user_id: user_id, court_id: court_id, content: comment)
end
