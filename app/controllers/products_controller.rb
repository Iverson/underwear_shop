# coding: utf-8
class ProductsController < ApplicationController
  require 'csv'
  
  before_filter :price_http_auth, :only => [:export_yml] if Rails.env == "production"
  
  def index
    @products = Product.all
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new
    5.times { @product.pictures.build }
    
    @roots = Section.roots

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.where(:uri => params[:id]).first
    (5 - @product.pictures.length).times { @product.pictures.build }
  
    @roots = Section.roots
   
  end

  def show
    @product = Product.where(:uri => params[:id]).first
    @similar_products = @product.section.products.where("id != ?", @product.id).limit(6)
    @title = "#{@product.name} купить за #{@product.final_price} руб. в интернет магазине Young Lovers, доставка бесплатно"
    
    add_breadcrumb @product.section.name, section_url(@product.section)
    add_breadcrumb @product.name, product_url
    
    respond_to do |format|
      format.html { render :layout => "application" } # show.html.erb
      format.json { render json: @product }
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_url, notice: 'product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.where(:uri => params[:id]).first

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to products_url, notice: 'product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def to_favorite
    
    if !Favorite.exists?(:user_id => params[:params][:user_id], :product_id => params[:params][:product_id])
      @favorite = Favorite.new(params[:params])
      @favorite.save
      
      @response = {:add => true, :count => current_user.favorites.length}
    else
      @response = {:add => false}
    end

    respond_to do |format|
      format.json { render json: @response.to_json.html_safe, status: :created, location: products_url }
    end
  end
  
  def instances
    @product_instances = ProductInstance.where(:product_id => params[:id])
    
    respond_to do |format|
      format.json { render json: @product_instances }
    end
  end
  
  def search
  
    add_breadcrumb "Search", search_path
    if params[:q] != ""
      @products = Product.search(params[:q])
    else
      redirect_to :back
    end
  end
  
  def export_csv
    @products = Product.published
    products_csv = CSV.generate do |csv|
      # header row
      csv << ["id", "type", "available", "url", "price", "currencyId", "category", "picture", "delivery", "local_delivery_cost", "typePrefix", "vendor", "model", "description"]
      # data row
      @products.each do |p|
        csv << [p.id, "vendor.model", "true", product_url(p.uri), p.final_price, "RUR", p.section.name, "#{request.protocol}#{request.host_with_port}#{p.preview(:zoom)}", "true", "250", p.section.name, p.brand.name, p.name, p.description]
      end
    end

    send_data(products_csv, :type => 'test/csv', :filename => 'products.csv')
  end
  
  def export_yml
    @products = Product.published
    @sections = Section.all
    
    respond_to do |format|
      format.xml # index.xml.builder
    end
  end
  
  def price_http_auth
    authenticate_or_request_with_http_basic 'YML Price' do |name, password|
      name == 'yml_parser' && password == 'qAs2Mg2b3jK5q'
    end
  end
  
end
