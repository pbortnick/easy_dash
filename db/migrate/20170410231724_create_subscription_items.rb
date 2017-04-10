class CreateSubscriptionItems < ActiveRecord::Migration
  def change
    create_table :subscription_items do |t|
      t.string :stripe_id
      t.references :subscription, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
