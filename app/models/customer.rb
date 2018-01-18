class Customer < ActiveRecord::Base

  has_many :subscriptions
  belongs_to :current_subscription, :class_name => "Subscription"

end
