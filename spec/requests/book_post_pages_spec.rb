require 'spec_helper'

describe "book post pages" do
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe 'book post creation' do
    before { visit root_path }
    
    describe 'with invalid information' do
      it 'should not create a book post' do
        expect { click_button 'Post' }.should_not change(BookPost, :count)
      end
      
      describe 'error messages' do
        before { click_button 'Post' }
        it { should have_content('error') }
      end
    end
    
    describe 'with valid information' do
      before do
        fill_in "Title",   with: 'Lorem ipsum'
        fill_in "Summary", with: 'Lorem ipsum'
   
      end
      it 'should create a book post' do
        expect { click_button 'Post' }.should change(BookPost, :count).by(1)
      end
    end
  end
  
  describe 'book post destruction' do
    before { FactoryGirl.create(:book_post, user: user ) }
    
    describe 'as correct user' do
      before { visit root_path }
      
      it 'should delete a book post' do
        expect { click_link 'Delete' }.should change(BookPost, :count).by(-1)
      end
    end  
  end
end
