namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(name: "Eric",
                 email: "typ90@site.com",
                 password: "welcome",
                 password_confirmation: "welcome",
                 admin: true)
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@site.com"
			password = "password"
			User.create!(name: name,
				email: email,
				password: password,
				password_confirmation: password)
		end
	end	
end