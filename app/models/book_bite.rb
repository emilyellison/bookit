class BookBite < ActiveRecord::Base
  attr_accessible :bite
  belongs_to :user
  
  validates :user_id, presence: true
  validates :bite, presence: true, length: { maximum: 140 }
  
  default_scope order: 'book_bites.created_at DESC'
end
