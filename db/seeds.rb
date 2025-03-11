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

viti = User.create!(
  name: "Viti",
  email: "viti@tl.com",
  password: "password",
  rate: 42,
  guide_description: "I'll show you the meaning of life",
  guide: true
)

timo = User.create!(
  name: "Timo",
  email: "timo@tl.com",
  password: "password",
  rate: 11,
  guide_description: "I like big birds and I cannot lie",
  guide: true
)

denise = User.create!(
  name: "Denise",
  email: "denise@tl.com",
  password: "password",
  rate: 20,
  guide_description: "I can show you some terrible places",
  guide: true
)

puts "Seed finished"
