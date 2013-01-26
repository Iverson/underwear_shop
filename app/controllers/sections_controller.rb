# coding: utf-8
class SectionsController < ApplicationController
  layout "admin"
  
  def index
    @sections = Section

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sections }
    end
  end
  
  # GET /sections/1
  # GET /sections/1.json
  def show
    @per_page = params[:limit] || 'all'
    
    if @per_page == 'all'
      @per_page = nil
    end
    
    @section = Section.where(:uri => params[:id]).first
    @products = @section.products.order(params[:sort_by]).order("discount DESC").paginate(:page => params[:page], :per_page => @per_page)
    @title = "Купить мужские #{@section.name.mb_chars.downcase.to_s} в интернет-магазине YoungLovers.ru"
    
    add_breadcrumb @section.name, section_url

    respond_to do |format|
      format.html { render :layout => "application" } # show.html.erb
      format.json { render json: @section }
    end
  end
  
  # GET /sections/new
  # GET /sections/new.json
  def new
    @section = Section.new(:parent_id => params[:parent_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @section }
    end
  end
  
  # GET /section/1/edit
  def edit
    @section = Section.where(:uri => params[:id]).first
  end
  
  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(params[:section])

    respond_to do |format|
      if @section.save
        format.html { redirect_to sections_url, notice: 'Section was successfully created.' }
        format.json { render json: @section, status: :created, location: @section }
      else
        format.html { render action: "new" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /sections/1
  # PUT /sections/1.json
  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        format.html { redirect_to sections_url, notice: 'section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to sections_url }
      format.json { head :no_content }
    end
  end
end
