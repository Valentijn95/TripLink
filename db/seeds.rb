interests = [
  "Hiking",
  "Adventure",
  "Cruises",
  "Solo travel",
  "Stargazing",
  "Animal watching",
  "Architecture tours",
  "Business travel",
  "Culture",
  "Experience personal growth",
  "Family travel",
  "Fishing",
  "Getting accustomed to different cultures",
  "Language learning",
  "Safaris",
  "Food",
  "Art",
  "Bird watching"
]

locations = [
  # Paris POIs
  { location_name: "Louvre Museum", address: "Rue de Rivoli, 75001 Paris, France" },
  { location_name: "Notre-Dame Cathedral", address: "6 Parvis Notre-Dame - Pl. Jean-Paul II, 75004 Paris, France" },
  { location_name: "Montmartre", address: "75018 Paris, France" },
  { location_name: "Champs-Élysées", address: "Avenue des Champs-Élysées, 75008 Paris, France" },
  { location_name: "Sacré-Cœur Basilica", address: "35 Rue du Chevalier de la Barre, 75018 Paris, France" },

  # Amsterdam POIs
  { location_name: "Rijksmuseum", address: "Museumstraat 1, 1071 XX Amsterdam, Netherlands" },
  { location_name: "Anne Frank House", address: "Prinsengracht 263-267, 1016 GV Amsterdam, Netherlands" },
  { location_name: "Van Gogh Museum", address: "Museumplein 6, 1071 DJ Amsterdam, Netherlands" },
  { location_name: "Dam Square", address: "Dam, 1012 JL Amsterdam, Netherlands" },
  { location_name: "Vondelpark", address: "1071 AA Amsterdam, Netherlands" },

  # Buenos Aires POIs
  { location_name: "La Boca", address: "Caminito, Buenos Aires, Argentina" },
  { location_name: "Recoleta Cemetery", address: "Junín 1760, C1113 CABA, Argentina" },
  { location_name: "Teatro Colón", address: "Cerrito 628, C1010 CABA, Argentina" },
  { location_name: "Plaza de Mayo", address: "Av. Hipólito Yrigoyen s/n, C1087 CABA, Argentina" },
  { location_name: "Palermo Soho", address: "Palermo, Buenos Aires, Argentina" },

  # Lisbon POIs
  { location_name: "Belém Tower", address: "Av. Brasília, 1400-038 Lisboa, Portugal" },
  { location_name: "Jerónimos Monastery", address: "Praça do Império 1400-206 Lisboa, Portugal" },
  { location_name: "Alfama District", address: "1100-129 Lisboa, Portugal" },
  { location_name: "Praça do Comércio", address: "Praça do Comércio, 1100-148 Lisboa, Portugal" },

  # Bruges, Belgium POIs
  { location_name: "Market Square (Markt)", address: "Markt, 8000 Brugge, Belgium" },
  { location_name: "Belfry of Bruges", address: "Markt 7, 8000 Brugge, Belgium" },
  { location_name: "Minnewater Lake", address: "Minnewater, 8000 Brugge, Belgium" },
  { location_name: "Church of Our Lady", address: "Mariastraat, 8000 Brugge, Belgium" },
  { location_name: "Basilica of the Holy Blood", address: "Burg 13, 8000 Brugge, Belgium" },
  { location_name: "Groeningemuseum", address: "Dijver 12, 8000 Brugge, Belgium" },

  # Utrecht, Netherlands POIs
  { location_name: "Dom Tower", address: "Domplein 21, 3512 JE Utrecht, Netherlands" },
  { location_name: "Rietveld Schröder House", address: "Prins Hendriklaan 50, 3583 EP Utrecht, Netherlands" },
  { location_name: "Museum Speelklok", address: "Steenweg 6, 3511 JP Utrecht, Netherlands" },
  { location_name: "Oudegracht", address: "Oudegracht, 3511 Utrecht, Netherlands" },
  { location_name: "Botanical Gardens Utrecht", address: "Budapestlaan 17, 3584 CD Utrecht, Netherlands" },

  # Yellowstone National Park, USA POIs
  { location_name: "Old Faithful", address: "Yellowstone National Park, WY 82190, USA" },
  { location_name: "Grand Prismatic Spring", address: "Yellowstone National Park, WY 82190, USA" },
  { location_name: "Mammoth Hot Springs", address: "Mammoth, Yellowstone National Park, WY 82190, USA" },
  { location_name: "Yellowstone Lake", address: "Yellowstone National Park, WY 82190, USA" },
  { location_name: "Grand Canyon of the Yellowstone", address: "Yellowstone National Park, WY 82190, USA" },

  # De Hoge Veluwe National Park, Netherlands POIs
  { location_name: "Kröller-Müller Museum", address: "Houtkampweg 6, 6731 AW Otterlo, Netherlands" },
  { location_name: "Jachthuis Sint Hubertus", address: "Apeldoornseweg 258, 7351 TA Hoenderloo, Netherlands" },
  { location_name: "De Hoge Veluwe Sand Dunes", address: "6731 Otterlo, Netherlands" },
  { location_name: "Wildlife Watching Spot", address: "Houtkampweg, 6731 AW Otterlo, Netherlands" },
  { location_name: "Park Entrance Otterlo", address: "Houtkampweg 9, 6731 AV Otterlo, Netherlands" }
]

def make_guide_locations(user, city)
  all_location_in_city = Location.where(city: city)
  if all_location_in_city.count == 1
    GuideLocation.create!(user: user, location: all_location_in_city.first)
    return
  elsif all_location_in_city.count == 0
    puts "No locations in #{city}"
    return
  else
    locations = all_location_in_city.sample(all_location_in_city.count/2)
  end
  locations.each do |location|
    GuideLocation.create!(user: user, location: location)
  end
end

def create_users
  a1 = User.new(name: "Liam", email: "liam@tl.com", password: "password")
  a1.rate = 50
  a1.guide_description = "Discover hidden gems and secret spots that most tourists never see. Join me for an unforgettable journey!"
  a1.short_description = "I love hiking and exploring new places."
  a1.guide = true

  a2 = User.new(name: "Emma", email: "emma@tl.com", password: "password")
  a2.rate = 60
  a2.guide_description = "Passionate about history and culture—I’ll take you through centuries of fascinating stories and iconic landmarks."
  a2.short_description = "A history buff who enjoys museum visits."
  a2.guide = true

  a3 = User.new(name: "Noah", email: "noah@tl.com", password: "password")
  a3.rate = 45
  a3.guide_description = "Adventure awaits! From scenic trails to breathtaking viewpoints, I’ll guide you through the best outdoor experiences."
  a3.short_description = "An outdoor enthusiast and coffee lover."
  a3.guide = true

  a4 = User.new(name: "Olivia", email: "olivia@tl.com", password: "password")
  a4.rate = 55
  a4.guide_description = "Food lover ready to take you on a culinary journey. Let's explore the best local dishes, street food, and hidden cafés!"
  a4.short_description = "Big fan of trying new cuisines and flavors."
  a4.guide = true

  a5 = User.new(name: "Ethan", email: "ethan@tl.com", password: "password")
  a5.rate = 38
  a5.guide_description = "Nature, wildlife, and breathtaking views—let’s escape the city and experience the beauty of the great outdoors together!"
  a5.short_description = "Love photographing landscapes and animals."
  a5.guide = true

  a6 = User.new(name: "Ava", email: "ava@tl.com", password: "password")
  a6.rate = 48
  a6.guide_description = "City explorer with a passion for street art, music, and unique local culture. Let’s dive into the heartbeat of the city!"
  a6.short_description = "Always looking for the best street art spots."
  a6.guide = true

  a7 = User.new(name: "Silvia", email: "Silvia@tl.com", password: "password")
  a7.rate = 52
  a7.guide_description = "I’ll guide you through the best nightlife spots, trendy bars, and hidden speakeasies for an unforgettable evening!"
  a7.short_description = "Love discovering unique cocktail bars."
  a7.guide = true

  a8 = User.new(name: "Sophia", email: "sophia@tl.com", password: "password")
  a8.rate = 40
  a8.guide_description = "History, legends, and fascinating stories await! Let me show you the most intriguing sites and hidden historical gems."
  a8.short_description = "Love ancient ruins and old books."
  a8.guide = true

  # Tourists ------------------------------------------------------------------
  a9 = User.new(name: "James", email: "james@tl.com", password: "password")
  # a9.rate = 57
  # a9.guide_description = "Let’s explore like locals! I’ll show you the best places to eat, relax, and experience the true spirit of this city."
  a9.short_description = "Always on the lookout for cozy cafés."
  # a9.guide = true

  a10 = User.new(name: "Isabella", email: "isabella@tl.com", password: "password")
  # a10.rate = 43
  # a10.guide_description = "I’ll take you on a cultural deep dive—from museums to live performances, we’ll experience the best this place has to offer!"
  a10.short_description = "Passionate about art and live music."
  # a10.guide = true

  a11 = User.new(name: "William", email: "william@tl.com", password: "password")
  a11.short_description = "Love exploring new cities and trying local foods."


  viti = User.new(name: "Viti", email: "viti@tl.com", password: "password")
  viti.rate = 42
  viti.guide_description = "I'll show you the meaning of life"
  viti.guide = true

  timo = User.new(name: "Timo", email: "timo@tl.com", password: "password")
  timo.rate = 11
  timo.guide_description = "I like big birds and i cannot lie"
  timo.guide = true

  denise = User.new(name: "Denise", email: "denise@tl.com", password: "password")
  denise.rate = 33
  denise.guide_description = "I like small birds and i cannot lie"
  denise.guide = true

  viti.save!
  timo.save!
  denise.save!
  a1.save!
  a2.save!
  a3.save!
  a4.save!
  a5.save!
  a6.save!
  a7.save!
  a8.save!
  a9.save!
  a10.save!
  a11.save!
end


puts "Seeding TripLink ->"
puts " ---------------------------------------"

puts "Destroying all records"
Review.destroy_all
Match.destroy_all
Location.destroy_all
GuideLocation.destroy_all
UserInterest.destroy_all
Interest.destroy_all
User.destroy_all
puts "All existing records destroyed"
puts " ---------------------------------------"

puts "Making users"

create_users


puts "#{User.count} users created"
puts " ---------------------------------------"

puts "Making interests"
interests.each do |interest|
  Interest.create!(interest: interest)
end
puts "#{Interest.count} intersts created"
puts " ---------------------------------------"

puts "Making user_interests"
User.all.each do |user|
  random_interests = Interest.all.sample(6)
  UserInterest.create!(interest: random_interests[0], user: user)
  UserInterest.create!(interest: random_interests[1], user: user)
  UserInterest.create!(interest: random_interests[2], user: user)
  UserInterest.create!(interest: random_interests[3], user: user)
  UserInterest.create!(interest: random_interests[4], user: user)
end
puts "#{UserInterest.count} user interests created"
puts " ---------------------------------------"

puts "Making locations"
locations.each do |location|
  Location.create!(name: location[:location_name], address: location[:address], description: location[:description])
end
puts "#{Location.count} locations created"
puts " ---------------------------------------"

puts "Making guide locations"
make_guide_locations(User.first, "Otterlo")
make_guide_locations(User.all[1], "Paris")
make_guide_locations(User.all[2], "Paris")
make_guide_locations(User.all[3], "Buenos Aires")
make_guide_locations(User.all[4], "Buenos Aires")
make_guide_locations(User.all[5], "Amsterdam")
make_guide_locations(User.all[6], "Amsterdam")
make_guide_locations(User.all[7], "Brugge")
make_guide_locations(User.all[8], "Brugge")
make_guide_locations(User.all[9], "Lisbon")


puts "#{GuideLocation.count} guide locations created"
puts " ---------------------------------------"

puts "Making matches"
Match.create!(guide: User.first, tourist: User.all[1], location: User.first.locations.sample, status: "pending")
Message.create!(user: User.all[1], match: Match.first, content: "I want to see the birds")
Match.create!(guide: User.all[1], tourist: User.last, location: User.all[1].locations.sample, status: "accepted")
Message.create!(user: User.last, match: Match.last, content: "Do you like birds?")
puts "#{Match.count} matches created and #{Message.count} messages created"
puts " ---------------------------------------"

puts "Making reviews"
Review.create!(user: User.first, match: Match.first, content: "This review is about a bird and it is awesome")
Review.create!(user: User.all[1], match: Match.last, content: "This review is about a terrible bird")
puts "#{Review.count} reviews created"
puts " ---------------------------------------"
