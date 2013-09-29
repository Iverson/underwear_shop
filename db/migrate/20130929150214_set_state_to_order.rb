class SetStateToOrder < ActiveRecord::Migration
  def up
    Order.all.each do |order|
      order.update_column(:state, order.order_state.status)
    end
  end

  def down
    Order.all.each do |order|
      order.update_column(:state, nil)
    end
  end
end
