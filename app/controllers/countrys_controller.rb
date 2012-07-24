class CountrysController < ApplicationController
  def index
    @countrys = Country.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @countrys }
    end
  end
  
  # DELETE /countrys/1
  # DELETE /countrys/1.json
  def destroy
    @country = Country.find(params[:id])
    @country.destroy

    respond_to do |format|
      format.html { redirect_to countrys_url }
      format.json { head :no_content }
    end
  end
end
