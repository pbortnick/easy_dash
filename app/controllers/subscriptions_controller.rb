class SubscriptionsController < ApplicationController

  before_action :set_current_user

  

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
