# coding: utf-8
class Delivery < ActiveRecord::Base
  scope :courier, :conditions => { :code => "courier" }
  
  attr_accessible :name, :price, :code
  has_many :orders
  
  validates :name, :presence => true
  
  def calc_price(cart_summ)
    if cart_summ > SiteConfiguration.free_shipping_minimum
      0
    else
      SiteConfiguration.shipping_price
    end
  end
  
  def price_to_s(cart_summ)
    
    if self.calc_price(cart_summ) > 0
      "#{self.calc_price(cart_summ).to_i} руб."
    else
      "<span class=\"free-tax\">бесплатно</span>".html_safe
    end
  end
end
