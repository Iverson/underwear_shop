ActiveAdmin.register Brand do
  menu :label => proc{ I18n.t("active_admin.brands") }, :parent => I18n.t("active_admin.products"), :priority => 3
  
  actions :all, :except => [:show]
end
