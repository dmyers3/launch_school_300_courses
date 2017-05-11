class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  
  has_secure_password validations: false
  
  validates :username, uniqueness: true, length: {minimum: 3}, presence: true
  validates :password, presence: true, on: :create, length: {minimum: 8}, confirmation: true
  
  before_save :slugify
  
  def slugify
    self.slug = self.username.downcase.gsub(' ', '-')
  end
  
  def to_param
    self.slug
  end
end