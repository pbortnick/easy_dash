require "stripe"

class SubscriptionItemsController < ApplicationController

  before_action :set_current_user

  def index
    @subscription_items = current_user.subscription_items
  end

  def create
    # create or update subscription_item in Stripe
    @subscription_item = Stripe::SubscriptionItem.create(
      :subscription => @subscription.stripe_id,
      :plan => Stripe::Plan.create(
        :amount => @product.price,
        :interval => "month",
        :name => @product.name,
        :currency => "usd"
      ).id,
      :quantity => 1,
    )
    SubscriptionItem.create(:stripe_id => @subscription_item.id, :subscription_id => @subscription.id, :product_id => @product.id)
    end
    redirect_to subscriptions_items_path
  end

  # cancel customer subscription without deleting subscription option
  private

  def set_current_user
    @current_user = current_user
  end

end
