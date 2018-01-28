class PaymentGateway
  def self.create_plan(plan)
    begin
      Stripe::Plan.create(
        :amount => plan.product.price,
        :interval => "month",
        :name => plan.product.name,
        :currency => "usd",
        :id => plan.name
      )
    rescue => e
      puts "EXCEPTION: #{e.message}"
    end
  end

  # def self.create_subscription(plan)
  #   begin
  #     Stripe::Subscription.create(
  #       :customer => current_customer.stripe_id,
  #       :items => [
  #         {
  #           :plan => "#{plan.name}",
  #         },
  #       ]
  #     )
  #   rescue => e
  #     puts "EXCEPTION: #{e.message}"
  #   end
  # end


end
