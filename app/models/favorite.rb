class Favorite < ActiveRecord::Base
  attr_accessible :product_id, :user_id
  
  belongs_to :product
  belongs_to :user
end
