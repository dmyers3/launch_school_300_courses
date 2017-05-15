module Sluggable
  extend ActiveSupport::Concern
  
  included do
    before_save :generate_unique_slug
    class_attribute :slug_property
    
  end
  
  def slugify(property)
    str = property.strip
    str.gsub!(/\s*[^A-Za-z0-9]\s*/, '-')
    str.gsub!(/-+/, '-')
    str.downcase
  end
  
  def generate_unique_slug
    the_slug = slugify(self.send(self.class.slug_property.to_sym))
    obj_matching_slug = self.class.find_by slug: the_slug
    count = 2
    while obj_matching_slug && obj_matching_slug != self
      unique_check_slug = the_slug + "-" + count.to_s
      obj_matching_slug = self.class.find_by slug: unique_check_slug
      count += 1
    end
    self.slug = unique_check_slug || the_slug
  end
  
  def to_param
    self.slug
  end
  
  module ClassMethods
    def sluggable_property(property)
      self.slug_property = property
    end
  end
end