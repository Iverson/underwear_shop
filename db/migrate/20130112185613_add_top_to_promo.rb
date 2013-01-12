class AddTopToPromo < ActiveRecord::Migration
  def change
    add_column :promos, :top, :boolean, :null => false, :default => false
  end
end
