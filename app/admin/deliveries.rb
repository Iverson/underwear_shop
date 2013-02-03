ActiveAdmin.register Delivery do
  menu :label => proc{ I18n.t("active_admin.deliveries") }, :parent => I18n.t("active_admin.orders")
end
