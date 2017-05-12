class Post < ActiveRecord::Base
  include Voteable
  
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  
  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  
  before_save :generate_unique_slug
  
  def slugify(title)
    str = title.strip
    str.gsub!(/\s*[^A-Za-z0-9]\s*/, '-')
    str.gsub!(/-+/, '-')
    str.downcase
  end
  
  def generate_unique_slug
    the_slug = slugify(self.title)
    post = Post.find_by slug: the_slug
    count = 2
    while post && post != self
      unique_check_slug = the_slug + "-" + count.to_s
      post = Post.find_by slug: unique_check_slug
      count += 1
    end
    self.slug = unique_check_slug || the_slug
  end
  
  def to_param
    self.slug
  end
end