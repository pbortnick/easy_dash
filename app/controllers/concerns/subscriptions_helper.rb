module SubscriptionsHelper

#subscribe to previously cancelled subscription
  def re_subscribe
    @subscription.status = 'active'
    @subscription.save
  end

#  update the subscription with new plan
  def add_plan
    Stripe::SubscriptionItem.create(
          subscription: @subscription.stripe_id,
          :plan => Stripe::Plan.create(
            :amount => @product.price,
            :interval => "month",
            :name => @product.name,
            :currency => "usd"
          ).id
      )
  end

  def create_subscription
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

  def create_plan
    @plan = Plan.create(:name => @product.name, :product_id => @product.id, :subscription_id => @subscription.id)
  end

    Subscription.create(:stripe_id => @subscription.id, :customer_id => @current_user.id, :category_id => @product.category_id, :status => 'active')
  end

  def create_subscription_item
    @subscription_item = Stripe::SubscriptionItem.create(
      :subscription => @subscription.id,
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

end
