class AddTopToSections < ActiveRecord::Migration
  def change
    add_column :sections, :top, :integer, :null => false, :default => 0
  end
end
