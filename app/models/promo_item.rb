class PromoItem < ActiveRecord::Base
  attr_accessible :count, :product_id, :promo_id
  
  belongs_to :promo
  belongs_to :product
end
