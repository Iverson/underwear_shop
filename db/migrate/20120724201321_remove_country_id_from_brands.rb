class RemoveCountryIdFromBrands < ActiveRecord::Migration
  def up
    remove_column :brands, :country_id
  end

  def down
    add_column :brands, :country_id, :integer
  end
end
