class AddCanSendEmailToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :can_send_email, :boolean, :null => false, :default => true
  end
end
