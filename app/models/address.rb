class Address < ActiveRecord::Base
  attr_accessible :address, :city, :fio, :phone, :email, :user_id, :order_id
  
  belongs_to :addressable, :polymorphic => true
  
  validates :address, :presence => true
  validates :city, :presence => true
  validates :phone, :presence => true
  validates :fio, :presence => true
  validates :email, :presence => true
  
end
