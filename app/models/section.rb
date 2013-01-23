class Section < ActiveRecord::Base
  attr_accessible :name, :parent_id, :uri, :yml_parent_id
  
  has_many :products, :dependent => :destroy
  
  validates :name, :presence => true
  
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
