class Page < ActiveRecord::Base
  attr_accessible :name, :text1, :text2, :text3, :uri
  
  validates :name, :presence => true
  validates :uri, :presence => true
end
