class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :require_http_basic_auth if Rails.env == "staging"
  before_filter :init_cart
  
  
  add_breadcrumb I18n.t("breadcrumbs.homepage"), "/"
  
  def init_cart
    session[:cart] ||= {'summ' => 0, 'count' => 0, 'items' => {}, 'checkout_step' => 1, 'order_id' => 0}
    
    if user_signed_in? && session[:cart]['checkout_step'] < 2
     
      session[:cart]['checkout_step'] = 2

    end
    
    @cart = session[:cart]
  end
  
  def after_sign_up_path_for(resource)
    "http://google.com"
  end
  
  def require_http_basic_auth
    authenticate_or_request_with_http_basic 'Staging' do |name, password|
      name == 'zeleniy' && password == 'slonik'
    end
  end
  
end
