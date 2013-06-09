class AddTopToProducts < ActiveRecord::Migration
  def change
    add_column :products, :top, :integer, :null => false, :default => 0
  end
end
