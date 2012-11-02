class Brand < ActiveRecord::Base
  attr_accessible :name
  
  has_many :products
  
  validates :name, :presence => true
end
