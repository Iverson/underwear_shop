class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :iso, :null => false
      t.string :name, :null => false

      t.timestamps
    end
  end
end
