# coding: utf-8
class Promo < ActiveRecord::Base
  scope :published, :conditions => { :state_id => 2 }
  
  attr_accessible :discount, :name, :price, :state_id, :text, :promo_image_attributes, :promo_items_attributes
  
  belongs_to :state
  has_one :promo_image, :dependent => :destroy
  has_many :promo_items, :dependent => :destroy
  
  accepts_nested_attributes_for :promo_image, :allow_destroy => true
  accepts_nested_attributes_for :promo_items, :allow_destroy => true
  
  def sum
    if self.price
      self.price.to_i
    else
      self.promo_items.sum{|item| item.product.price*item.count}.to_i*(100-self.discount.to_i)/100
    end
  end
end
