class CartController < ApplicationController
  
  def cart_add_item
    @product = Product.find(params[:id])
    
    if @cart['items'].has_key?(params[:id])
      @cart['items'][params[:id]]['count'] += 1
    else
      @cart['items'][params[:id]] = @product.attributes
      @cart['items'][params[:id]]['count'] = 1
      @cart['items'][params[:id]]['img'] = @product.pictures.first.image.url(:medium)
    end
    
    @cart['count'] += 1
    @cart['summ'] += @cart['items'][params[:id]]['price']
    
    session[:cart] = @cart
    
    respond_to do |format|
      format.html { render :partial => 'shared/cart' }
    end
  end
  
  def cart_remove_item
    @cart['count'] -= @cart['items'][params[:id]]['count']
    @cart['summ'] -= @cart['items'][params[:id]]['price']*@cart['items'][params[:id]]['count']
    
    @cart['items'].delete(params[:id])
    
    session[:cart] = @cart
    
    respond_to do |format|
      format.html { render :partial => 'shared/cart' }
    end
  end
  
end
