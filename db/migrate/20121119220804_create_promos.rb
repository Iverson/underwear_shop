class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string :name, :null => false
      t.decimal :price, :precision => 6, :scale => 2
      t.string :discount, :null => false, :default => 0
      t.text :text, :null => false
      t.integer :state_id, :null => false, :default => 2

      t.timestamps
    end
  end
end
