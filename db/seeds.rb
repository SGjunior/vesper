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

Venue.destroy_all
if false

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


    # 4.times do
    #   package = Package.new(
    #     name: Faker::Beer.name,
    #     price: rand(140..600),
    #     description: 'Lorem ipsum dolor sit amet, ut amet arcu, a vel. Bibendum enim curabitur, tincidunt congue consectetuer, nunc in. Wisi wisi, vitae taciti tempor. Massa est, arcu integer, vulputate velit eu.',
    #     available_per_night: rand(2..8),
    #     venue: venue
    #   )

    #   package.save!
    # end
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
end

users = [
User.new(
    first_name: 'MG',
    last_name:  'Ayoub',
    email: "qwerty@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),

User.new(
    first_name: 'Simon',
    last_name:  'Guertin',
    email: "qwerty2@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),

User.new(
    first_name: 'Vasanth',
    last_name:  'Sadasivan',
    email: "qwerty3@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),

User.new(
    first_name: 'Gaelle',
    last_name:  'Londonoz',
    email: "qwerty4@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),

User.new(
    first_name: 'Neal',
    last_name:  'Sutaria',
    email: "qwerty5@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),

User.new(
    first_name: 'Michael',
    last_name:  'Lepecq',
    email: "qwerty6@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),

User.new(
    first_name: 'Jack',
    last_name:  'Gaarkeuken',
    email: "qwerty7@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),

User.new(
    first_name: 'Leo',
    last_name:  'Marshall',
    email: "qwerty8@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),

User.new(
    first_name: 'Linming',
    last_name:  'Ye',
    email: "qwerty9@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),

User.new(
    first_name: 'Adam',
    last_name:  'Frej',
    email: "qwerty10@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),
User.new(
    first_name: 'Chloe',
    last_name:  'Baron',
    email: "qwerty11@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),
User.new(
    first_name: 'Joy',
    last_name:  'Navi',
    email: "qwerty12@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),
User.new(
    first_name: 'Ben',
    last_name:  'Frej',
    email: "qwerty13@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),
User.new(
    first_name: 'Francis',
    last_name:  'Poitras',
    email: "qwerty14@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  ),
User.new(
    first_name: 'David',
    last_name:  'Pare',
    email: "qwerty15@gmail.com",
    phone_number: "514-321-4321",
    address: Faker::Address.full_address,
    password: 'qwerty'
  )
]

users.each do |user|
  user.remote_photo_url = Cloudinary::Utils.cloudinary_url  "#{user.first_name}_Avatar"
  user.save!
end

# puts "done calling APIs"


# 10.times do

#   first_name = Faker::Name.first_name
#   last_name = Faker::Name.last_name

#   user = User.new(
#     first_name: first_name,
#     last_name:  last_name,
#     email: "#{first_name[0]}#{last_name}@gmail.com",
#     photo: 'https://avatars2.githubusercontent.com/u/5466297?s=460&v=4',
#     phone_number: "514-321-4321",
#     address: Faker::Address.full_address,
#     password: 'qwerty'
#   )

#   user.save!

# end

venue_attributes = [
  {
    name: "Datcha",
    description: "Underground DJ's in small intimate venue",
    music_genre: "electro",
    address: "98 ave Laurier",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'bar-datcha-bar-datcha',
    remote_photo_url: Cloudinary::Utils.cloudinary_url('bar-datcha-bar-datcha'),
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/datcha/'
  },
  {
    name: "Velvet",
    description: "Club in plush velvet decor in the Old Port",
    music_genre: "dance/electro",
    address: "426 St Gabriel",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Velvet_club',
    remote_photo_url: Cloudinary::Utils.cloudinary_url('Velvet_club'),
    capacity: 100,
    pricing: 3,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/velvet/'
  },
  {
    name: "LaVoute",
    description: "New club venue in an old bank, very elegant",
    music_genre: "dance/hip-hop",
    address: "360 St Jacques",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'LaVoute_club',
    remote_photo_url: Cloudinary::Utils.cloudinary_url('LaVoute_club'),
    capacity: 100,
    pricing: 3,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/lavoute/'
  },
  {
    name: "Loic",
    description: "Old bank turned wine bar in a relaxed atmosphere",
    music_genre: "rock/dance",
    address: "5001 Notre Dame",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Loic_club',
    remote_photo_url: Cloudinary::Utils.cloudinary_url('Loic_club'),
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/loic/'
  },
  {
    name: "Thursday's",
    description: "Classic bar/nightclub establishment in Montreal",
    music_genre: "rock",
    address: "1449 Crescent St",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Thursdays_club',
    remote_photo_url: Cloudinary::Utils.cloudinary_url('Thursdays_club'),
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/thursdays/'
  },
  {
    name: "Ping-Pong",
    description: "Fun venue, beer, board games and ping-pong",
    music_genre: "rock/dance",
    address: "5788 St Laurent",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Ping pong_club',
    remote_photo_url: Cloudinary::Utils.cloudinary_url('Ping pong_club'),
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/ping-pong/'
  },
  {
    name: "Henrietta",
    description: "Beautiful wine bar with good bites",
    music_genre: "brazilian/bosa nova",
    address: "115 Ave Laurier",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Henrietta_club',
    remote_photo_url: Cloudinary::Utils.cloudinary_url('Henrietta_club'),
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/henrietta/'
  },
  {
    name: "Bar Le Ritz",
    description: "Indie rock venue, cheap drinks",
    music_genre: "varied music",
    address: "179 Rue Jean Talon",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Bar Le Ritz_club',
    remote_photo_url: Cloudinary::Utils.cloudinary_url('Bar Le Ritz_club'),
    capacity: 100,
    pricing: 1,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/barleritz/'
  },
  {
    name: "Bord'elle",
    description: "Supper club with elegant design",
    music_genre: "dance/hip hip-hop",
    address: "390 St Jacques",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Bordelle_club',
    remote_photo_url: Cloudinary::Utils.cloudinary_url('Bordelle_club'),
    capacity: 100,
    pricing: 3,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/bordelle/'
  },
  {
    name: "2 Pierrots",
    description: "Local francophone artists rock venue",
    music_genre: "francophone artists",
    address: "104 St Paul",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: '2pierrots_club',
    remote_photo_url: Cloudinary::Utils.cloudinary_url('2pierrots_club'),
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/2pierrots/'
  },
  {
    name: "Mayfair",
    description: "Club venue in victorian tea environment",
    music_genre: "dance/hip-hop",
    address: "451 Rue Rachel",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Mayfair_club',
    remote_photo_url: Cloudinary::Utils.cloudinary_url('Mayfair_club'),
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/mayfair/'
  },
  {
    name: "Chez Serge",
    description: "Fun western bar with a riding bull",
    music_genre: "rock dance",
    address: "5301 St Laurent",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Chez serge_club',
    remote_photo_url: Cloudinary::Utils.cloudinary_url('Chez serge_club'),
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/chezserge/'
  },
  {
    name: "Le Rouge Bar",
    description: "The go to for big clubs, 2 floors of dance club music",
    music_genre: "rock dance",
    address: "7 Prince arthur",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Le rouge_bar',
    remote_photo_url: Cloudinary::Utils.cloudinary_url('Le rouge_bar'),
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/lerougebar/'
  },
  {
    name: "Bar Blizzarts",
    description: "Small club with different nights, great music",
    music_genre: "rock dance",
    address: "3956 Blvd St Laurent",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Bar_Blizzarts',
    remote_photo_url: "https://res.cloudinary.com/dw3kaeolx/image/upload/v1528469637/Bar_Blizzarts.jpg",
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/barblizzarts/'
  },
  # {
  #   name: "La Porte Rouge",
  #   description: "Great dance venue, fun vibes",
  #   music_genre: "rock dance",
  #   address: "1834 Mont-Royal Ave",
  #   latitude: (45.5017 + rand() - rand()),
  #   longitude: (rand() - 73.5673 - rand()),
  #   photo: 'La Porte Rouge',
  #   remote_photo_url: Cloudinary::Utils.cloudinary_url('La porte rouge'),
  #   capacity: 100,
  #   pricing: 2,
  #   rating: 3,
  #   instagram_handle: 'https://www.instagram.com/laporterouge/'
  # },
  {
    name: "BLVD44",
    description: "hip-hop and rnb, great night out",
    music_genre: "hip-hop/rnb",
    address: "2108 St Laurent",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'BLVD44',
    remote_photo_url: "https://res.cloudinary.com/dw3kaeolx/image/upload/v1528469782/BLVD44.jpg",
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/blvd44/'
  },
  {
    name: "Newspeak",
    description: "The place for the underground DJs, great electro music",
    music_genre: "electro",
    address: "1403 St Elisabeth",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Newspeak',
    remote_photo_url: "https://res.cloudinary.com/dw3kaeolx/image/upload/v1528469969/Newspeak.jpg",
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/newspeak/'
  },
  {
    name: "Cafe Campus",
    description: "Fun university venue, 2 floors of dance club music",
    music_genre: "rock dance",
    address: "57 Prince arthur",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Cafe_campus',
    remote_photo_url: "https://res.cloudinary.com/dw3kaeolx/image/upload/v1528470135/Cafe_campus.jpg",
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/cafecampus/'
  },
  {
    name: "Salon daome",
    description: "Great DJ venue, small and comfy vibes",
    music_genre: "electro",
    address: "141 Mont-Royal",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Salon_daome',
    remote_photo_url: "https://res.cloudinary.com/dw3kaeolx/image/upload/v1528470315/Salon_daome.jpg",
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/salondamoe/'
  },
  {
    name: "Ecole privee",
    description: "Great dance/electro music, cool vibes",
    music_genre: "hip-hop, electro",
    address: "3500 St Laurent",
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    photo: 'Ecole_privee',
    remote_photo_url: "https://res.cloudinary.com/dw3kaeolx/image/upload/v1528470420/Ecole_privee.jpg",
    capacity: 100,
    pricing: 2,
    rating: 3,
    instagram_handle: 'https://www.instagram.com/ecoleprivee/'
  }

]

# # 5.times do
venue_attributes.each do |venue_attributes_hash|
#   venue_attributes_hash_photo = Cloudinary::Utils.cloudinary_url  "#{venue_attributes_hash["photo"]}"
#   # venue_attributes_hash.delete("photo")

  venue = Venue.new(venue_attributes_hash)
#   venue.remote_photo_url = venue_attributes_hash_photo

#     # name: venue_attributes_hash[:name],
#     # description: venue_attributes_hash[:description],
#     # # description: 'Lorem ipsum dolor sit amet, ut amet arcu, a vel. Bibendum enim curabitur, tincidunt congue consectetuer, nunc in. Wisi wisi, vitae taciti tempor. Massa est, arcu integer, vulputate velit eu.',
#     # latitude: (45.5017 + rand() - rand()),
#     # longitude: (rand() - 73.5673 - rand()),
#     # address: venue_attributes_hash[:address],
#     # capacity: [200, 400, 600].sample()  ,
#     # music_genre: Faker::Music.instrument,
#     # pricing: rand(1..3),
#     # instagram_handle: 'https://www.instagram.com/beachclubmtl/'

  venue.save!
  puts "created #{venue.name}"
end
#   # 4.times do

#   #   package = Package.new(
#   #     name: Faker::Beer.name,
#   #     price: rand(140..600),
#   #     description: 'Lorem ipsum dolor sit amet, ut amet arcu, a vel. Bibendum enim curabitur, tincidunt congue consectetuer, nunc in. Wisi wisi, vitae taciti tempor. Massa est, arcu integer, vulputate velit eu.',
#   #     available_per_night: rand(2..8),
#   #     venue: venue
#   #   )

#   #   package.save!

#   # end
# end

# 3.times do

#   squad_leader = User.all.sample()
#   squad = Squad.new(
#     night_out: Faker::Date.forward(rand(2..5)),
#     user: squad_leader,
#     package_id: 0,
#     confirmed: false
#   )

#   squad.save!

#   3.times do

#     squadchosenvenue = Squadchosenvenue.new(
#       squad: squad,
#       venue: Venue.all.sample()
#     )
#     squadchosenvenue.save!
#   end

#   squadmember = Squadmember.new(
#     user: squad_leader,
#     squadchosenvenue: squad.squadchosenvenues.sample(),
#     will_be_present: true,
#     squad: squad,
#     contribution: rand(20..200)
#   )
#   squadmember.save!

#   rand(2..4).times do
#     squadmember = Squadmember.new(
#       user: User.all.sample(),
#       squadchosenvenue: squad.squadchosenvenues.sample(),
#       will_be_present: true,
#       squad: squad,
#       contribution: rand(20..200)
#     )
#     squadmember.save!
#   end
# end
