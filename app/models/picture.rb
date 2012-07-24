class Picture < ActiveRecord::Base
  attr_accessible :product_id, :image
  belongs_to :product
  
  has_attached_file :image, 
                    :styles => { :medium => "160x190#", :small => "50x50#" },
                    :url  => "/system/products/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/products/:id/:style/:basename.:extension"
                    
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 2.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
end
