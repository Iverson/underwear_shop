class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :section_id, :null => false
      t.integer :brand_id, :null => false
      t.decimal :price, :precision => 10, :scale => 2
      t.string :name, :null => false
      t.text :description
      t.integer :discount, :null => false, :default => 0
      t.integer :state_id, :null => false, :default => 2

      t.timestamps
    end
  end
end
