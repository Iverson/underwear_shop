class AddressController < ApplicationController
  def edit
    @address = Address.where(user_id: current_user.id).first_or_initialize
  end
  
  def update
    @address = Address.find(1)
    
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
