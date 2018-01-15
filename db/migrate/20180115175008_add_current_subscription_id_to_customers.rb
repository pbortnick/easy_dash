class AddCurrentSubscriptionIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :current_subscription_id, :integer
  end
end
