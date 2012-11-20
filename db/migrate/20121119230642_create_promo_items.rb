class CreatePromoItems < ActiveRecord::Migration
  def change
    create_table :promo_items do |t|
      t.integer :promo_id, :null => false
      t.integer :product_id, :null => false
      t.integer :count, :null => false, :default => 1

      t.timestamps
    end
  end
end
