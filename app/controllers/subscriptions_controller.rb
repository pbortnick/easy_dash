require "stripe"

class SubscriptionsController < ApplicationController

  before_action :set_current_user
  before_action :set_product, only: [:create]
  before_action :set_subscription, only: [:create]


  def index
    @subscriptions = @current_user.subscriptions
  end

  def create
    # create or update subscription in Stripe
    # Locate specific subscription
    if @subscription
    #  update the subscription with new plan
      Stripe::SubscriptionItem.create(
            subscription: @subscription.stripe_id,
            :plan => Stripe::Plan.create(
              :amount => @product.price,
              :interval => "month",
              :name => @product.name,
              :currency => "usd"
            ).id
        )
    # else, create new subscription
    else
      @subscription = Stripe::Subscription.create(
      :customer => @current_user.stripe_id,
      :items => [
        {
          :plan => Stripe::Plan.create(
            :amount => @product.price,
            :interval => "month",
            :name => @product.name,
            :currency => "usd"
          ).id
        }
        ]
      )
      Subscription.create(:stripe_id => @subscription.id, :customer_id => @current_user.id, :category_id => @product.category_id)
    end

    redirect_to subscriptions_path
  end

  # cancel customer subscription without deleting subscription option
  def destroy
    @current_user.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(stripe_subscription_id: nil)

    redirect_to root_path, notice: "Your subscription has been canceled."
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
