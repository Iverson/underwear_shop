class Order < ActiveRecord::Base
  attr_accessible :order_state_id, :user_id, :delivery_id, :address_attributes, :comment
  
  belongs_to :order_state
  belongs_to :delivery
  has_many :order_items
  has_one :address, :as => :addressable
  belongs_to :user
  
  accepts_nested_attributes_for :address
end
