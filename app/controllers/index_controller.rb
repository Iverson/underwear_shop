class IndexController < ApplicationController
  
  def index
    @products = Product.limit(8)
    @promos = Promo.published

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
