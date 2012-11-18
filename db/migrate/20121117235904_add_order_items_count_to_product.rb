class AddOrderItemsCountToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :order_items_count, :integer, :default => 0

    Product.reset_column_information
    Product.find(:all).each do |p|
      Product.update_counters p.id, :order_items_count => p.order_item.length
    end
  end

  def self.down
    remove_column :products, :order_items_count
  end
end
