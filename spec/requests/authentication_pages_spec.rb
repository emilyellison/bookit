require 'spec_helper'

describe 'Authentication' do
  
  subject { page }
  
  describe "sign-in page" do
    before { visit signin_path }
    
    it { should have_selector('h1', text: 'Sign In') }
    it { should have_selector('title', text: 'BookFollow | Sign In') }
  
  end
  
  describe 'sign-in' do
    before { visit signin_path }
    
    describe 'with invalid information' do
      before { click_button 'Sign In' }
      
      it { should have_selector('title', text: 'Sign In') }
      it { should have_selector('div.alert.alert-error', text: 'invalid') }
    
      describe 'after visiting another page' do
        before { click_link 'Home' }
        it { should_not have_selector('div.alert.alert-error')}
      end
    end
    
    describe 'with valid information' do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }
      
      it { should have_selector('title', text: user.name) }
      it { should have_link('Members', href: users_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Update Your Profile', href: edit_user_path(user)) }
      it { should have_link('Sign Out', href: signout_path) }
      it { should_not have_link('Sign In', href: signin_path) }
      
      describe 'followed by sign-out' do
        before { click_link 'Sign Out' }
        it { should have_link('Sign In') }
      end
    end
  end
  
  describe 'authorization' do
    
    describe 'for non-signed-in users' do
      let(:user) { FactoryGirl.create(:user) }
      
      describe 'when attempting to visit a protected page' do
        before do
          visit edit_user_path(user)
          fill_in 'E-mail', with: user.email
          fill_in 'Password', with: user.password
          click_button 'Sign In'
        end
        
        describe 'after signing in' do
          it 'should render the desired protected page' do
            page.should have_selector('title', text: 'Update Your Profile')
          end
        end
      end
      
      describe 'in the users controller' do
        before { visit edit_user_path(user) }
        it { should have_selector('title', text: 'Sign In') }
        
        describe 'visiting the users index' do
          before { visit users_path }
          it { should have_selector('title', text: 'Sign In')}
        end
      end
      
      describe 'submitting to the update action' do
        before { put user_path(user) }
        specify { response.should redirect_to(signin_path) }
      end
      
      describe 'in the book posts controller' do
        
        describe 'submitting to the create action' do
          before { post book_posts_path }
          specify { response.should redirect_to(signin_path) }
        end
        
        describe 'submitting to the destroy action' do
          before do
            book_post = FactoryGirl.create(:book_post)
            delete book_post_path(book_post)
          end
          specify { response.should redirect_to(signin_path) }
        end  
      end
      
    end
    
    describe 'as wrong user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@example.com') }
      before { sign_in user }
      
      describe 'visiting users#edit page' do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: 'Update Your Profile') }
      end
      
      describe 'submitting a PUT request to the users#update action' do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end  
    end
    
    describe 'as non-admin user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
      
      before { sign_in non_admin }
      
      describe 'submitting a DELETE request to the users#destroy action' do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) } 
      end
    end
  end
end
