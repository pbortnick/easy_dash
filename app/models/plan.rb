class Plan < ActiveRecord::Base
  belongs_to :product
  
  after_create :create_plan_on_payment_gateway
  
  
  def create_plan_on_payment_gateway
    PaymentGateway.create_plan(self)
  end
    
  
end
