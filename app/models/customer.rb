class Customer < ActiveRecord::Base

  has_many :subscriptions
  has_many :subscription_items, through: :subscriptions
  has_many :orders

end
