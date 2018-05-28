# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Package.destroy_all #done
Squadchosenvenue.destroy_all
Squadmember.destroy_all
Squad.destroy_all
Venue.destroy_all #done
User.destroy_all #done


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

5.times do

  venue = Venue.new(
    name: Faker::Beer.hop,
    description: 'Lorem ipsum dolor sit amet, ut amet arcu, a vel. Bibendum enim curabitur, tincidunt congue consectetuer, nunc in. Wisi wisi, vitae taciti tempor. Massa est, arcu integer, vulputate velit eu.',
    latitude: (45.5017 + rand() - rand()),
    longitude: (rand() - 73.5673 - rand()),
    address: Faker::Address.full_address,
    capacity: [200, 400, 600].sample()  ,
    music_genre: Faker::Music.instrument,
    instagram_handle: 'https://www.instagram.com/beachclubmtl/'
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

3.times do

  squad = Squad.new(
    night_out: Faker::Date.forward(rand(2..5)),
    user: User.all.sample(),
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
