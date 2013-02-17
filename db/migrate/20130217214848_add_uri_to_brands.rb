class AddUriToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :uri, :string
  end
end
