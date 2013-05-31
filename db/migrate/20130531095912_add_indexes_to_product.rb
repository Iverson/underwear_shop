class AddIndexesToProduct < ActiveRecord::Migration
  def change
    add_index :products, :section_id
    add_index :products, :brand_id
    add_index :products, :state_id
    add_index :products, :name
  end
end
