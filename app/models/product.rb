class Product < ActiveRecord::Base
  attr_accessible :brand_id, :description, :discount, :name, :price, :purchaise_price, :section_id, :country_id, :state_id, :pictures_attributes, :uri
  
  belongs_to :country
  belongs_to :section
  belongs_to :state
  belongs_to :brand
  has_many :pictures, :dependent => :destroy
  has_many :orders
  has_many :order_item
  has_many :favorites, :dependent => :destroy
  
  validates :name, :presence => true
  validates :price, :presence => true
  validates :section_id, :presence => true
  
  accepts_nested_attributes_for :pictures, :allow_destroy => true
  
  def preview_medium
    pictures.first.image.url(:medium)
  end
  
  def preview_catalog
    pictures.first.image.url(:catalog)
  end
  
  def preview_detail
    pictures.first.image.url(:detail)
  end
  
  def preview_zoom
    pictures.first.image.url(:zoom)
  end
  
  before_save() do
    if self.uri.empty?
      self.uri = "#{self.name}".parameterize
    end
  end
  
  def to_param
    "#{uri}"
  end

end
