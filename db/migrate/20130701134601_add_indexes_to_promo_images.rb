class AddIndexesToPromoImages < ActiveRecord::Migration
  def change
    add_index :promo_images, :promo_id
  end
end
