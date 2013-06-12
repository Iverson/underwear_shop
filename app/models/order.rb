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
  
  after_update :send_email_if_paid
  
  def summ
    self.order_items.sum{|item| item.price*item.count}.to_i+self.delivery.price.to_i
  end
  
  def count
    self.order_items.sum(:count)
  end
  
  def send_email_if_paid
    if self.can_send_email && self.order_state.status == "paid" && self.address.email?
      UserMailer.order_paid_email(self).deliver
      self.can_send_email = false
      self.save
    end
  end

end
