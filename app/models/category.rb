class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories
  
  validates :name, presence: true, uniqueness: true
  
  before_save :generate_unique_slug
  
  def slugify(name)
    str = name.strip
    str.gsub!(/\s*[^A-Za-z0-9]\s*/, '-')
    str.gsub!(/-+/, '-')
    str.downcase
  end
  
  def generate_unique_slug
    the_slug = slugify(self.name)
    category = Category.find_by slug: the_slug
    count = 2
    while category && category != self
      unique_check_slug = the_slug + "-" + count.to_s
      category = Category.find_by slug: unique_check_slug
      count += 1
    end
    self.slug = unique_check_slug || the_slug
  end
  
  def to_param
    self.slug
  end
end