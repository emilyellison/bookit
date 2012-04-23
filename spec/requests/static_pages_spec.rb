require 'spec_helper'

describe "static pages" do
  subject { page }
  
  describe "home page" do
    before { visit root_path }
    
    it { should have_selector('h1', text: 'Welcome to BookFollow.') }
    it { should have_selector('title', text: 'BookFollow') }
    
  end
  
  describe 'help page' do
    before { visit help_path }
    
    it { should have_selector('h1', text: 'Help') }
    it { should have_selector('title', text: 'BookFollow | Help') }
    
  end
  
  describe 'about page' do
    before { visit about_path }
    
    it { should have_selector('h1', text: 'About') }
    it { should have_selector('title', text: 'BookFollow | About') }
    
  end
  
  it 'should have the right links on the layout' do
    visit root_path
    click_link 'About'
    page.should have_selector 'h1', text: 'About'
    click_link 'Help'
    page.should have_selector 'h1', text: 'Help'
    click_link 'Home'
    page.should have_selector 'h1', text: 'Welcome to BookFollow.'
  end
  
  describe 'for signed-in users' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      FactoryGirl.create(:book_post, user: user, title: 'Lorem ipsum', summary: 'Ipsum lorem' )
      FactoryGirl.create(:book_post, user: user, title: 'Dolor sit amet', summary: 'Sit dolor amet' )
      sign_in user
      visit root_path
    end  
    
    it 'should render the user\'s feed' do
      user.feed.each do |item|
        page.should have_selector("li##{item.id}", text: item.title)
      end  
    end
  end  
end