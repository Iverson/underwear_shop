class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :iso, :null => false
      t.string :name, :null => false
      t.string :name_en, :null => false
      t.integer :_order, :null => false, :default => 0
      t.integer :independent, :null => false, :default => 1
    end
  end
end
