class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :require_http_basic_auth if Rails.env == "staging"
  before_filter :init_cart
  before_filter :bestsellers
  before_filter :top_promo
  before_filter :brands
  
  add_breadcrumb I18n.t("breadcrumbs.homepage"), "/"
  
  def init_cart
    if session[:cart] && session[:cart][:order_finished]
      @order_finished = true
      session[:cart] = nil
    end
    
    session[:cart] ||= {'summ' => 0, 'count' => 0, 'items' => {}, 'checkout_step' => 1, 'order_id' => 0, 'promos' => {}}
    
    if session[:cart]['checkout_step'] < 2
     
      session[:cart]['checkout_step'] = 2

    end
    
    @cart = session[:cart]
  end
  
  def bestsellers
    if OrderItem.count > 0
      @bestsellers = Product.includes(:pictures, :section).order('order_items_count desc').limit(3)
    end
    
  end
  
  def after_sign_up_path_for(resource)
    "http://google.com"
  end
  
  def require_http_basic_auth
    authenticate_or_request_with_http_basic 'Staging' do |name, password|
      name == 'zeleniy' && password == 'slonik'
    end
  end
  
  def top_promo
    @top_promo = Promo.top.first
  end
  
  def brands
    @brands_all = Brand.all
    @delivery_by_courier = Delivery.courier.first
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
end
