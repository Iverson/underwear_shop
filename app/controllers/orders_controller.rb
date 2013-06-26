# coding: utf-8
class OrdersController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :show]
  
  def index
    @orders = current_user.orders
  end
  
  def show
    @order = Order.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end
  
  def checkout
    if @cart['count'] == 0
      redirect_to(cart_index_url) and return
    
    end
    
    if @cart['order_id'] > 0
      @order = Order.find(@cart['order_id'])
    else
      @order = Order.new
      
      if user_signed_in?
        @order.build_address({:phone => current_user.phone, :fio => current_user.first_name})
      else
        @order.build_address({:city => "Москва"})
      end
      
    end
    
    respond_to do |format|
      format.html
    end
    
  end
  
  def create
    session[:cart]['checkout_step'] = 2
    @order = Order.new(params[:order])
    
    if user_signed_in?
      @order.user_id = current_user.id
      @order.address.email = current_user.email
      @order.address.city = current_user.address.city
      @order.address.address = current_user.address.address
    end
    
    respond_to do |format|
      if @order.save
        session[:cart]['checkout_step'] = 3
        session[:cart]['order_id'] = @order.id
        
        format.html { render :checkout }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render :checkout }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @order = Order.find(@cart['order_id'])
    
    respond_to do |format|
      if @order.update_attributes(params[:order])
        session[:cart]['checkout_step'] = 3
        
        format.html { render :checkout }
        format.json { head :no_content }
      else
        session[:cart]['checkout_step'] = 2
        
        format.html { render :checkout }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    @order = Order.find(@cart['order_id'])
    
    @cart['items'].each do |id, product_item|
      @cart['items'][id]['ins'].each do |i, cart_item|
        OrderItem.create({:order_id => @cart['order_id'], :product_id => product_item['attrs']['id'], :name => product_item['attrs']['name'], :size => cart_item['size'], :price => product_item['attrs']['price']*(100 - [product_item['attrs']['promo_discount'].to_i, product_item['attrs']['discount'].to_i].max)/100, :count => cart_item['count']  })
      end
    end
    
    respond_to do |format|
      if @order.update_attributes(params[:order])
        session[:cart][:order_finished] = true
        init_cart
        
        if @order.address.email?
          UserMailer.order_email(@order).deliver
        end
        
        format.html { render :finish }
        format.json { head :no_content }
      else
        format.html { render :checkout }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
end
