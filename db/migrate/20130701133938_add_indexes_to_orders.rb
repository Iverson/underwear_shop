class AddIndexesToOrders < ActiveRecord::Migration
  def change
    add_index :orders, :order_state_id
    add_index :orders, :user_id
    add_index :orders, :delivery_id
  end
end
