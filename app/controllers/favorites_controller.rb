class FavoritesController < ApplicationController
  def index
    
  end
  
  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy

    respond_to do |format|
      format.html { redirect_to favorites_url }
      format.json { head :no_content }
    end
  end
end
