class SubscriptionItemsController < ApplicationController

  before_action :set_current_user

  def index
    @subscription_items = SubscriptionItem.all
  end

  def create
    current_user.create_current_subscription
    subscription_item = current_user.current_subscription.add_product(params[:product_id])

    redirect_to subscription_path(current_user.current_subscription), {notice: 'Subscription Added!'}

  end

  private

  def set_current_user
    @current_user = current_user
  end

end
