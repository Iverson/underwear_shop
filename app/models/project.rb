class Project < ActiveRecord::Base
  attr_accessible :desc, :name
  
  validates :name, :presence => true
end
