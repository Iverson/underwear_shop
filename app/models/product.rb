class Product < ActiveRecord::Base
  attr_accessible :brand_id, :description, :discount, :name, :price, :purchaise_price, :section_id, :state_id, :pictures_attributes
  has_many :pictures, :dependent => :destroy
  
  accepts_nested_attributes_for :pictures, :allow_destroy => true
end
