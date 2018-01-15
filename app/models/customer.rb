class Customer < ActiveRecord::Base

  has_many :subscriptions
  belongs_to :current_subscription, :class_name => "Subscription"

  def create_current_subscription
    new_subscription = subscriptions.create
    self.current_subscription_id = new_subscription.id
    save
  end

end
