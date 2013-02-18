# coding: utf-8
class CartController < ApplicationController
  
  def check_sum
    @cart['summ'] = 0
    
    @cart['items'].each do |id, product_item|
      @cart['items'][id]['ins'].each do |i, cart_item|
        @cart['summ'] += product_item['attrs']['price']*(100 - [product_item['attrs']['promo_discount'].to_i, product_item['attrs']['discount'].to_i].max)/100*cart_item['count']
        
      end
    end
    
    @cart['summ'] = @cart['summ'].to_i
  end
  
  def check_promos
    @cart['items'].each do |id, product_item|
      product_item['attrs']['promo_discount'] = 0
      product_item['attrs']['promo'] = false
    end
    
    promos = Promo.published
    
    promos.each do |promo|
      discount = true
      
      promo.promo_items.each do |item|
        counter = 0
        
        if @cart['items'].has_key?(item.product_id)
          
          @cart['items'][item.product_id]['ins'].each do |j, cart_item|
            counter += cart_item['count']
          end
          
          if counter < item.count.to_i
            discount = false
          end
          
        else
            discount = false
        end
        
      end
      
      if discount
        promo.promo_items.each do |item|
            @cart['items'][item.product_id]['attrs']['promo'] = discount
            @cart['items'][item.product_id]['attrs']['promo_discount'] = promo.discount
        end
      end
      
      @cart['promos'][promo.id] = {'discount' => discount}
    end
    
    self.check_sum
    
    session[:cart] = @cart
  end
  
  def add_item
    @product_instance = ProductInstance.find(params[:instance])
    @product = @product_instance.product
    @count = params[:count] || 1
    @count = @count.to_i
    
    if !@cart['items'].has_key?(@product.id)
      @cart['items'][@product.id] = {'ins' => {}}
    end
    
    if @cart['items'][@product.id]['ins'].has_key?(params[:instance])
      @cart['items'][@product.id]['ins'][params[:instance]]['count'] += @count
    else
      @cart['items'][@product.id]['attrs'] = @product.attributes
      @cart['items'][@product.id]['ins'][params[:instance]] = @product_instance.attributes
      @cart['items'][@product.id]['ins'][params[:instance]]['count'] = @count
      @cart['items'][@product.id]['ins'][params[:instance]]['img'] = @product.pictures.first.image.url(:medium)
      @cart['items'][@product.id]['ins'][params[:instance]]['color'] = @product.color if @product.color?
    end
    
    @cart['count'] += @count
    #@cart['summ'] += @cart['items'][@product.id]['attrs']['price']*@count
    
    self.check_promos
    
    respond_to do |format|
      format.html { redirect_to cart_index_url }
      format.json { render json: {cart: @cart, id: @product.id} }
    end
  end
  
  def remove_item
    @product_instance = ProductInstance.find(params[:instance])
    @product = @product_instance.product
    @removed_item = Marshal.load(Marshal.dump(@cart['items'][@product.id]))
    
    @cart['count'] -= @cart['items'][@product.id]['ins'][params[:instance]]['count']
    #@cart['summ'] -= @cart['items'][@product.id]['attrs']['price']*@cart['items'][@product.id]['ins'][params[:instance]]['count']
    
    @cart['items'][@product.id]['ins'].delete(params[:instance])
    
    if @cart['items'][@product.id]['ins'].empty?
      @cart['items'].delete(@product.id)
    end
    
    self.check_promos
    
    respond_to do |format|
      format.html { redirect_to cart_index_url, notice: 'Товар удален из корзины' }
      format.json { render json: {cart: @cart, product: @removed_item} }
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
    p_id = params[:product_id].to_i
    id = params[:id]
    count = params[:count].to_i
    
    if params[:count].to_i.to_s == params[:count] && count > 0
      @cart['count'] += ( count - @cart['items'][p_id]['ins'][id]['count'] )
      @cart['summ'] += ( count - @cart['items'][p_id]['ins'][id]['count'] )*@cart['items'][p_id]['attrs']['price']
      @cart['items'][p_id]['ins'][id]['count'] = count

      self.check_promos

      respond_to do |format|
        format.html { redirect_to cart_index_url, notice: 'Корзина обновлена' }
      end
    else
      respond_to do |format|
        format.html { redirect_to cart_index_url, notice: 'Введено некоректное значение' }
      end
    end
    
  end
  
end
