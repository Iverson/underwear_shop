class AddStatusToOrderState < ActiveRecord::Migration
  def change
    add_column :order_states, :status, :string
  end
end
