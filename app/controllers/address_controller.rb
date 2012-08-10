class AddressController < ApplicationController
  def edit
    @address = Address.new(:user_id => current_user.id)
  end
  
  def update
    #Address.find(:user_id = current_user.id)
  end
end
