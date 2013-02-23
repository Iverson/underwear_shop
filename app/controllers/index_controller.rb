class IndexController < ApplicationController
  
  def index
    @products = Product.where("price > 1000").order("discount DESC").limit(16)
    @rendered = 0
    @promos = Promo.published.order("created_at DESC")
    @index = true

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
