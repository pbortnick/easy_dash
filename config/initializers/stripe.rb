Rails.application.config.stripe_publishable_key = ENV['STRIPE_PUBLISHABLE_KEY']
Rails.application.config.stripe_secret_key      = ENV['STRIPE_SECRET_KEY']


sub = Stripe::Subscription.retrieve(params[:subscription_id])
sub.delete

StripeEvent.configure do |events|
  events.subscribe "invoice.payment_failed" do |event|
    stripe_customer_id = user.event.data.object.customer
    user = User.find_by(stripe_id: stripe_customer_id)
    PaymentMailer.payment_failed(user).deliver_now if user
  end
end
