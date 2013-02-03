class Order < ActiveRecord::Base
  attr_accessible :order_state_id, :user_id, :delivery_id, :address_attributes, :order_items_attributes, :comment
  
  belongs_to :order_state
  belongs_to :delivery
  has_many :order_items
  has_one :address, :as => :addressable
  belongs_to :user
  
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :order_items, :allow_destroy => true
  
  OrderState.all.each do |state|
    scope state.name, where(:order_state_id => state.id)
  end
  
  def summ
    self.order_items.sum{|item| item.price*item.count}+self.delivery.price
  end
  
  def count
    self.order_items.sum(:count)
  end

end
