class AddAttachmentImageToPromoImages < ActiveRecord::Migration
  def self.up
    change_table :promo_images do |t|
      t.has_attached_file :image
    end
  end

  def self.down
    drop_attached_file :promo_images, :image
  end
end
