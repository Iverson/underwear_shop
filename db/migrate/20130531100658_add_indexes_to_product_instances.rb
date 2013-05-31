class AddIndexesToProductInstances < ActiveRecord::Migration
  def change
    add_index :product_instances, :product_id
    add_index :product_instances, :state_id
  end
end
