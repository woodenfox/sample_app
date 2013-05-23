require 'spec_helper'

describe "Authentication" do
subject { page }

shared_examples_for "the sign in page" do 
	it { should have_selector('h1', text: 'Sign in')}
	it { should have_selector('title', text: 'Sign in')}
end

describe "sign in page" do 
	before { visit signin_path }
	it_behaves_like "the sign in page"

	describe "with invalid information" do 
		before {click_button "Sign in"}
		it_behaves_like "the sign in page"
		it {should have_selector('div.alert.alert-error', text: 'Invalid')}
	end

	describe "with valid information" do 
		let(:user) { FactoryGirl.create(:user) }
		before { sign_in(user) }
     	it {should have_selector('title', text: user.name)}
		it {should have_link('Sign out', href: signout_path)}
		it {should have_link('Profile', href: user_path(user))}
		it {should have_link('Users', href: users_path)}
		it {should_not have_link('Sign in', href: signin_path)}
		describe "when signing out" do
			before { click_link 'Sign out'}
			it { should have_link('Sign in', href: signin_path)}
			it { should_not have_link('Users', href: users_path)}
		end
	end
end

# authorizing ----------------------------------

describe "authorization" do 

	describe "for non-signed-in visitors" do 
		let(:user) { FactoryGirl.create(:user) }

		describe "in the Users controller" do 

			describe "visiting the edit page" do 
				before {visit edit_user_path(user)}
				it_behaves_like "the sign in page"
			end

			describe "submitting to update user" do 
				before { put user_path(user) }
				specify { response.should redirect_to(signin_path) }
			end

			describe "visiting the user index" do 
				before {visit users_path}
				it_behaves_like "the sign in page"
			end

		end

		describe "in the Microposts controller" do 
			
			describe "creating a new micropost" do 
				before { post microposts_path }
				specify { response.should redirect_to(signin_path) }
			end

			describe "submitting to the destroy action" do 
				before do 
					micropost = FactoryGirl.create(:micropost)
					delete micropost_path(micropost)
				end
				specify { response.should redirect_to(signin_path) }
			end
		end

		describe "redirect after valid sign in" do
			before do 
				visit edit_user_path(user)
				fill_in "Email",  		with: user.email
				fill_in "Password",  	with: user.password
				click_button "Sign in"	
			end
			title_h1('Update your profile', 'Update your profile')	
		end
		
		describe "signed in as wrong user" do 
			let(:wrong_user) {FactoryGirl.create(:user, email: "wrong@gmail.com")}
			before { sign_in user}

			describe "trying to edit different users page" do
				before {visit edit_user_path(wrong_user)}
				it_behaves_like "the sign in page"
			end

			describe "trying to PUT to different user" do
				before { put user_path(wrong_user) }
				specify { response.should redirect_to(signin_path) }
			end
		end
	end
end

# end ----------------------------------

end
