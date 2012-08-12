class Order < ActiveRecord::Base
  attr_accessible :order_state_id, :address_id, :user_id
  
  belongs_to :order_state
  has_many :order_items
  belongs_to :address
  belongs_to :user
  
end
