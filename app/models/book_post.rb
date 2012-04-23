class BookPost < ActiveRecord::Base
  attr_accessible :title, :subtitle, :genre, :summary, :date
  
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :subtitle, length: { maximum: 50 }
  validates :genre, length: { maximum: 30 }
  validates :summary, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  
  default_scope order: 'book_posts.created_at DESC'
end
