class IndexController < ApplicationController
  
  def index
    @products = Product.puplished.includes(:product_instances, :pictures).where("price > 1000").top.order("discount DESC").limit(12)
    @rendered = 0
    @promos = Promo.includes(:promo_image).published.order("created_at DESC")
    @index = true

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
