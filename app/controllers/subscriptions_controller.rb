require "stripe"

class SubscriptionsController < ApplicationController

  before_action :set_current_user
  before_action :set_product, only: [:create]
  before_action :set_subscription, only: [:create]


  def index
    @subscriptions = @current_user.subscriptions
  end

  def create
    set_product
    set_subscription
    # create or update subscription in Stripe
    # Locate specific subscription
    if @subscription && @subscription.status = 'canceled'
        @subscription.status = 'active'
        @subscription.save
    elsif @subscription && @subscription.status = 'active'
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

      Subscription.create(:stripe_id => @subscription.id, :customer_id => @current_user.id, :category_id => @product.category_id, :status => 'active')


    end

    redirect_to subscriptions_path
  end

  # cancel customer subscription without deleting subscription option
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
