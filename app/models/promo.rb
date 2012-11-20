class Promo < ActiveRecord::Base
  attr_accessible :discount, :name, :price, :state_id, :text, :promo_image_attributes, :promo_items_attributes
  
  belongs_to :state
  has_one :promo_image, :dependent => :destroy
  has_many :promo_items, :dependent => :destroy
  
  accepts_nested_attributes_for :promo_image, :allow_destroy => true
  accepts_nested_attributes_for :promo_items, :allow_destroy => true
  
  def sum
    self.promo_items.sum{|item| item.product.price}.to_i
  end
end
