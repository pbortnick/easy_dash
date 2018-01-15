class SubscriptionItemsController < ApplicationController
  def create
    current_user.create_current_subscription
    subscription_item = current_user.current_subscription.add_product(params[:product_id])

    redirect_to subscription_path(current_user.current_subscription), {notice: 'Subscription Added!'}

  end
end
