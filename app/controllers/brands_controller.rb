# coding: utf-8
class BrandsController < ApplicationController
  
  # GET /sections/1
  # GET /sections/1.json
  def show
    @per_page = params[:limit] || 'all'
    
    if @per_page == 'all'
      @per_page = nil
    end
    
    @brand = Brand.find(params[:id])
    @products = @brand.products.order(params[:sort_by]).order("discount DESC").paginate(:page => params[:page], :per_page => @per_page)
    @title = "Купить мужскую одежду #{@brand.name} в интернет магазине YoungLovers.ru"
    
    add_breadcrumb @brand.name, brand_url

    respond_to do |format|
      format.html { render :layout => "application" } # show.html.erb
      format.json { render json: @section }
    end
  end
  
end
