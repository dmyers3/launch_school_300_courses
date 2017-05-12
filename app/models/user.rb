class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  
  has_secure_password validations: false
  
  validates :username, uniqueness: true, length: {minimum: 3}, presence: true
  validates :password, presence: true, on: :create, length: {minimum: 8}, confirmation: true
  
  before_save :generate_unique_slug
  
  def slugify(username)
    str = username.strip
    str.gsub!(/\s*[^A-Za-z0-9]\s*/, '-')
    str.gsub!(/-+/, '-')
    str.downcase
  end
  
  def generate_unique_slug
    the_slug = slugify(self.username)
    user = User.find_by slug: the_slug
    count = 2
    while user && user != self
      unique_check_slug = the_slug + "-" + count.to_s
      user = User.find_by slug: unique_check_slug
      count += 1
    end
    
    self.slug = unique_check_slug || the_slug
  end
  
  def to_param
    self.slug
  end
end