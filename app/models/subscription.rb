class Subscription < ActiveRecord::Base
  belongs_to :customer
  has_many :subscription_items
  belongs_to :category
  has_many :plans
  has_many :products, through: :subscription_items

end
