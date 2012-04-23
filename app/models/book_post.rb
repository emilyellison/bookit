class BookPost < ActiveRecord::Base
  attr_accessible :out_title, :out_subtitle, :out_genre, :out_summary, :out_date
  
  belongs_to :user
  
  validates :out_title, presence: true, length: { maximum: 50 }
  validates :out_subtitle, length: { maximum: 50 }
  validates :out_genre, length: { maximum: 30 }
  validates :out_summary, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  
  default_scope order: 'book_posts.created_at DESC'
end
