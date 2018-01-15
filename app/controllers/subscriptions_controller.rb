class SubscriptionsController < ApplicationController
  def show
    @subscription = Subscription.find(params[:id])
  end

  def checkout
    subscription = Subscription.find(params[:id])
    subscription.checkout
    redirect_to subscription_path(subscription)
  end
end
