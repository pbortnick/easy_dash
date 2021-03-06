class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.references :product, index: true, foreign_key: true
      t.references :subscription, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
