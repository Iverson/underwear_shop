class ProductInstance < ActiveRecord::Base
  attr_accessible :color, :count, :product_id, :size, :state_id
  
  belongs_to :product
  
  validates :size, :presence => true
  validates :count, :presence => true
end
