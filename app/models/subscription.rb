class Subscription < ActiveRecord::Base
  belongs_to :customer
  has_many :subscription_items
  belongs_to :category

end
