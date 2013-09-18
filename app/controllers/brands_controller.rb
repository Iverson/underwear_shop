# coding: utf-8
class BrandsController < ApplicationController
  
  # GET /sections/1
  # GET /sections/1.json
  def show
    @per_page = params[:limit] || 'all'
    
    if @per_page == 'all'
      @per_page = nil
    end
    
    @brand = Brand.where(:uri => params[:id]).first || not_found
    brand_sections_ids = @brand.products.puplished.group(:section_id).pluck(:section_id)
    brand_sections = Section.all.select { |section| brand_sections_ids.include?(section.id) }
    @products = @brand.products.puplished.includes(:pictures, :product_instances).order(params[:sort_by]).order("price DESC, discount DESC").paginate(:page => params[:page], :per_page => @per_page)
    @title = "#{@brand.name} | #{brand_sections.map{|s| s.name.mb_chars.downcase.to_s}.join(", ")} #{@brand.name} в интернет магазине YoungLovers.ru"
    
    add_breadcrumb "<span>#{@brand.name}</span>", brand_url

    respond_to do |format|
      format.html { render } # show.html.erb
      format.json { render json: @section }
    end
  end
  
end
