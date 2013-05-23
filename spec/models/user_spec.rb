# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

require 'spec_helper'

describe User do
		
	before do 
		@user = User.new(name: "Example Name", email: "user@email.com", 
	                    password: "mypassword", password_confirmation: "mypassword")
	end

	subject {@user}

	it {should respond_to(:name)}
	it {should respond_to(:email)}
	it {should respond_to(:password_digest)}
	it {should respond_to(:password)}
	it {should respond_to(:password_confirmation)}
	it {should respond_to(:remember_token)}
	it {should respond_to(:authenticate)}
	it {should respond_to(:admin)}
	it {should respond_to(:microposts)}

	it {should be_valid}
	it {should_not be_admin}

	describe "with admin attribute set to true" do 
		before {@user.toggle!(:admin) }	
		it {should be_admin}
	end

# micropost validation ---------------------------------

describe "micropost associations" do 
	before {@user.save}
	let!(:older_micropost) do 
		FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
	end
	let!(:newer_micropost) do 
		FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
	end

	it "should have microposts in the right order" do 
		@user.microposts.should == [newer_micropost, older_micropost]
	end

	it "should destroy associated microposts" do 
		microposts = @user.microposts
		@user.destroy
		microposts.each do |micropost|
			Micropost.find_by_id(micropost.id).should be_nil
		end
	end

	describe "status" do 
		let(:unfollowed_post) { FactoryGirl.create(:micropost, user: FactoryGirl.create(:user)) }
		its(:feed) {should include(newer_micropost)}
		its(:feed) {should include(older_micropost)}
		its(:feed) {should_not include(unfollowed_post)}
	end
end

# authentication validation specs -----------------------

describe "remember_token" do 
	before { @user.save}
	its(:remember_token) {should_not be_blank}
end

# name validation specs ----------------------------------

	describe "when name is not present" do
		before { @user.name = " "}
		it { should_not be_valid}
	end

	describe "when name is too long" do
		before { @user.name = "a" * 51}
		it { should_not be_valid}
	end

# email validation specs ---------------------------------

	describe "when email is not present" do
		before { @user.email = " "}
		it { should_not be_valid}
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			email_list = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
		
			email_list.each do |address|
				@user.email =   address
				@user.should_not be_valid
			end
		end
	end

	describe "when email format is valid" do	
		it "should be valid" do
			email_list = %w[woodenfox@gmail.com wooden.fox@gmail.org w+fox@gmail.cn w_fox@a9.jp]
			email_list.each do |address|
				@user.email = address
				@user.should be_valid
			end
		end
	end

	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.save
		end
		it { should_not be_valid}
	end


	describe "when email is uppercase" do
		subject {@user.email}
		before do 
			user_upcase_email = "WOODENFOX@GMAIL.COM"
			@user.email = user_upcase_email
			@user.save
		end
		it { should match("woodenfox@gmail.com") }
	end

# password validation specs ----------------------------

	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid}
	end

	describe "when pasword doesn't match password_confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it {should_not be_valid}
	end

	describe "when password_confirmation is nil" do
		before { @user.password_confirmation = nil }
		it {should_not be_valid}
	end

	describe "with a password that is too short" do
		before {@user.password = @user.password_confirmation = "a"*5}
		it { should_not be_valid}
	end

# I don't understand the below... it checks the success of the authentication method

	describe "return value of authenticate method" do 
		before {@user.save}
		let(:found_user) {User.find_by_email(@user.email)}

		describe "with valid password" do 
			it { should == found_user.authenticate(@user.password)}
		end

		describe "with invalid password" do 	
			let(:user_for_invalid_password) {found_user.authenticate("invalid")}

			it {should_not == user_for_invalid_password}
			specify { user_for_invalid_password.should be_false}
		end
	end	

#END OF SPEC
end
