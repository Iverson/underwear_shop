class Picture < ActiveRecord::Base
  attr_accessible :product_id, :image
  belongs_to :product
  
  has_attached_file :image,
                    :styles => { 
                      :small => Proc.new { |instance| instance.resize(70, 105) },
                      
                      :medium => "160x240#",
                      :catalog => "120x180#", 
                      :detail => Proc.new { |instance| instance.resize(300, 450, :detail) },
                      :zoom => "600x800>"  
                    },
                    :url  => "/system/products/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/products/:id/:style/:basename.:extension"
                    
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 2.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
  
  def resize(width, height, flag=nil)     
    geo = Paperclip::Geometry.from_file(image.queued_for_write[:original].path)
    
    ratio = geo.width/geo.height  
    deltaX = 2
    deltaY = 1.2
    
    if flag == :detail
      deltaX = 1
      deltaY = 1.5
    end
    
    if ratio > 1
      # Horizontal Image
      width = width * deltaX
      height  = height/deltaY
    end
    
    "#{width.round}x#{height.round}#"
  end
end
