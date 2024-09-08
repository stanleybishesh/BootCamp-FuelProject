# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Venue.create(name: "New York City, NY")
Venue.create(name: "Los Angeles, CA")
Venue.create(name: "Chicago, IL")
Venue.create(name: "Atlanta, GA")
Venue.create(name: "Dallas, TX")
Venue.create(name: "Miami, FL")
Venue.create(name: "Seattle, WA")
