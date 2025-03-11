# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Seeding TripLink ->"

puts " ---------------------------------------"
puts "Make users"
User.delete_all
viti = User.new(name: "Viti", email: "viti@tl.com", password: "password")
viti.rate = 42
viti.guide_description = "I'l show you the meaning of life"
viti.guide = true

timo = User.new(name: "Timo", email: "timo@tl.com", password: "password")
timo.rate = 11
timo.guide_description = "I like big birds and i cannot lie"
timo.guide = true
