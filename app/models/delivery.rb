class Delivery < ActiveRecord::Base
  attr_accessible :name, :price, :code
  has_many :orders
  
  validates :name, :presence => true
end
