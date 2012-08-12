class AddEmailToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :email, :string
  end
end
