class OrderItem < ActiveRecord::Base
  attr_accessible :count, :name, :order_id, :price, :product_id, :size
  
  belongs_to :order
  belongs_to :product, :counter_cache => true
end
