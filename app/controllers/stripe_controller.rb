class StripeController < ApplicationController

  protect_from_forgery except: :webhook

  def webhook
    StripeEvent.configure do |events|
      events.all do |event|
        if event.type == 'invoice.payment_succeeded'
          Order.create(:stripe_id => id, :customer_id => current_user.id)
        end
      end
    end
  end



end
