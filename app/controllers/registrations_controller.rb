class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if params[:redirect]
      params[:redirect]
    else
      root_path
    end
  end
end