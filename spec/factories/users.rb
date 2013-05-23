# FactoryGirl.define do 
#	factory :user do 
#		name "Joan Factory"
#		email "joan_factory@gmail.com"
#		password "mypassword"
#		password_confirmation "mypassword"
#	end
# end

FactoryGirl.define do 
	factory :user do 
		sequence(:name) { |n| "Person #{n}"}
		sequence(:email) { |n| "email#{n}@example.com"}
		password "mypassword"
		password_confirmation "mypassword"

		factory :admin do
			admin true
		end
	end
end
