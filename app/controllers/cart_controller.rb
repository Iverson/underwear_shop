class CartController < ApplicationController
  
  def addItem
    
    
    @brands = Brand.all

    respond_to do |format|
      format.json { render json: @projects }
    end
    
  end
  
end
