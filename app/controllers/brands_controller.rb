class BrandsController < ApplicationController
  def index
    @brands = Brand.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end
  
  # GET /brands/new
  # GET /brands/new.json
  def new
    @brand = Brand.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brand }
    end
  end
  
  # POST /brands
  # POST /brands.json
  def create
    @brand = Brand.new(params[:brand])

    respond_to do |format|
      if @brand.save
        format.html { redirect_to brands_url, notice: 'Brand was successfully created.' }
        format.json { render json: @brand, status: :created, location: @brand }
      else
        format.html { render action: "new" }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end
end
