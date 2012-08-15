# coding: utf-8
class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end
  
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end
  
  def create
    @order = Order.new(params[:order])
    
    if user_signed_in?
      @order.user_id = current_user.id
    end

    respond_to do |format|
      if @order.save
        session[:cart]['checkout_step'] = 3
        session[:cart]['order_id'] = @order.id
        
        format.html { redirect_to cart_checkout_url, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { redirect_to cart_checkout_url }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @order = Order.find(@cart['order_id'])
    
    respond_to do |format|
      if @order.update_attributes(params[:order])
        if @order.delivery_id != nil
          session[:cart]['checkout_step'] = 4
        end
        
        format.html { redirect_to cart_checkout_url, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "cart_checkout_url" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    @order = Order.find(@cart['order_id'])
    
    @cart['items'].each do |id, cart_item|
      OrderItem.create({:order_id => @cart['order_id'], :product_id => cart_item['id'], :name => cart_item['name'], :price => cart_item['price'], :count => cart_item['count']  })
    end
    
    respond_to do |format|
      if @order.update_attributes(params[:order])
        session[:cart] = nil
        
        format.html { redirect_to root_url, notice: 'Ваш заказ принят, на ваш E-mail выслано письмо с информацией по заказу.' }
        format.json { head :no_content }
      else
        format.html { render action: "cart_checkout_url" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
end
