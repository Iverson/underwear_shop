class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :order_state_id

      t.timestamps
    end
  end
end
