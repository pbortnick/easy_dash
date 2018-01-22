require "stripe"

class SubscriptionsController < ApplicationController

  before_action :set_current_user

  def index
    @subscriptions = @current_user.subscriptions
  end

  def create
    # create or update subscription in Stripe
    if @current_user.subscriptions.exists?
    # update the subscription with new plan
      @subscription = Stripe::Subscription.retrieve(@current_user.subscription.stripe_id)
      # @subscription.push(:plan => Product.find(params[:product_id]))
      @subscription.save
    #else, create new subscription
    else
      @subscription = Stripe::Subscription.create(
      :customer => @current_user.stripe_id,
      :items => [
        {
          # :plan => Plan.find(params[:id]).plan
          :plan => Plan.find(params[:product_id])
        },
        ]
      )
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

  def set_current_user
    @current_user = current_user
  end

end
