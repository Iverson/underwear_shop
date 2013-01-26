class ChangeAddressColumnsNullable < ActiveRecord::Migration
  def up
    change_column :addresses, :address, :string, :null => true
    change_column :addresses, :city, :string, :null => true
  end

  def down
    change_column :addresses, :address, :string, :null => false
    change_column :addresses, :city, :string, :null => false
  end
end
