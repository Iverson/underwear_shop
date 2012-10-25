class Product < ActiveRecord::Base
  attr_accessible :brand_id, :description, :discount, :name, :price, :purchaise_price, :section_id, :country_id, :state_id, :pictures_attributes, :uri
  
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
  
  def preview_medium
    pictures.first.image.url(:medium)
  end
  
  def preview_catalog
    pictures.first.image.url(:catalog)
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
