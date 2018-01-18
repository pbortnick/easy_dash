require "stripe"

class SubscriptionItemsController < ApplicationController

  before_action :set_current_user

  def index
    @subscription_items = current_user.subscription_items
  end

  def create
    # create or update subscription_item in Stripe
    if @current_user.subscription_items.exists?
    # update the subscription_item with new plan
      @subscription_item = Stripe::SubscriptionItem.retrieve(params[:subscription_item_id])
      @subscription_item.plan = @subscription_item.product.plan
      @subscription_item.save
    #else, create new subscription_item
    else
      @subscription_item = Stripe::SubscriptionItem.create(
        :subscription_item => SubscriptionItem.find_by(subscription_item_id: subscription_item_id),
        :plan => Plan.find_by(product_id: product_id)
      )
    end
    redirect_to subscriptions_items_path
  end

  # cancel customer subscription without deleting subscription option
  private

  def set_current_user
    @current_user = current_user
  end

end
