class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :init_cart
  
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
  
end
