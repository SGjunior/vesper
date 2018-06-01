# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:2
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Package.destroy_all #done
Squadmember.destroy_all
Squadchosenvenue.destroy_all
Squad.destroy_all

User.destroy_all #done


def convert_yelp_pricing_to_integer(yelp_price)
  if yelp_price.nil?
    1
  elsif yelp_price.is_a? Integer
    yelp_price
  elsif yelp_price.is_a? Integer
    yelp_price.count("$")
  else
    1
  end
end


require 'json'
require 'open-uri'
require 'net/http'


puts "calling yelp API"

uri = URI("https://api.yelp.com/v3/businesses/search?location=montreal&categories=danceclubs&limit=50")

request = Net::HTTP::Get.new(uri)
request["Authorization"] = "Bearer #{ENV['YELP_API_KEY']}"
http = Net::HTTP.new(uri.hostname, uri.port)
http.use_ssl = true
response = http.start { |http| http.request(request) }
results = JSON.parse(response.body)

array_of_businesess = results["businesses"]
array_of_businesess.each do |business|
  venue = Venue.new(
    name: business["name"],
    longitude: business["coordinates"]["longitude"],
    latitude: business["coordinates"]["latitude"],
    address: business["location"]["address1"],
    description: business["categories"].map { |c| c["title"] }.join(" - "),
    music_genre: 'lorem_ipsum',
    rating: business["rating"],
    photo: business["image_url"],
    review_count: business["review_count"],
    pricing: convert_yelp_pricing_to_integer(business["price"])

    )
  venue.save!


  4.times do
    package = Package.new(
      name: Faker::Beer.name,
      price: rand(140..600),
      description: 'Lorem ipsum dolor sit amet, ut amet arcu, a vel. Bibendum enim curabitur, tincidunt congue consectetuer, nunc in. Wisi wisi, vitae taciti tempor. Massa est, arcu integer, vulputate velit eu.',
      available_per_night: rand(2..8),
      venue: venue
    )

    package.save!
  end
end

#API FOR GOOGLE PLACES
# url = 'https://api.github.com/users/ssaunier'
# user_serialized = open(url).read
# user = JSON.parse(user_serialized)

# puts "#{user['name']} - #{user['bio']}"

puts "calling google places"

uri = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=45.5017,-73.5673&radius=1500&type=club&keyword=club&key=#{ENV['GOOGLE_PLACES_API_KEY']}")

request = Net::HTTP::Get.new(uri)
http = Net::HTTP.new(uri.hostname, uri.port)
http.use_ssl = true
response = http.start { |http| http.request(request) }
results = JSON.parse(response.body)

array_of_clubs = results["results"]

array_of_clubs.each do |club|
  venue = Venue.new(
    name: club["name"],
    longitude: club["geometry"]["location"]["lng"],
    latitude: club["geometry"]["location"]["lat"],
    address: club["vicinity"],
    description: 'lorem ipsum',
    music_genre: 'lorem_ipsum'
    )
  venue.save!

  4.times do
    package = Package.new(
      name: Faker::Beer.name,
      price: rand(140..600),
      description: 'Lorem ipsum dolor sit amet, ut amet arcu, a vel. Bibendum enim curabitur, tincidunt congue consectetuer, nunc in. Wisi wisi, vitae taciti tempor. Massa est, arcu integer, vulputate velit eu.',
      available_per_night: rand(2..8),
      venue: venue
    )

    package.save!
  end
end

User.create(
    first_name: 'Jean',
    last_name:  'Giroux',
    email: "qwerty@gmail.com",
    photo: 'https://avatars2.githubusercontent.com/u/5466297?s=460&v=4',
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )

User.create(
    first_name: 'Jack',
    last_name:  'Gaark',
    email: "qwerty2@gmail.com",
    photo: 'https://avatars2.githubusercontent.com/u/5466297?s=460&v=4',
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )

User.create(
    first_name: 'Adam',
    last_name:  'Epstein',
    email: "qwerty3@gmail.com",
    photo: 'https://avatars2.githubusercontent.com/u/5466297?s=460&v=4',
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )


puts "done calling APIs"


10.times do

  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  user = User.new(
    first_name: first_name,
    last_name:  last_name,
    email: "#{first_name[0]}#{last_name}@gmail.com",
    photo: 'https://avatars2.githubusercontent.com/u/5466297?s=460&v=4',
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )

  user.save!

end

venue_attributes = [
  {
    name: "Martin's Club",
    description: "Whatever",
    music_genre: "brazilian",
    address: "123 not fake",
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    capacity: 100,
    pricing: 2,
    instagram_handle: 'https://www.instagram.com/beachclubmtl/'
  }
]

# 5.times do
venue_attributes.each do |venue_attributes_hash|
  venue = Venue.new(venue_attributes_hash)
    # name: venue_attributes_hash[:name],
    # description: venue_attributes_hash[:description],
    # # description: 'Lorem ipsum dolor sit amet, ut amet arcu, a vel. Bibendum enim curabitur, tincidunt congue consectetuer, nunc in. Wisi wisi, vitae taciti tempor. Massa est, arcu integer, vulputate velit eu.',
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    # address: venue_attributes_hash[:address],
    # capacity: [200, 400, 600].sample()  ,
    # music_genre: Faker::Music.instrument,
    # pricing: rand(1..3),
    # instagram_handle: 'https://www.instagram.com/beachclubmtl/'

  venue.save!

  4.times do

    package = Package.new(
      name: Faker::Beer.name,
      price: rand(140..600),
      description: 'Lorem ipsum dolor sit amet, ut amet arcu, a vel. Bibendum enim curabitur, tincidunt congue consectetuer, nunc in. Wisi wisi, vitae taciti tempor. Massa est, arcu integer, vulputate velit eu.',
      available_per_night: rand(2..8),
      venue: venue
    )

    package.save!

  end
end

3.times do

  squad_leader = User.all.sample()
  squad = Squad.new(
    night_out: Faker::Date.forward(rand(2..5)),
    user: squad_leader,
    package_id: 0,
    confirmed: false
  )

  squad.save!

  3.times do

    squadchosenvenue = Squadchosenvenue.new(
      squad: squad,
      venue: Venue.all.sample()
    )
    squadchosenvenue.save!
  end

  Squadmember.new(
    user: squad_leader,
    squadchosenvenue: squad.squadchosenvenues.sample(),
    will_be_present: true,
    squad: squad,
    contribution: rand(20..200)
  ).save!

  rand(2..4).times do
    squadmember = Squadmember.new(
      user: User.all.sample(),
      squadchosenvenue: squad.squadchosenvenues.sample(),
      will_be_present: true,
      squad: squad,
      contribution: rand(20..200)
    )
    squadmember.save!
  end
end
