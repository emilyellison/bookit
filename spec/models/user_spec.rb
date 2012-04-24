require 'spec_helper'

describe User do

  before { @user = User.new(name: 'Example McTest', email: 'example@test.com',
                            password: 'foobar', password_confirmation: 'foobar' ) }
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:writer) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:book_posts) }
  it { should respond_to(:book_bites) }
  it { should respond_to(:feed) }
  
  it { should be_valid }
  it { should_not be_admin }
  
  describe 'with admin attribute set to true' do
    before { @user.toggle!(:admin) }
    it { should be_admin }
  end
  
  describe 'when name is not present' do
    before { @user.name = ' ' }
    it { should_not be_valid }
  end
  
  describe 'when name is too long' do
    before { @user.name = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when e-mail is not present' do
    before { @user.email = ' ' }
    it { should_not be_valid }
  end
  
  describe 'when e-mail is too long' do
    before { @user.email = "#{'a' *43}@aol.com"}
    it { should_not be_valid }
  end
  
  describe 'when e-mail format is invalid' do
    it 'should be invalid' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end
  
  describe 'when e-mail format is valid' do
    it 'should be valid' do
      addresses = %w[user@foo.com A_USER@f.b.org first.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end
  
  describe 'when e-mail address is already taken' do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end
  
  describe 'when password is not present' do
    before { @user.password = @user.password_confirmation = ' ' }
    it { should_not be_valid }
  end
  
  describe 'when passwords don\'t match' do
    before { @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end
  
  describe 'when password confirmation is nil' do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe 'with a password that\'s too short' do
    before { @user.password = @user.password_confirmation = 'a' * 5 }
    it { should_not be_valid }
  end
  
  describe 'return value of authenticate method' do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }
    
    describe 'with valid password' do
     it { should == found_user.authenticate(@user.password) }
    end
    
    describe 'with invalid password' do
      let(:user_for_invalid_password) { found_user.authenticate('invalid') }
      
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  
  end
  
  describe 'remember token' do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe 'book post associations' do
    before { @user.save }
    let!(:older_book_post) do 
      FactoryGirl.create(:book_post, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_book_post) do
      FactoryGirl.create(:book_post, user: @user, created_at: 1.hour.ago)
    end  
    
    it 'should have the right book posts in the right order' do
      @user.book_posts.should == [newer_book_post, older_book_post]
    end
    
    it 'should destroy associated book posts' do
      book_posts = @user.book_posts
      @user.destroy
      book_posts.each do |book_post|
        BookPost.find_by_id(book_post.id).should be_nil
      end
    end
    
    describe 'status' do
      let(:unfollowed_post) do
        FactoryGirl.create(:book_post, user: FactoryGirl.create(:user))
      end  
      
      its(:feed) { should include(newer_book_post) }
      its(:feed) { should include(older_book_post) }
      its(:feed) { should_not include(unfollowed_post) }
    end
  end
  
  describe "book bite associations" do

    before { @user.save }
    let!(:older_book_bite) do 
      FactoryGirl.create(:book_bite, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_book_bite) do
      FactoryGirl.create(:book_bite, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right book bites in the right order" do
      @user.book_bites.should == [newer_book_bite, older_book_bite]
    end
    
    it "should destroy associated book bites" do
      book_bites = @user.book_bites
      @user.destroy
      book_bites.each do |book_bite|
        BookBite.find_by_id(book_bite.id).should be_nil
      end
    end
  end

end
