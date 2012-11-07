class CreateProductInstances < ActiveRecord::Migration
  def change
    create_table :product_instances do |t|
      t.integer :product_id
      t.string :size
      t.string :color
      t.integer :count
      t.integer :state_id

      t.timestamps
    end
  end
end
