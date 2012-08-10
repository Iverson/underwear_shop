class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :init_cart
  
  def init_cart
    session[:cart] ||= {'summ' => 0, 'count' => 0, 'items' => {}, 'checkout_step' => 1}
    
    if user_signed_in?
      
      if session[:cart]['checkout_step'] < 2
        session[:cart]['checkout_step'] = 2
      end
      
    else
      session[:cart]['checkout_step'] = 1
    end
    
    @cart = session[:cart]
  end
  
end
