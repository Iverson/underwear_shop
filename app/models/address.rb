class Address < ActiveRecord::Base
  attr_accessible :address, :city, :fio, :phone, :user_id
  
  belongs_to :user
end
