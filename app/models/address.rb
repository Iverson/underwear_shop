class Address < ActiveRecord::Base
  attr_accessible :address, :city, :fio, :phone, :email, :user_id, :orders_attributes
  
  belongs_to :user
  has_one :order
  
  accepts_nested_attributes_for :order
end
