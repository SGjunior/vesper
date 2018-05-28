# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all


10.times do

  user = User.new(
    name: "#{Faker::SiliconValley.character}#{rand(0..10000000)}",
    bio: Faker::SiliconValley.quote,
    email: "#{Faker::SiliconValley.character.delete(" ")}#{rand(0..100000)}@gmail.com",
    password: "password",
    age: rand(18..50)
    )

  user.save!


  listing = Listing.new(
    max_party_size: rand(5..10),
    min_party_size: rand(2..3),
    price_per_person: rand(10..50),
    cuisine: Faker::SiliconValley.invention,
    description: Faker::SiliconValley.motto,
    # lng: Faker::Address.longitude,
    # lat: Faker::Address.latitude,
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    address: Faker::Address.street_address,
    user_id: user.id
  )

  listing.save!
end
