require "stripe"

class SubscriptionsController < ApplicationController
  include SubscriptionsHelper

  before_action :set_current_user

  def index
    @subscriptions = @current_user.subscriptions
    @plans = Plan.all
  end

  def create
    set_product
    set_subscription
    # create or update subscription in Stripe and database
    # Locate specific subscription
    if @subscription && @subscription.status = 'canceled'
      re_subscribe
    elsif @subscription && @subscription.status = 'active'
      add_plan
    else
      create_subscription
      create_plan
      create_subscription_item
    end

    redirect_to subscriptions_path
  end

  # cancel customer subscription without deleting subscription
  def destroy
    @subscription = Subscription.find(params[:id])

    @subscription.status = 'canceled'

    redirect_to subscriptions_path, notice: "Your #{@subscription.category.name} subscription has been canceled."
    @subscription.save
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_subscription
    @subscription = @current_user.subscriptions.find_by(:category_id => @product.category_id)
  end

  def set_current_user
    @current_user = current_user
  end

end
