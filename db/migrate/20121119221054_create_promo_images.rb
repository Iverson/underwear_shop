class CreatePromoImages < ActiveRecord::Migration
  def change
    create_table :promo_images do |t|

      t.timestamps
    end
  end
end
