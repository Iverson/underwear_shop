class AddMetroToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :metro, :string
  end
end
