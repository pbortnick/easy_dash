class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :stripe_id
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
