require 'spec_helper'
describe "Static pages" do

	let(:base_title) {'UX Angels'}

	describe "Home page" do
 		it "should have the content 'Sample App'" do
 			visit '/static_pages/home'
 			page.should have_selector('h1', 
 				:text =>'Sample App')
    	end
    	it "should have right title" do
    		visit '/static_pages/home'
    		page.should have_selector('title', 
    			:text => 'UX Angels')
   		end
	end
	describe "Help Page" do
		it "should have the text 'Help' visibile" do
			visit '/static_pages/help'
			page.should have_selector('h1',
				:text => 'Help')
		end
		it "should have right title" do
			visit '/static_pages/help'
			page.should have_selector('title', 
				:text => 'UX Angels | Help')
		end
	end   
	describe "About Page" do
		it "should have the text 'About Us' visibile" do
			visit '/static_pages/about'
			page.should have_selector('h1',
				:text => 'About Us')
		end
		it "should have right title" do
			visit '/static_pages/about'
			page.should have_selector('title', 
				:text => 'UX Angels | About Us')
		end
	end
	describe "Contact Us" do
		it "should have the text 'Contact Us' visibile" do
			visit '/static_pages/contact'
			page.should have_selector('h1',
				:text => 'Contact Us')
		end
		it "should have right title" do
			visit '/static_pages/contact'
			page.should have_selector('title', 
				:text => 'UX Angels | Contact Us')
		end
	end
end
