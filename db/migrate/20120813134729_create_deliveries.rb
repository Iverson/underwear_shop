class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :name, :null => false
      t.decimal :price, :precision => 6, :scale => 2, :null => false, :default => 0

      t.timestamps
    end
  end
end
