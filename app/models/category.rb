class Category < ActiveRecord::Base
  has_many :products
  has_one :subscription
end
