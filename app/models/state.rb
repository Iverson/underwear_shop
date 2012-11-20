class State < ActiveRecord::Base
  attr_accessible :name
  
  has_many :products
  has_many :promos
end
