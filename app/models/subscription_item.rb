class SubscriptionItem < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :product
  has_one :category, through: :product
end
