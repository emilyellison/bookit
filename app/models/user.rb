class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :city, :state, :writer
  has_secure_password
  has_many :book_posts, dependent: :destroy
  has_many :book_bites, dependent: :destroy
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  def feed
    BookPost.where("user_id = ?", id)
  end
  
  private 
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
