class Order < ActiveRecord::Base
  attr_accessible :order_state_id
  
  belongs_to :order_state
  has_many :order_items
end
