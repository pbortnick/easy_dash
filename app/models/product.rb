class Product < ActiveRecord::Base
  belongs_to :category

  def image_path
    "dash_icons/#{self.category_name}/#{self.name}.jpg"
  end
  
  def category_name
    self.category.name
  end
  
end
