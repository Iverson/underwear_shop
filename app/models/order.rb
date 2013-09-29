class Order < ActiveRecord::Base
  attr_accessible :order_state_id, :user_id, :delivery_id, :address_attributes, :order_items_attributes, :comment, :state_event
  
  belongs_to :order_state
  belongs_to :delivery
  has_many :order_items
  has_one :address, :as => :addressable
  belongs_to :user
  
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :order_items, :allow_destroy => true
  
  after_update :send_email_if_paid
  
  state_machine :state, :initial => :created do
    after_transition :on => :pay, :do => :stock_items_decrement
    after_transition :on => :cashback, :do => :stock_items_increment
    
    state :created
    state :recived
    state :confirmed
    state :paid
    state :canceled
    
    event :recive do
      transition :created => :recived
    end
    
    event :confirm do
      transition all - [:confirmed, :paid] => :confirmed
    end
    
    event :pay do
      transition :confirmed => :paid
    end
    
    event :cancel do
      transition all - [:canceled, :paid] => :canceled
    end
    
    event :cashback do
      transition :paid => :canceled
    end
    
  end
  
  Order.state_machine.states.each do |state|
    scope state.human_name, :conditions => { :state => state.value }
  end
  
  def stock_items_decrement
    order_items = self.order_items.each do |item|
      product_instance = item.product.product_instances.where(size: item.size).first
      product_instance.count -= item.count
      product_instance.save
    end
  end
  
  def stock_items_increment
    order_items = self.order_items.each do |item|
      product_instance = item.product.product_instances.where(size: item.size).first
      product_instance.count += item.count
      product_instance.save
    end
  end
  
  def summ
    total = self.order_items.sum{|item| item.price*item.count}.to_i
  end
  
  def total
    summ = self.summ
    summ + self.delivery.calc_price(summ).to_i
  end
  
  def count
    self.order_items.sum(:count)
  end
  
  def send_email_if_paid
    if self.can_send_email && self.state == "paid" && self.address.email?
      UserMailer.order_paid_email(self).deliver
      self.can_send_email = false
      self.save
    end
  end

end