class AddressController < ApplicationController
  before_filter :authenticate_user!
  
  def edit
    @address = current_user.address
  end
  
  def update
    @address = current_user.address
    
    respond_to do |format|
      if @address.update_attributes(params[:address])
        format.html { redirect_to users_address_url, notice: 'Address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end
end
