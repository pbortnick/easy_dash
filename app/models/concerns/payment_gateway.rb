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

  def self.create_subscription(subscription)
    begin
      Stripe::Plan.create(
        :amount => plan.subscription.product.price,
        :interval => "month",
        :name => plan.subscription.product.name,
        :currency => "usd",
        :id => plan.subscription.ame
      )
    rescue => e
      puts "EXCEPTION: #{e.message}"
    end
  end

end
