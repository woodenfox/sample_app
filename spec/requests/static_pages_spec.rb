require 'spec_helper'
describe "Static pages" do

	let(:base_title) {'UX Angels'}
	subject {page}

	describe "Home page" do
		before {visit root_path}
		it { should have_selector('h1', text: 'Sample App')}
    	it { should have_selector('title', :text => 'UX Angels')}
   		it { should have_selector('footer')}
   		it { should have_selector('header')}
	end

	describe "Help Page" do
		before {visit help_path}
		it { should have_selector('h1', text: 'Help')}
		it { should have_selector('title', text: 'UX Angels | Help')}
	end   

	describe "About Page" do
		before {visit about_path}
		it {should have_selector('h1', text: 'About Us')}
		it {should have_selector('title', text: 'UX Angels | About Us')}
	end

	describe "Contact Us" do
		it "should have the text 'Contact Us' visibile" do
			visit contact_path
			page.should have_selector('h1',
				:text => 'Contact Us')
		end
		it "should have right title" do
			visit contact_path
			page.should have_selector('title', 
				:text => 'UX Angels | Contact Us')
		end
	end
end
