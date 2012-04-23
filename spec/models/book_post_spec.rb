require 'spec_helper'

describe BookPost do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @book_post = user.book_posts.build(out_title: 'Catch-22',
                                             out_subtitle: 'The Lost Oddysey',
                                             out_genre: 'Dystopian Comedy',
                                             out_summary: 'A story of madness.') }
  
  subject { @book_post }
  
  it { should respond_to(:out_title) }
  it { should respond_to(:out_subtitle) }
  it { should respond_to(:out_genre) }
  it { should respond_to(:out_summary) }
  it { should respond_to(:out_date) }
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
    before { @book_post.out_title = ' ' }
    it { should_not be_valid }
  end
  
  describe 'with a title that is too long' do
    before { @book_post.out_title = 'a' * 51 }
    it { should_not be_valid }
  end
  
  describe 'with a sub-title that is too long' do
    before { @book_post.out_subtitle = 'a' * 51 }
    it { should_not be_valid }
  end
  
  describe 'with a genre that is too long' do
    before { @book_post.out_genre = 'a' * 31 }
    it { should_not be_valid }
  end
  
  describe 'when summary is blank' do
    before { @book_post.out_summary = ' ' }
    it { should_not be_valid }
  end
  
  describe 'with a summary that is too long' do
    before { @book_post.out_summary = 'a' * 141 }
    it { should_not be_valid }
  end
end
