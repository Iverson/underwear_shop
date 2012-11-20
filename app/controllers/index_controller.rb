class IndexController < ApplicationController
  
  def index
    @products = Product.limit(6)
    @promos = Promo.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
