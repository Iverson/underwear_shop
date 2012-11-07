class Product < ActiveRecord::Base
  attr_accessible :brand_id, :description, :discount, :name, :price, :purchaise_price, :section_id, :country_id, :state_id, :pictures_attributes, :product_instances_attributes, :uri
  
  belongs_to :country
  belongs_to :section
  belongs_to :state
  belongs_to :brand
  has_many :product_instances, :dependent => :destroy
  has_many :pictures, :dependent => :destroy
  has_many :orders
  has_many :order_item
  has_many :favorites, :dependent => :destroy
  
  validates :name, :presence => true
  validates :price, :presence => true
  validates :section_id, :presence => true
  
  accepts_nested_attributes_for :pictures, :allow_destroy => true
  accepts_nested_attributes_for :product_instances, :allow_destroy => true
  
  def preview(size)
    if pictures.exists?
      pictures.first.image(size)
    end
  end
  
  def preview_medium
    preview(:medium)
  end
  
  def fast_to_cart
    if product_instances.length == 1
      product_instances.first.id
    end
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
