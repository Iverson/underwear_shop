class Brand < ActiveRecord::Base
  attr_accessible :name, :uri
  
  has_many :products
  
  validates :name, :presence => true
  
  def to_param
    "#{uri}"
  end
  
  before_save() do
    if self.uri.empty?
      self.uri = "#{self.name}".parameterize
    end
  end
end
