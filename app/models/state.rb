class State < ActiveRecord::Base
  attr_accessible :name, :status
  
  has_many :products
  has_many :promos
end
