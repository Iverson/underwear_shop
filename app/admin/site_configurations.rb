ActiveAdmin.register SiteConfiguration do
  actions :all, :except => [:show]
 
  before_filter do
    @skip_sidebar = true
  end
 
  config.comments = false
  config.clear_action_items!
 
  controller do
    def index
      params[:action] = "Site Configuration" # for the active admin title
      render 'admin/settings/index', :layout => 'active_admin'
    end
    def update
      params[:update_site_configuration].each do |setting, value|
        SiteConfiguration.send("#{setting}=", value)
      end
      redirect_to :back, notice: "Settings Saved"
    end
    
  end
 
end