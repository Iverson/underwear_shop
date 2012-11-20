class AddPromoIdToPromoImages < ActiveRecord::Migration
  def change
    add_column :promo_images, :promo_id, :integer
  end
end
