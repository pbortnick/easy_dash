require "stripe"

class SubscriptionsController < ApplicationController

  before_action :set_current_user

  def index
    @subscriptions = current_user.subscriptions
  end

  def create
    # create or update subscription in Stripe
    if current_customer.subscription.exists?
    # update the subscription with new plan
      @subscription = Stripe::Subscription.retrieve({SUBSCRIPTION_ID})
      @subscription.plans.push( Plan.find_by(product_id: product_id]))
      @subscription.save
    #else, create new subscription
    else
      @subscription = Stripe::Subscription.create(
      :customer => current_customer,
      :items => [
        {
          :plan => Plan.find_by(product_id: product_id]),
        },
        ]
      )
    end
    redirect_to subscriptions_path
  end
  # def destroy
  #   customer = Stripe::Customer.retrieve(current_user.stripe_id)
  #   customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
  #   current_user.update(stripe_subscription_id: nil)
  #
  #   redirect_to root_path, notice: "Your subscription has been canceled."
  # end

  private

  def set_current_user
    @current_user = current_user
  end

end
