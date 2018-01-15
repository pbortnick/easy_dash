class SubscriptionsController < ApplicationController

  before_action :set_current_user

  def create
      customer =
      if current_user.stripe_id?
        Stripe::Customer.retrieve(current_user.stripe_id)
      else
       Stripe::Customer.create(email: current_user.email)
      end

      subscription = customer.subscriptions.create(
        source: params[:stripeToken],
        plan: "monthly"
      )

      options = {
        stripe_id: customer.id,
        stripe_subscription_id: subscription.id,
      }

      current_user.update(options)

      redirect_to root_path
    end



  # def index
  #   @subscriptions = Subscription.all
  # end
  #
  def show
    @subscription = Subscription.find(params[:id])
  end

  # def checkout
  #   subscription = Subscription.find(params[:id])
  #   subscription.checkout
  #   redirect_to subscription_path(subscription)
  # end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(stripe_subscription_id: nil)

    redirect_to root_path, notice: "Your subscription has been canceled."
  end

  private

  def set_current_user
    @current_user = current_user
  end

end
