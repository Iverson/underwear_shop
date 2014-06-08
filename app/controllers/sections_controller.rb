# coding: utf-8
class SectionsController < ApplicationController
  
  # GET /sections/1
  # GET /sections/1.json
  def show
    @per_page = params[:limit] || 'all'
    
    if @per_page == 'all'
      @per_page = nil
    end
    
    @section = Section.where(:uri => params[:id]).first || not_found
    @active_section_id = @section.id
    @active_parent_id  = @section.parent.try(:id)
    @seo_key = "мужские #{@section.name.mb_chars.downcase.to_s}"

    if @section.has_children?
      subsections_ids = @section.child_ids.push(@section.id)
      @products = Product.where(section_id: subsections_ids)
    else
      @products = @section.products
    end

    @products = @products.puplished.includes(:pictures, :product_instances).top.order(params[:sort_by]).paginate(:page => params[:page], :per_page => @per_page)

    @title = "Купить мужские #{@section.name.mb_chars.downcase.to_s} с бесплатной доставкой в интернет магазине YoungLovers.ru"
    
    add_breadcrumb "<span>#{@section.name}</span>", section_url

    respond_to do |format|
      format.html { render } # show.html.erb
      format.json { render json: @section }
    end
  end

end
