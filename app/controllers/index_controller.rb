class IndexController < ApplicationController
  layout 'index'
  
  def index
    @products = Product.limit(6)

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
