class Product < ActiveRecord::Base
  attr_accessible :brand_id, :description, :discount, :name, :price, :purchaise_price, :section_id, :country_id, :state_id, :pictures_attributes
  
  belongs_to :country
  belongs_to :section
  belongs_to :state
  has_many :pictures, :dependent => :destroy
  has_many :orders
  has_many :order_item
  
  validates :name, :presence => true
  validates :price, :presence => true
  validates :section_id, :presence => true
  
  accepts_nested_attributes_for :pictures, :allow_destroy => true
  
  def preview_url
    pictures.first.image.url(:medium)
  end


end
