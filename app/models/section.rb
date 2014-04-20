class Section < ActiveRecord::Base
  attr_accessible :name, :parent_id, :uri, :yml_parent_id, :yml_category, :description, :top
  
  scope :top, order('top DESC')
  
  has_many :products, :dependent => :destroy
  
  validates :name, :presence => true
  validates :yml_parent_id, :presence => true
  validates :yml_category, :presence => true
  
  has_ancestry :cache_depth => true
  
  def to_param
    "#{uri}"
  end
  
  before_save() do
    if self.uri.empty?
      self.uri = "#{self.name}".parameterize
    end
  end
end
