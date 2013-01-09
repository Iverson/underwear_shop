class Address < ActiveRecord::Base
  attr_accessible :address, :city, :fio, :phone, :email, :user_id, :order_id
  
  belongs_to :addressable, :polymorphic => true
  
  validates :address, :presence => true
  validates :city, :presence => true
  
  validates :phone, :presence => true, 
                      :length => {:minimum => 5, :maximum => 20},
                      :format => {:with => /^([0-9\(\)\/\+ \-]*)$/}
                      
  validates :fio,  :presence => true, 
                      :length => {:minimum => 1, :maximum => 100}

  validates :email, :presence => true, 
                      :length => {:minimum => 5, :maximum => 100},
                      :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  
end
