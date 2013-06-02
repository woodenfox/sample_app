require 'spec_helper'

describe "MicropostPages" do
  subject {page}

  let(:user) {FactoryGirl.create(:user)}
  before {sign_in user}

  describe "micropost creation" do 
    before {visit root_path}

    describe "with invalid information" do 

      it "should not create a micropost" do 
        expect {click_button "Post"}.should_not change(Micropost, :count)
    	end

      describe "error messages" do 
        before { click_button "Post"} 
        it {should have_content('error')}
     	end
        
      describe "with valid information" do
        before { fill_in 'micropost_content', with: "Lorium ipsum!"}
        it "should create micropost" do 
            expect { click_button "Post" }.should change(Micropost, :count).by(1)
        end
      end
  	end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user on homepage" do 
      before {visit root_path}

      it "should delete microposts" do 
        expect {click_link "Delete"}.should change(Micropost, :count).by(-1)
      end
    end

    describe "as correct user on profile" do 
      before {visit user_path(user)}

      it "should delete microposts" do 
        expect {click_link "Delete"}.should change(Micropost, :count).by(-1)
      end
    end
  end
end
