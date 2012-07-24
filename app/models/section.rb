class Section < ActiveRecord::Base
  attr_accessible :name, :parent_id
  
  has_many :products, :dependent => :destroy
  
  has_ancestry :cache_depth => true
end
