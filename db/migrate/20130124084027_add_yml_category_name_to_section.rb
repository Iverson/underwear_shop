# coding: utf-8
class AddYmlCategoryNameToSection < ActiveRecord::Migration
  def change
    add_column :sections, :yml_category, :string, :null => false, :default => "Футболки"
  end
end
