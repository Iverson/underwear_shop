class Address < ActiveRecord::Base
  attr_accessible :address, :city, :fio, :phone, :email, :user_id, :order_id
  
  belongs_to :addressable, :polymorphic => true
  
  validates :phone, :presence => true, 
                      :length => {:minimum => 5, :maximum => 20},
                      :format => {:with => /^([0-9\(\)\/\+ \-]*)$/}
                      
  validates :fio,  :presence => true, 
                      :length => {:minimum => 1, :maximum => 100}

end
