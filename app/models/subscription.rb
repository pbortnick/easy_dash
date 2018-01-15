class Subscription < ActiveRecord::Base
  belongs_to :customer
  has_many :subscription_items
  has_many :products, through: :subscription_items

  def add_product(product_id)
    if product_ids.include?(product_id.to_i)
      current_subscription_item = subscription_items.find_by(product_id: product_id)
      current_subscription_item
    else
      subscription_items.build(product_id: product_id)
    end
  end

end
