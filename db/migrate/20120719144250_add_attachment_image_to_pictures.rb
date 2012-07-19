class AddAttachmentImageToPictures < ActiveRecord::Migration
  def self.up
    change_table :pictures do |t|
      t.has_attached_file :image
    end
  end

  def self.down
    drop_attached_file :pictures, :image
  end
end
