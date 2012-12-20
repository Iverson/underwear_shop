class OrderState < ActiveRecord::Base
  attr_accessible :name, :status
  
  has_many :orders
end
