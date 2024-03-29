require 'spec_helper'

describe BookBite do

  let(:user) { FactoryGirl.create(:user) }
  before { @book_bite = user.book_bites.build(bite: "Lorem ipsum") }

  subject { @book_bite }

  it { should respond_to(:bite) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        BookBite.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @book_bite.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @book_bite.bite = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @book_bite.bite = "a" * 141 }
    it { should_not be_valid }
  end

end
