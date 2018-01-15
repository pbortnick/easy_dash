class Subscription < ActiveRecord::Base
  belongs_to :customer
  has_many :subscription_items

end
