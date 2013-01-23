class AddYmlCategoryToSection < ActiveRecord::Migration
  def change
    add_column :sections, :yml_parent_id, :integer
  end
end
