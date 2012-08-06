class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :order_state_id, :null => false, :default => 1
      t.integer :address_id
      t.integer :user_id

      t.timestamps
    end
  end
end
