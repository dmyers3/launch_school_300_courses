class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories
  
  validates :name, presence: true
  
  before_save :slugify
  
  def slugify
    self.slug = self.name.downcase.gsub(' ', '-')
  end
  
  def to_param
    self.slug
  end
end