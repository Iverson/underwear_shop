class Brand < ActiveRecord::Base
  attr_accessible :country_id, :name
  belongs_to :country
end
