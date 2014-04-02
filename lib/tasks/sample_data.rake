namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_properties
	end	
end

def make_users
	User.create!(name: "Eric",
	         email: "eric@site.com",
	         password: "welcome1",
	         password_confirmation: "welcome1",
	         admin: true,
	         owner: true)
	50.times do |n|
		name = Faker::Name.name
		email = "user-#{n+1}@site.com"
		password = "welcome1"
		User.create!(name: name,
			email: email,
			password: password,
			password_confirmation: password)
	end
end

def make_properties
	owners = User.all(limit: 10)
	b_list = bath_float_list
	owners.each do |owner|
		owner.owner = true
		owner.password = "welcome1"
		owner.password_confirmation = "welcome1"
		owner.save!
		12.times do
			name = Faker::Address.street_address
			desc = Faker::Lorem.sentence(5)
			beds = rand(1..8)
			baths = b_list.sample
			rent = rand(500..7000)

			owner.properties.create!(name: name, description: desc,
			 beds: beds, baths: baths, rent: rent)
		end
	end
end


def bath_float_list
	  baths_list = []
      (0..8).each do |i|
      baths_list.insert(i, i)
      baths_list.insert(i, i+0.5)
      end
    baths_list.to_a
end