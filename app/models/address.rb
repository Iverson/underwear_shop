class Address < ActiveRecord::Base
  attr_accessible :address, :city, :fio, :phone, :email, :user_id, :order_id
  
  belongs_to :addressable, :polymorphic => true
  
  validates :phone, :presence => true, 
                      :length => {:minimum => 10, :maximum => 20},
                      :format => {:with => /^([0-9\(\)\/\+ \-]*)$/}
                      
  validates :fio,  :presence => true, 
                      :length => {:minimum => 3, :maximum => 50}
  
  validates :email, 
  :length => {:minimum => 5, :maximum => 100, :if => :email? },
  :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :if => :email? }

end
