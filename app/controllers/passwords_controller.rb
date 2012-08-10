# coding: utf-8
class PasswordsController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = current_user
    
    render "devise/registrations/change_password"
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_with_password(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to edit_user_registration_path, notice: 'Пароль успешно изменен'
    else
      render "devise/registrations/change_password"
    end
  end
end