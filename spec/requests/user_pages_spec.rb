require 'spec_helper'

describe "User pages" do
subject { page }

shared_examples_for "a profile page" do
	it { should have_selector('h1',    text: user.name)}
	it { should have_selector('title', text: user.name)}
end

# profile page ------------------------------

describe "profile" do
	let(:user) { FactoryGirl.create(:user) }
	before { visit user_path(user) }

	describe "signed out page" do
		it_behaves_like "a profile page"
		it {should_not have_link('Edit', href: edit_user_path(user))}
	end

	describe "your own page" do
		before do 
			sign_in(user)
			visit user_path(user)
		end
		it_behaves_like "a profile page"
		it {should have_link('Edit', href: edit_user_path(user))}
	end
end

# user list ----------------------------------

describe "index" do
	
	let(:user) {FactoryGirl.create(:user) }

	#before(:all) {30.times { FactoryGirl.create(:user) }}
	#after(:all) {User.delete_all}

	before(:each) do
		sign_in user
		visit users_path
	end

	title_h1('All users', 'All users')

	describe "pagination" do 
	#	it {should have_selector('div.pagination')}

		it "should list each user" do 
		#	User.paginate(page: 1).each do |user|
		#		page.should have_selector('li', text: user.name)
		#	end
		end
	end

	describe "delete links" do 
		it {should_not have_link('Delete')}

		describe "as an admin user" do 
			let(:admin) { FactoryGirl.create(:admin) }
			before do 
				sign_in admin
				visit users_path
			end

			it {should have_link('Delete', href: user_path(User.first))}
			it "should be able to delete other users" do 
				expect {click_link('Delete') }.to change(User, :count).by(-1)
			end
			it {should_not have_link('Delete', href: user_path(admin))}
		end

		describe "as non-admin user" do 
			let(:user) {FactoryGirl.create(:user)}
			let(:non_admin) {FactoryGirl.create(:user)}

			before {sign_in non_admin}

			describe "submitting a DELETE request to the Users#destroy action" do 
				before {delete user_path(user)}
				specify { response.should redirect_to(root_path) }
			end
		end
	end
end

# signup -------------------------------------

describe "signup" do
 	before {visit signup_path}
 	let(:submit) {"Create my account"}
 	title_h1('Sign up', 'Sign up')
	describe "signup process" do 
		describe "with invalid information" do 
			it "should not create a user" do 
				expect { click_button submit }.not_to change(User, :count)
			end	
		end

		describe "with valid information" do 
			before do 
				fill_in "Name",  	    with: "Example User"
				fill_in "Email",  		with: "user@example.com"
				fill_in "Password",  	with: "fakepassword"
				fill_in "Confirmation", with: "fakepassword" 
				click_button submit
			end
			it {should have_link('Sign out')}
		end
	end
end

# edit user -----------------------------------

describe "edit" do 
	let(:user) { FactoryGirl.create(:user) }
	before do 
		sign_in user
		visit edit_user_path(user)
	end
	
	describe "page" do 
		title_h1('Update your profile', 'Update your profile')	
		it {should have_link('Change', href: 'http://gravatar.com/emails')}
	end
		
	describe "with invalid information" do 
		before { click_button "Update" }
		it {should have_selector('title', text: 'Update your profile')}
		it {should have_content('error') }
	end

	describe "with valid information" do 
		let(:new_name) {"New Name"}
		let(:new_email) {"new@email.com"}

		before do 
			fill_in "Name",			with: new_name
			fill_in "Email",		with: new_email
			fill_in "Password",  	with: user.password
			fill_in "Confirmation", with: user.password_confirmation
			click_button "Update" 
		end
		it {should have_content('Updated successfully') }
		it {should have_selector('h1', text: new_name)}
		specify { user.reload.name.should == new_name }
		specify { user.reload.email.should == new_email }

	end
end

# end of spec
end
