class AddAncestryToSections < ActiveRecord::Migration
  def change
    add_column :sections, :ancestry, :string
    add_index :sections, :ancestry
  end
end
