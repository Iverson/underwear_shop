class Order < ActiveRecord::Base
  attr_accessible :order_state_id
  
  belongs_to :order_state
  belongs_to :address
  has_many :order_items
end
