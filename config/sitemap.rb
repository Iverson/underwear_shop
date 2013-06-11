Sitemap.configure do |config|
  config.max_urls = 10000
end

Sitemap::Generator.instance.load :host => APP_CONFIG['default_host'] do
  
  path :root, :priority => 1
  
  resources :sections, 
            :priority => 0.7, 
            :change_frequency => "weekly", 
            :skip_index => true
  
  resources :brands, 
            :priority => 0.7, 
            :change_frequency => "weekly", 
            :skip_index => true
  
  resources :products, 
            :priority => 0.7, 
            :change_frequency => "daily", 
            :skip_index => true
  
  # Sample path:
  #   path :faq
  # The specified path must exist in your routes file (usually specified through :as).

  # Sample path with params:
  #   path :faq, :params => { :format => "html", :filter => "recent" }
  # Depending on the route, the resolved url could be http://mywebsite.com/frequent-questions.html?filter=recent.

  # Sample resource:
  #   resources :articles

  # Sample resource with custom objects:
  #   resources :articles, :objects => proc { Article.published }

  # Sample resource with search options:
  #   resources :articles, :priority => 0.8, :change_frequency => "monthly"

  # Sample resource with block options:
  #   resources :activities,
  #             :skip_index => true,
  #             :updated_at => proc { |activity| activity.published_at.strftime("%Y-%m-%d") }
  #             :params => { :subdomain => proc { |activity| activity.location } }

end
