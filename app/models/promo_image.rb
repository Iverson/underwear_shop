class PromoImage < ActiveRecord::Base
  attr_accessible :promo_id, :image
  belongs_to :promo
  
  has_attached_file :image,
                    :styles => { :slideshow => "300x400#" },
                    :url  => "/system/promo/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/promo/:id/:style/:basename.:extension"
                    
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 2.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
end
