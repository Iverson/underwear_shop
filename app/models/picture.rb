class Picture < ActiveRecord::Base
  attr_accessible :product_id, :image
  
  has_attached_file :image, 
                    :styles => { :medium => "300x300>", :small => "150x150>" },
                    :url  => "/system/products/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/products/:id/:style/:basename.:extension"
                    
  #validates_attachment_presence :photo
  #validates_attachment_size :photo, :less_than => 2.megabytes
  #validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
end
