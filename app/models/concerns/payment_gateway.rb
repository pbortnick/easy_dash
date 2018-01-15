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

  def self.create_customer(customer)
    begin
      Stripe::Customer.create(
        :description => "Sample",
        :source => "tok_amex"
      )
    rescue => e
      puts "EXCEPTION: #{e.message}"
    end
  end

  def self.create_subscription
    begin
      Stripe::Subscription.create(
        :customer => current_customer.id,
        :items => [
          {
            :plan => "ruby-elite-206",
          },
        ]
      )
    rescue => e
      puts "EXCEPTION: #{e.message}"
    end
  end


end
