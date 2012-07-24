class AddCountryIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :country_id, :integer
  end
end
