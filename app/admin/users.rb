ActiveAdmin.register User do
  menu :label => proc{ I18n.t("active_admin.users") }, :parent => I18n.t("active_admin.site_configuration")
  
  index do
    column :id
    column :email
    column :created_at
    default_actions
  end
end
