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
Venue.destroy_all
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
    remote_photo_url: business["image_url"],
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
    first_name: 'MG',
    last_name:  'Ayoub',
    email: "qwerty@gmail.com",
    photo: 'MG_Avatar',
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )

User.create(
    first_name: 'Simon',
    last_name:  'Guertin',
    email: "qwerty2@gmail.com",
    photo: 'Simon_Avatar',
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )

User.create(
    first_name: 'V',
    last_name:  'Sadasivan',
    email: "qwerty3@gmail.com",
    photo: 'V_Avatar',
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )

User.create(
    first_name: 'Gaelle',
    last_name:  'Londonoz',
    email: "qwerty3@gmail.com",
    photo: 'Gaelle_Avatar',
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )

User.create(
    first_name: 'Neal',
    last_name:  'Sutaria',
    email: "qwerty3@gmail.com",
    photo: 'Neal_Avatar',
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )

User.create(
    first_name: 'Michael',
    last_name:  'Lepecq',
    email: "qwerty3@gmail.com",
    photo: 'Michael_Avatar',
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )

User.create(
    first_name: 'Jack',
    last_name:  'Gaarkeuken',
    email: "qwerty3@gmail.com",
    photo: 'Jack_Avatar',
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )

User.create(
    first_name: 'Leo',
    last_name:  'Marshall',
    email: "qwerty3@gmail.com",
    photo: 'Leo_Avatar',
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )

User.create(
    first_name: 'Linming',
    last_name:  'Ye',
    email: "qwerty3@gmail.com",
    photo: 'Li_Avatar',
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )


User.create(
    first_name: 'Adam',
    last_name:  'Frej',
    email: "qwerty3@gmail.com",
    photo: 'Adam_Avatar',
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
    name: "Datcha",
    description: "Underground DJ's in small intimate venue",
    music_genre: "electro",
    address: "98 ave Laurier",
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    photo: 'bar-datcha-bar-datcha',
    capacity: 100,
    pricing: 2,
    instagram_handle: 'https://www.instagram.com/beachclubmtl/'
  }
]

venue_attributes = [
  {
    name: "Velvet",
    description: "Club in plush velvet decor in the Old Port",
    music_genre: "dance/electro",
    address: "426 St Gabriel",
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    photo: 'Velvet_club',
    capacity: 100,
    pricing: 3,
    instagram_handle: 'https://www.instagram.com/beachclubmtl/'
  }
]

venue_attributes = [
  {
    name: "LaVoute",
    description: "New club venue in an old bank, very elegant",
    music_genre: "dance/hip-hop",
    address: "360 St Jacques",
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    photo: 'LaVoute_club',
    capacity: 100,
    pricing: 3,
    instagram_handle: 'https://www.instagram.com/beachclubmtl/'
  }
]

venue_attributes = [
  {
    name: "Loic",
    description: "Old bank turned wine bar in a relaxed atmosphere",
    music_genre: "rock/dance",
    address: "5001 Notre Dame",
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    photo: 'Loic_club',
    capacity: 100,
    pricing: 2,
    instagram_handle: 'https://www.instagram.com/beachclubmtl/'
  }
]

venue_attributes = [
  {
    name: "Thursday's",
    description: "Classic bar/nightclub establishment in Montreal",
    music_genre: "rock",
    address: "1449 Crescent St",
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    photo: 'Thursdays_club',
    capacity: 100,
    pricing: 2,
    instagram_handle: 'https://www.instagram.com/beachclubmtl/'
  }
]

venue_attributes = [
  {
    name: "Ping-Pong",
    description: "Fun venue, beer, board games and ping-pong",
    music_genre: "rock/dance",
    address: "5788 St Laurent",
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    photo: 'Ping pong_club',
    capacity: 100,
    pricing: 2,
    instagram_handle: 'https://www.instagram.com/beachclubmtl/'
  }
]

venue_attributes = [
  {
    name: "Henrietta",
    description: "Beautiful wine bar with good bites",
    music_genre: "brazilian/bosa nova",
    address: "115 Ave Laurier",
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    photo: 'Henrietta_club',
    capacity: 100,
    pricing: 2,
    instagram_handle: 'https://www.instagram.com/beachclubmtl/'
  }
]

venue_attributes = [
  {
    name: "Bar Le Ritz",
    description: "Indie rock venue, cheap drinks",
    music_genre: "varied music",
    address: "179 Rue Jean Talon",
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    photo: 'Bar Le Ritz_club',
    capacity: 100,
    pricing: 1,
    instagram_handle: 'https://www.instagram.com/beachclubmtl/'
  }
]

venue_attributes = [
  {
    name: "Bord'elle",
    description: "Supper club with elegant design",
    music_genre: "dance/hip hip-hop",
    address: "390 St Jacques",
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    photo: 'Bordelle_club',
    capacity: 100,
    pricing: 3,
    instagram_handle: 'https://www.instagram.com/beachclubmtl/'
  }
]

venue_attributes = [
  {
    name: "2 Pierrots",
    description: "Local francophone artists rock venue",
    music_genre: "francophone artists",
    address: "104 St Paul",
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    photo: '2pierrots_club',
    capacity: 100,
    pricing: 2,
    instagram_handle: 'https://www.instagram.com/beachclubmtl/'
  }
]

venue_attributes = [
  {
    name: "Mayfair",
    description: "Club venue in vitorian tea venue",
    music_genre: "dance/hip-hop",
    address: "451 Rue Rachel",
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    photo: 'Mayfair_club',
    capacity: 100,
    pricing: 2,
    instagram_handle: 'https://www.instagram.com/beachclubmtl/'
  }
]

venue_attributes = [
  {
    name: "Chez Serge",
    description: "Fun western bar with a riding bull",
    music_genre: "rock dance",
    address: "5301 St Laurent",
    # latitude: (45.5017 + rand() - rand()),
    # longitude: (rand() - 73.5673 - rand()),
    photo: 'Chez serge_club',
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
