# coding: utf-8
class CartController < ApplicationController
  
  
  
  def add_item
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
      format.json { render json: @cart.to_json.html_safe }
    end
  end
  
  def remove_item
    @cart['count'] -= @cart['items'][params[:id]]['count']
    @cart['summ'] -= @cart['items'][params[:id]]['price']*@cart['items'][params[:id]]['count']
    
    @cart['items'].delete(params[:id])
    
    session[:cart] = @cart
    
    respond_to do |format|
      format.html { redirect_to cart_index_url, notice: 'Товар удален из корзины' }
      format.json { render json: @cart.to_json.html_safe }
    end
  end
  
  def index
    add_breadcrumb I18n.t("breadcrumbs.cart"), cart_index_url
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @section }
    end
    
  end
  
  def update
    if params[:count].to_i.to_s == params[:count] && params[:count].to_i > 0
      @cart['count'] += ( Integer(params[:count]) - @cart['items'][params[:id]]['count'] )
      @cart['summ'] += ( Integer(params[:count]) - @cart['items'][params[:id]]['count'] )*@cart['items'][params[:id]]['price']
      @cart['items'][params[:id]]['count'] = Integer(params[:count])

      session[:cart] = @cart

      respond_to do |format|
        format.html { redirect_to cart_index_url, notice: 'Корзина обновлена' }
      end
    else
      respond_to do |format|
        format.html { redirect_to cart_index_url, notice: 'Введено некоректное значение' }
      end
    end
    
  end
  
  def checkout
    if @cart['count'] == 0
      redirect_to(cart_index_url) and return
    
    end
    
    if @cart['order_id'] > 0
      @order_action = "/order/update"
      @order = Order.find(@cart['order_id'])
    
    else
      @order_action = "/order/create"
      @order = Order.new

      if user_signed_in?
        #@order.build_address({:address => current_user.address.address, :phone => current_user.phone, :city => current_user.address.city, :fio => current_user.fio, :email => current_user.email})
      else
        #@order.build_address()
      end
      
    end
    
    respond_to do |format|
      format.html
    end
    
  end
  
  def finish
    respond_to do |format|
      format.html
    end
  end
  
end
