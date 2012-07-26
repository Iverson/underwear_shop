class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name, :null => false
      t.integer :country_id

      t.timestamps
    end
  end
end
