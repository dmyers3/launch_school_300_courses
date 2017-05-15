class User < ActiveRecord::Base
  include Sluggable
  
  has_many :posts
  has_many :comments
  has_many :votes
  
  has_secure_password validations: false
  
  validates :username, uniqueness: true, length: {minimum: 3}, presence: true
  validates :password, presence: true, on: :create, length: {minimum: 8}, confirmation: true
  
  sluggable_property :username
  
  def admin?
    self.role == 'admin'
  end
  
  def creator?(obj)
    obj.creator == self
  end
end