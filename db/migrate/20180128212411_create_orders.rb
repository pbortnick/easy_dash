class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :stripe_id
      t.integer :customer_id
    end
  end
end
