class Product < ActiveRecord::Base
  RU_SIZES = {"S" => "46, 48", "M" => "48,50", "L" => "50,52", "XL" => "52,54", "XXL" => "54,56"}
  
  default_scope :conditions => { :state_id => 2 }
  scope :top, order('top DESC')
  
  Section.all.each do |section|
    scope section.name.gsub(/\s+/, "_"), where(:section_id => section.id)
  end
  
  attr_accessible :brand_id, :description, :discount, :name, :price, :purchaise_price, :section_id, 
  :country_id, :state_id, :pictures_attributes, :product_instances_attributes, :uri, :color, :matter, :top
  
  belongs_to :country
  belongs_to :section
  belongs_to :state
  belongs_to :brand
  has_many :product_instances, :dependent => :destroy
  has_many :pictures, :dependent => :destroy
  has_many :orders
  has_many :order_item
  has_many :favorites, :dependent => :destroy
  has_many :promo_items, :dependent => :destroy
  
  validates :name, :presence => true
  validates :price, :presence => true
  validates :section_id, :presence => true
  
  accepts_nested_attributes_for :pictures, :allow_destroy => true
  accepts_nested_attributes_for :product_instances, :allow_destroy => true
  
  define_index do
    indexes name
    
  end
  
  def final_price
    (self.price*(1 - self.discount.to_f / 100)).to_i
  end
  
  def preview(size)
    pictures.first.image(size)
  end
  
  def preview_medium
    preview(:medium)
  end
  
  def fast_to_cart
    if !sizes?
      product_instances.first.id
    end
  end
  
  def sizes?
    if product_instances.length == 1 && product_instances.first.size == "all"
      false
    else
      true
    end
  end
  
  def in_stock?
    product_instances.sum(:count) > 0
  end
  
  def select_title
     "(#{self.id}) #{self.name}. #{self.color}"
  end
  
  before_save() do
    id = self.id
    if self.new_record?
      
      if Product.last
        id = Product.last.id+1
      else
        id = 1
      end
      
    end
    if self.uri.empty?
      self.uri = "#{self.name}".parameterize
    end
    if Product.where("uri = '#{self.uri}' AND NOT id = #{id}").exists?
      self.uri += "-#{id}"
    end
  end
  
  def to_param
    "#{uri}"
  end
  
  def ru_sizes
    sizes = []
    self.product_instances.in_stock.each do |instance|
      
      if instance.size.to_i.to_s == instance.size
        sizes.push instance.size
      else
        RU_SIZES[instance.size].gsub(/\s+/, "").split(',').each do |size|
          sizes.push size if !sizes.include? size
        end
      end
      
    end
    sizes
  end

end
