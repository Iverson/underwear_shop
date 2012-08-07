class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :init_cart
  
  def init_cart
    session[:cart] ||= {'summ' => 0, 'count' => 0, 'items' => {}}
    
    @cart = session[:cart]
  end
  
end
