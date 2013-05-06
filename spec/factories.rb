FactoryGirl.define do 
	factory :user do 
		name "Mike Messenger"
		email "woodenfox@gmail.com"
		password "mypassword"
		password_confirmation "mypassword"
	end
end