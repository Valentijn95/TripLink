# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
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

ned_locations = [
  # Netherlands
  { location_name: "Dam Square", address: "Dam Square, Amsterdam, Netherlands", latitude: 52.3731, longitude: 4.8926 },
  { location_name: "Keukenhof", address: "Keukenhof, Lisse, Netherlands", latitude: 52.2716, longitude: 4.5468 },
  { location_name: "Kinderdijk", address: "Kinderdijk, Netherlands", latitude: 51.8850, longitude: 4.6424 },
  { location_name: "Rotterdam Central Station", address: "Rotterdam Central Station, Netherlands", latitude: 51.9225, longitude: 4.4706 },
  { location_name: "Giethoorn", address: "Giethoorn, Netherlands", latitude: 52.7230, longitude: 6.0815 },
  { location_name: "Zaanse Schans", address: "Zaanse Schans, Netherlands", latitude: 52.4726, longitude: 4.8163 },
  { location_name: "Efteling", address: "Efteling, Kaatsheuvel, Netherlands", latitude: 51.6526, longitude: 5.0480 },
  { location_name: "Hoge Veluwe National Park", address: "Hoge Veluwe National Park, Netherlands", latitude: 52.1000, longitude: 5.8000 },
  { location_name: "Vrijthof", address: "Maastricht Vrijthof, Netherlands", latitude: 50.8496, longitude: 5.6885 },
  { location_name: "Dom Tower", address: "Utrecht Dom Tower, Netherlands", latitude: 52.0907, longitude: 5.1214 }
]

bali_locations = [
  # Bali
  { location_name: "Uluwatu Temple", address: "Uluwatu Temple, Bali, Indonesia", latitude: -8.8296, longitude: 115.0842 },
  { location_name: "Tegallalang Rice Terraces", address: "Tegallalang Rice Terraces, Bali, Indonesia", latitude: -8.4323, longitude: 115.2794 },
  { location_name: "Mount Batur", address: "Mount Batur, Bali, Indonesia", latitude: -8.2423, longitude: 115.3753 },
  { location_name: "Ubud Monkey Forest", address: "Ubud Monkey Forest, Bali, Indonesia", latitude: -8.5191, longitude: 115.2582 },
  { location_name: "Tanah Lot Temple", address: "Tanah Lot Temple, Bali, Indonesia", latitude: -8.6212, longitude: 115.0861 },
  { location_name: "Nusa Penida", address: "Nusa Penida, Bali, Indonesia", latitude: -8.7277, longitude: 115.5444 },
  { location_name: "Bali Swing", address: "Bali Swing, Bali, Indonesia", latitude: -8.4450, longitude: 115.2600 },
  { location_name: "Sekumpul Waterfalls", address: "Sekumpul Waterfalls, Bali, Indonesia", latitude: -8.1692, longitude: 115.1692 },
  { location_name: "Sanur Beach", address: "Sanur Beach, Bali, Indonesia", latitude: -8.6995, longitude: 115.2630 },
  { location_name: "Jimbaran Bay", address: "Jimbaran Bay, Bali, Indonesia", latitude: -8.7842, longitude: 115.1675 }
]

arg_locations = [
  # Argentina
  { location_name: "Obelisco", address: "Obelisco, Buenos Aires, Argentina", latitude: -34.6037, longitude: -58.3816 },
  { location_name: "Iguazu Falls", address: "Iguazu Falls, Argentina", latitude: -25.6953, longitude: -54.4367 },
  { location_name: "Perito Moreno Glacier", address: "Perito Moreno Glacier, Argentina", latitude: -50.4956, longitude: -73.1375 },
  { location_name: "Mendoza Wine Region", address: "Mendoza Wine Region, Argentina", latitude: -32.8895, longitude: -68.8458 },
  { location_name: "Bariloche", address: "Bariloche, Argentina", latitude: -41.1335, longitude: -71.3103 },
  { location_name: "Tierra del Fuego National Park", address: "Tierra del Fuego National Park, Argentina", latitude: -54.8082, longitude: -68.3076 },
  { location_name: "La Boca", address: "La Boca, Buenos Aires, Argentina", latitude: -34.6345, longitude: -58.3635 },
  { location_name: "Puerto Madryn", address: "Puerto Madryn, Argentina", latitude: -42.7731, longitude: -65.0360 },
  { location_name: "Salinas Grandes", address: "Salinas Grandes, Argentina", latitude: -23.5650, longitude: -65.8466 },
  { location_name: "Mar del Plata Beach", address: "Mar del Plata Beach, Argentina", latitude: -38.0055, longitude: -57.5426 },
  { location_name: "Tafi del Valle", address: "Tafi del Valle, Argentina", latitude: -26.8517, longitude: -65.7098 }
]






puts "Seeding TripLink ->"
file = URI.parse("https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jpg/1200px-NES-Console-Set.jpg").open

puts " ---------------------------------------"
puts "Making users"
# Match.destroy_all
Interest.destroy_all
User.destroy_all
viti = User.new(name: "Viti", email: "viti@tl.com", password: "password")
viti.rate = 42
viti.guide_description = "I'l show you the meaning of life"
viti.guide = true
viti.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')

timo = User.new(name: "Timo", email: "timo@tl.com", password: "password")
timo.rate = 11
timo.guide_description = "I like big birds and i cannot lie"
timo.guide = true

denise = User.new(name: "Denise", email: "denise@tl.com", password: "password")

viti.save!
timo.save!
denise.save!

puts "#{User.count} users created"
puts " ---------------------------------------"

puts "Making interests"
interests.each do |interest|
  Interest.create!(interest: interest)
end
puts "#{Interest.count} intersts created"
puts " ---------------------------------------"

puts "Making user_interests"
UserInterest.destroy_all
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
Location.destroy_all
ned_locations.each do |location|
  Location.create!(name: location[:location_name], address: location[:address], lat: location[:latitude], lng: location[:longitude])
end
bali_locations.each do |location|
  Location.create!(name: location[:location_name], address: location[:address], lat: location[:latitude], lng: location[:longitude])
end
arg_locations.each do |location|
  Location.create!(name: location[:location_name], address: location[:address], lat: location[:latitude], lng: location[:longitude])
end
puts "#{Location.count} locations created"
puts " ---------------------------------------"

puts "Making user_locations"
GuideLocation.destroy_all
random_locations = Location.all.sample(3)
random_locations.each do |location|
  GuideLocation.create!(user: User.first, location: location)
end
random_locations = Location.all.sample(3)
random_locations.each do |location|
  GuideLocation.create!(user: User.all[1], location: location)
end
puts "#{GuideLocation.count} user locations created"
puts " ---------------------------------------"

puts "Making matches"
Match.destroy_all
Match.create!(guide: User.first, tourist: User.last, location: User.first.locations.sample, status: "pending")
Match.create!(guide: User.all[1], tourist: User.last, location: User.all[1].locations.sample, status: "accepted")
puts "#{Match.count} matches created"
puts " ---------------------------------------"
# rails 
