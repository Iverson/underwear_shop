class AddIndexesToPictures < ActiveRecord::Migration
  def change
    add_index :pictures, :product_id
  end
end
