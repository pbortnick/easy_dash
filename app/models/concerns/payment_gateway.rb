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
end