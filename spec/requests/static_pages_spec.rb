require 'spec_helper'

describe "Static pages" do

	subject {page}

	shared_examples_for "all static pages" do
		it { should have_selector('h1', text: heading)}
		it { should have_selector('title', text: page_title) }
	    it { should have_selector('footer')}
   		it { should have_selector('header')}
	end

	describe "Home page" do
		before {visit root_path}
		let(:heading) {'Welcome to UX Angels'}
    	let(:page_title) {'UX Angels'}
    	it_should_behave_like "all static pages"
    	it {should_not have_selector 'title', text: '| Home'}
    end

	describe "Help Page" do
		before {visit help_path}
		let(:heading) {'Help'}
		let(:page_title) {'UX Angels | Help'}
    	it_should_behave_like "all static pages"
	end   

	describe "About Page" do
		before {visit about_path}
		let(:heading) {'About Us'}
		let(:page_title) {'UX Angels | About Us'}
		it_should_behave_like "all static pages"		
	end

	describe "Contact Us" do
		before {visit contact_path}
		let(:heading) {'Contact Us'}
		let(:page_title) {'UX Angels | Contact Us'}
		it_should_behave_like "all static pages"
	end
end
