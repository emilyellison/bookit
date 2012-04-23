require 'spec_helper'

describe BookPost do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @book_post = user.book_posts.build(title: 'Catch-22',
                                              subtitle: 'The Lost Oddysey',
                                              genre: 'Dystopian Comedy',
                                              summary: 'A story of madness.') }
  
  subject { @book_post }
  
  it { should respond_to(:title) }
  it { should respond_to(:subtitle) }
  it { should respond_to(:genre) }
  it { should respond_to(:summary) }
  it { should respond_to(:release_date) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user}
  
  it { should be_valid }
  
  describe 'accessible attributes' do
    it 'should not allow access to user_id' do
      expect do
        BookPost.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end  
  end
  
  describe 'when user_id is not present' do
    before { @book_post.user_id = nil }
    it { should_not be_valid }
  end
  
  describe 'when title is blank' do
    before { @book_post.title = ' ' }
    it { should_not be_valid }
  end
  
  describe 'with a title that is too long' do
    before { @book_post.title = 'a' * 51 }
    it { should_not be_valid }
  end
  
  describe 'with a sub-title that is too long' do
    before { @book_post.subtitle = 'a' * 51 }
    it { should_not be_valid }
  end
  
  describe 'with a genre that is too long' do
    before { @book_post.genre = 'a' * 31 }
    it { should_not be_valid }
  end
  
  describe 'when summary is blank' do
    before { @book_post.summary = ' ' }
    it { should_not be_valid }
  end
  
  describe 'with a summary that is too long' do
    before { @book_post.summary = 'a' * 141 }
    it { should_not be_valid }
  end
end
