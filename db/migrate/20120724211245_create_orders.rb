class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :order_state_id, :null => false, :default => 1
      t.integer :user_id
      t.integer :delivery_id
      t.text    :comment

      t.timestamps
    end
  end
end
