# coding: utf-8
class Delivery < ActiveRecord::Base
  scope :courier, :conditions => { :code => "courier" }
  
  attr_accessible :name, :price, :code
  has_many :orders
  
  validates :name, :presence => true
  
  def price_to_s
    if self.price > 0
      "#{self.price.to_i} руб."
    else
      "<span class=\"free-tax\">бесплатно</span>".html_safe
    end
  end
end
