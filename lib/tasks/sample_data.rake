namespace :db do 
	desc "Fill database with sample data"
	task populate: :environment do 
		
		admin = User.create!(name: "Mike Messenger",
					email: "woodenfox@gmail.com",
					password: "1nsecure",
					password_confirmation: "1nsecure")
		admin.toggle!(:admin)
		
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@fake.org"
			password = "longunguessablefakepassword1"
			User.create!(name: name,
						email: email,
						password: password,
						password_confirmation: password)
		end
	end
end