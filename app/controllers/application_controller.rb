class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :init_cart
  
  def init_cart
    session[:cart] ||= {'summ' => 0, 'count' => 0, 'items' => {}, 'checkout_step' => 1}
    
    if user_signed_in?
      @checkout_step = 2
    else
      @checkout_step = 1
    end
    
    session[:cart]['checkout_step'] = @checkout_step
    
    @cart = session[:cart]
  end
  
end
