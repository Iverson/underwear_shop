class StaticController < ApplicationController
  def show
    render :action => params[:page] rescue not_found
  end
end
