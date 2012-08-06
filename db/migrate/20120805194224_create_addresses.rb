class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :address, :null => false
      t.string :city, :null => false
      t.string :phone, :null => false
      t.string :fio, :null => false

      t.timestamps
    end
  end
end
