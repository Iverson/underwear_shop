class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.string :name
      t.decimal :price
      t.integer :count

      t.timestamps
    end
  end
end
